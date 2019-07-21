//
//  Results.swift
//  cpaChecker
//
//  Created by Steven Dito on 6/2/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import Foundation

struct Result {
    var totalUnits: Int
    var accountingUnits: Int
    var businessUnits: Int
    var ethicsUnits: Int
    var accountingClasses: [Class]
    var businessClasses: [Class]
    var ethicsClasses: [Class]
    var accountingClassesLeft: [Class]
    var businessClassesLeft: [Class]
    var ethicsClassesLeft: [Class]

    init(totalUnits: Int, accountingUnits: Int, businessUnits: Int, ethicsUnits: Int, accountingClasses: [Class], businessClasses: [Class], ethicsClasses: [Class], accountingClassesLeft: [Class], businessClassesLeft: [Class], ethicsClassesLeft: [Class]) {
        self.totalUnits = totalUnits
        self.accountingUnits = accountingUnits
        self.businessUnits = businessUnits
        self.ethicsUnits = ethicsUnits
        self.accountingClasses = accountingClasses
        self.businessClasses = businessClasses
        self.ethicsClasses = ethicsClasses
        self.accountingClassesLeft = accountingClassesLeft
        self.businessClassesLeft = businessClassesLeft
        self.ethicsClassesLeft = ethicsClassesLeft
    }
    
    static func calculateResult(units: [RealmUnits], key: String, realmClasses: [RealmClass]) -> Result {
        var setCourseNumbers: Set<String> = []
        
        var allClasses: [Class] {
            return SharedAllClasses.shared.sharedAllClasses.filter {setCourseNumbers.contains($0.courseNum)}
        }
        realmClasses.forEach { (rc) in
            setCourseNumbers.insert(rc.courseNum)
        }
        let classesUserIsTaking: [Class] = SharedAllClasses.shared.sharedAllClasses.filter { (course) -> Bool in
            setCourseNumbers.contains(course.courseNum)
        }
        // to have all classes using a standard unit valuation
        classesUserIsTaking.addQuarterUnits()
 
        var initialAccounting: [Class] = []
        var initialBusiness: [Class] = []
        var initialEthics: [Class] = []
        // to do initial sort and find status from there before moving classes into other sections besides their main
        for c in classesUserIsTaking {
            if c.mustBeEthics == true {
                initialEthics.append(c)
            } else if c.isAccounting == true {
                initialAccounting.append(c)
            } else if c.isEthics == true {
                initialEthics.append(c)
            } else if c.isBusiness == true {
                initialBusiness.append(c)
            }
        }
        
        var numberAccountingUnits = initialAccounting.sumOfQuarterUnits()
        var numberBusinessUnits = initialBusiness.sumOfQuarterUnits()
        var numberEthicsUnits = initialEthics.sumOfQuarterUnits()
        
        
        let accountingDifference = numberAccountingUnits - 45//Double(SharedUnits.shared.units["totalAccounting"]!)
        let businessDifference = numberBusinessUnits - 57//Double(SharedUnits.shared.units["totalBusiness"]!)
        let ethicsDifference = numberEthicsUnits - 15//Double(SharedUnits.shared.units["totalEthics"]!)
        // filter extra accounting units into business units without changing the classification of the classes
        if accountingDifference > 0.0 {
            numberBusinessUnits += accountingDifference
            numberAccountingUnits -= accountingDifference
        }
        // switch; if applicable, needed, and possible, extra ethics classes into business classes
        //let maxPossibleUnitsToSwitch = min(ethicsDifference, -businessDifference)
        let potentialClassesToSwitch = initialEthics.filter { (c) -> Bool in
            c.isBusiness == true && c.mustBeEthics == false
        }
        
        //now have an array of classes that could switch, and maximum units that could be switched, need to decide which classes to switch
        func decideWhatClassesToSwitch(classes: [Class], busNeeded: Double, ethExtra: Double, values: [[Class]]?, highest: [Class]?) -> [Class]? {
            var highestAmount: [Class]? = highest
            if classes.isEmpty == true || busNeeded <= 0 || ethExtra <= 0 {
                return nil
            } else if values == nil {
                var c: [[Class]] = []
                for course in classes {
                    if course.quarterUnits! >= busNeeded && course.quarterUnits! <= ethExtra {
                        return [course]
                    } else {
                        if course.quarterUnits! <= ethExtra && course.quarterUnits! > highestAmount?.first?.quarterUnits ?? 0 {
                            highestAmount = [course]
                        }
                        c.append([course])
                    }
                }
                if highestAmount?.first?.quarterUnits == ethExtra {
                    return highestAmount
                } else {
                    return decideWhatClassesToSwitch(classes: classes, busNeeded: busNeeded, ethExtra: ethExtra, values: c, highest: highestAmount)
                }
            } else if classes.sumOfQuarterUnits() >= busNeeded && classes.sumOfQuarterUnits() <= ethExtra {
                return classes
            } else if classes.count == 1 {
                if classes.first!.quarterUnits! <= ethExtra {
                    return classes
                }
            } else if (values != nil) && (values!.last!.count < classes.count) {
                var newValues: [[Class]] = []
                for ti in values! {
                    for classItem in classes {
                        if (classes.filter{$0 == classItem}.count) != (ti.filter{$0 == classItem}.count) {
                            var tempItem = ti
                            tempItem.append(classItem)
                            //print("class item: \(tempItem.map({$0.courseNum}))")
                            //print("\((tempItem.map({$0.quarterUnits!}).reduce(0.0, +))) && \((tempItem.map({$0.quarterUnits!}).reduce(0.0, +)))")
                            if (tempItem.sumOfQuarterUnits() >= busNeeded) && (tempItem.sumOfQuarterUnits() <= ethExtra) {
                                //highestAmount = tempItem
                                //print("Should be returning from deicdeWhatClasses: \(tempItem)")
                                return tempItem
                            } else {
                                newValues.append(tempItem)
                                if highestAmount != nil {
                                    if (tempItem.sumOfQuarterUnits() > highestAmount!.sumOfQuarterUnits()) && (tempItem.sumOfQuarterUnits() <= ethExtra) {
                                        highestAmount = tempItem
                                    }
                                } else if highestAmount == nil {
                                    if tempItem.sumOfQuarterUnits() <= ethExtra {
                                        highestAmount = tempItem
                                    }
                                }
                            }
                        }
                    }
                }
                if highestAmount != nil && highestAmount!.map({$0.quarterUnits!}).reduce(0,+) == ethExtra {
                    return highestAmount
                } else {
                    return decideWhatClassesToSwitch(classes: classes, busNeeded: busNeeded, ethExtra: ethExtra, values: newValues, highest: highestAmount)
                }
            }
            return highest
        }
        
        let switchTheseClasses = decideWhatClassesToSwitch(classes: potentialClassesToSwitch, busNeeded: -businessDifference, ethExtra: ethicsDifference, values: nil, highest: nil)
        
        if switchTheseClasses != nil && switchTheseClasses?.isEmpty == false {
            for course in switchTheseClasses! {
                initialEthics.remove(at: initialEthics.firstIndex(of: course)!)
                initialBusiness.append(course)
            }
        }
        
        numberAccountingUnits = initialAccounting.sumOfQuarterUnits()
        numberBusinessUnits = initialBusiness.sumOfQuarterUnits()
        numberEthicsUnits = initialEthics.sumOfQuarterUnits()
        
        let ad = numberAccountingUnits - 45//Double(SharedUnits.shared.units["totalAccounting"]!)
        if ad > 0 {
            numberBusinessUnits += ad
            numberAccountingUnits -= ad
        }
        
        let setTitles = Set(allClasses.map({$0.courseNum}))
        
        if key == "semester" {
            numberAccountingUnits = numberAccountingUnits / 1.5
            numberBusinessUnits = numberBusinessUnits / 1.5
            numberEthicsUnits = numberEthicsUnits / 1.5
        }
        
        var acl: [Class] = []
        var bcl: [Class] = []
        var ecl: [Class] = []
        
        (acl, bcl, ecl) = SharedAllClasses.shared.sharedAllClasses.notTakingFor(set: setTitles)
        
        return Result(totalUnits: units.calculateTotalRealmUnits(key: key), accountingUnits: Int(numberAccountingUnits), businessUnits: Int(numberBusinessUnits), ethicsUnits: Int(numberEthicsUnits), accountingClasses: initialAccounting, businessClasses: initialBusiness, ethicsClasses: initialEthics, accountingClassesLeft: acl, businessClassesLeft: bcl, ethicsClassesLeft: ecl)
    }
}


extension Result {
    func getMessages() -> [String] {
        var messages: [String] = []
        let accountingNeeded = SharedUnits.shared.units["totalAccounting"]!
        let businessNeeded = SharedUnits.shared.units["totalBusiness"]!
        let ethicsNeeded = SharedUnits.shared.units["totalEthics"]!
        let totalNeeded = SharedUnits.shared.units["totalUnits"]!
        let accountingDifference = self.accountingUnits - accountingNeeded
        let businessDifference = self.businessUnits - businessNeeded
        let ethicsDifference = self.ethicsUnits - ethicsNeeded
        let totalDifference = self.totalUnits - totalNeeded
        
        var accS: String {
            if abs(accountingDifference) == 1 {
                return ""
            } else {
                return "s"
            }
        }
        var busS: String {
            if abs(businessDifference) == 1 {
                return ""
            } else {
                return "s"
            }
        }
        var ethS: String {
            if abs(ethicsDifference) == 1 {
                return ""
            } else {
                return "s"
            }
        }
        var totS: String {
            if abs(totalDifference) == 1 {
                return ""
            } else {
                return "s"
            }
        }
        if accountingDifference == -5 {
            messages.append("Need 5 more accounting units. Some community college accounting classes are exactly 5 units. Check them out.")
        } else if accountingDifference < 0 {
            messages.append("Need \(abs(accountingDifference)) more accounting unit\(accS), look into more accounting electives or community college classes.")
        }
        if businessDifference < 0 {
            messages.append("Need \(abs(businessDifference)) more business unit\(busS). Look through your other classes that could count and add them to the class list.")
        }
        if ethicsDifference < 0 {
            messages.append("Need \(abs(ethicsDifference)) more ethics unit\(ethS). Check for any free elective classes that could meet the ethics requirement.")
        }
        if totalDifference < 0 {
            messages.append("Need \(abs(totalDifference)) more total unit\(totS). Look for some interesting free elective classes to take.")
        }
        if ethicsClasses.filter({$0.mustBeEthics == true}).count == 0 {
            messages.append("Need a professional ethics class. Professional ethics classes have a title such as Accounting Ethics. Check the instructions for more information.")
        }
        if messages.isEmpty == true {
            messages.append("Good job! All the conditions are met.")
        }
        return messages
    }
    func selectedClasses(acc: Bool, bus: Bool, eth: Bool, taking: Bool, available: Bool) -> [Class] {
        if (acc == true) && (bus == true) && (eth == true) && (taking == true) {
            return (self.accountingClasses + self.businessClasses + self.ethicsClasses).sortClasses()
        } else if (acc == true) && (bus == true) && (eth == true) && (available == true) {
            return Array(Set((self.accountingClassesLeft + self.businessClassesLeft + self.ethicsClassesLeft).sortClasses()))
        } else if (acc == true) && (taking == true) {
            return self.accountingClasses
        } else if (acc == true) && (available == true) {
            return self.accountingClassesLeft
        } else if (bus == true) && (taking == true) {
            return self.businessClasses
        } else if (bus == true) && (available == true) {
            return self.businessClassesLeft
        } else if (eth == true) && (taking == true) {
            return self.ethicsClasses
        } else if (eth == true) && (available == true) {
            return self.ethicsClassesLeft
        } else {
            return self.accountingClasses
        }
    }
}
