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
}


func calculateResult(units: [RealmUnits], key: String, realmClasses: [RealmClass]) {//-> Result {
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
    classesUserIsTaking.forEach { (c) in
        if c.semesterOrQuarter == "semester" {
            c.quarterUnits = (Double(c.numUnits) * 1.5)
        } else {
            c.quarterUnits = Double(c.numUnits)
        }
    }
    
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
    var numberAccountingUnits = initialAccounting.map{$0.quarterUnits!}.reduce(0.0, +)
    var numberBusinessUnits = initialBusiness.map{$0.quarterUnits!}.reduce(0.0, +)
    var numberEthicsUnits = initialEthics.map{$0.quarterUnits!}.reduce(0.0, +)
    
    let accountingDifference = numberAccountingUnits - 45.0
    let businessDifference = numberBusinessUnits - 57.0
    let ethicsDifference = numberEthicsUnits - 15.0
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
        print(busNeeded)
        print(ethicsDifference)
        var highestAmount: [Class]? = highest
        if classes.isEmpty == true || busNeeded < 0 || ethExtra < 0 {
            return nil
        } else if values == nil {
            var c: [[Class]] = []
            for course in classes {
                if course.quarterUnits! >= busNeeded && course.quarterUnits! <= ethExtra {
                    return [course]
                } else {
                    c.append([course])
                }
            }
            return decideWhatClassesToSwitch(classes: classes, busNeeded: busNeeded, ethExtra: ethExtra, values: c, highest: nil)
        } else if classes.map({$0.quarterUnits!}).reduce(0.0, +) >= busNeeded && classes.map({$0.quarterUnits!}).reduce(0.0, +) <= ethExtra {
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
                        if (tempItem.map({$0.quarterUnits!}).reduce(0.0, +) >= busNeeded) && (tempItem.map({$0.quarterUnits!}).reduce(0.0, +) <= ethExtra) {
                            //highestAmount = tempItem
                            //print("Should be returning from deicdeWhatClasses: \(tempItem)")
                            return tempItem
                        } else {
                            newValues.append(tempItem)
                            if highest != nil {
                                if (tempItem.map({$0.quarterUnits!}).reduce(0.0, +) > highestAmount!.map({$0.quarterUnits!}).reduce(0.0, +)) && (tempItem.map({$0.quarterUnits!}).reduce(0.0, +) <= ethExtra) {
                                    highestAmount = tempItem
                                    print(highestAmount)
                                }
                            } else if highest == nil {
                                highestAmount = tempItem
                            }
                        }
                    }
                }
            }
            return decideWhatClassesToSwitch(classes: classes, busNeeded: busNeeded, ethExtra: ethExtra, values: newValues, highest: highestAmount)
        }
        print("returning highest")
        return highest
    }
    
    
    
    let SWITCHTHESECLASSES = decideWhatClassesToSwitch(classes: potentialClassesToSwitch, busNeeded: -businessDifference, ethExtra: ethicsDifference, values: nil, highest: nil)
    print(potentialClassesToSwitch.map({$0.courseNum}))
    print(SWITCHTHESECLASSES!.map({$0.courseNum}))
    
    
}
