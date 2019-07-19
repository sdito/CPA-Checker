//
//  Class.swift
//  cpaChecker
//
//  Created by Steven Dito on 5/28/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import Foundation
import RealmSwift

class Class {
    
    var courseNum: String
    var title: String
    var courseDescription: String?
    var isAccounting: Bool
    var isBusiness: Bool
    var isEthics: Bool
    var numUnits: Int
    
    var offeredFall: Bool?
    var offeredWinter: Bool?
    var offeredSpring: Bool?
    var offeredSummer: Bool?

    var mustBeEthics: Bool?
    var collegeID: Int?
    var semesterOrQuarter: String
    
    var quarterUnits: Double?
    
    init(courseNum: String, title: String, description: String?, isAccounting: Bool, isBusiness: Bool, isEthics: Bool, numUnits: Int, offeredFall: Bool?, offeredWinter: Bool?, offeredSpring: Bool?, offeredSummer: Bool?, mustBeEthics: Bool?, collegeID: Int?, semesterOrQuarter: String) {
        self.courseNum = courseNum
        self.title = title
        self.courseDescription = description
        self.isAccounting = isAccounting
        self.isBusiness = isBusiness
        self.isEthics = isEthics
        self.numUnits = numUnits
        self.offeredFall = offeredFall
        self.offeredWinter = offeredWinter
        self.offeredSpring = offeredSpring
        self.offeredSummer = offeredSummer
        self.mustBeEthics = mustBeEthics
        self.collegeID = collegeID
        self.semesterOrQuarter = semesterOrQuarter
    }
}

extension Class: Hashable {
    static func == (lhs: Class, rhs: Class) -> Bool {
        return lhs.courseNum == rhs.courseNum
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(courseNum)
    }
}

extension Array where Element: Class {
    func addQuarterUnits() {
        self.forEach { (c) in
            if c.semesterOrQuarter == "semester" {
                c.quarterUnits = (Double(c.numUnits) * 1.5)
            } else {
                c.quarterUnits = Double(c.numUnits)
            }
        }
    }
    func sumOfQuarterUnits() -> Double {
        return self.map({$0.quarterUnits!}).reduce(0, +)
    }
    func notTakingFor(set: Set<String>) -> ([Class], [Class], [Class]) {
        var acl: [Class] = []
        var bcl: [Class] = []
        var ecl: [Class] = []
        self.forEach { (course) in
            if set.contains(course.courseNum) == false {
                if course.isAccounting == true {
                    acl.append(course)
                }
                if course.isBusiness == true {
                    bcl.append(course)
                }
                if course.isEthics == true {
                    ecl.append(course)
                }
            }
        }
        return (acl, bcl, ecl)
    }
    func updateTVclasses(acc: Bool, bus: Bool, eth: Bool, dict: [Int:String]) -> ([String], [[Class]]) {
        var sortedClasses = self
        var sectionNames: [String] = []
        var arrayArrayClasses: [[Class]] = []
        if (acc == true) && (bus == true) && (eth == true) {
            sortedClasses = self.filter{$0.isAccounting == true && $0.isBusiness == true && $0.isEthics == true}
        } else if (acc == true) && (bus == true) && (eth == false) {
            sortedClasses = self.filter{$0.isAccounting == true && $0.isBusiness == true}
        } else if (acc == true) && (bus == false) && (eth == true) {
            sortedClasses = self.filter{$0.isAccounting == true && $0.isEthics == true}
        } else if (acc == false) && (bus == true) && (eth == true) {
            sortedClasses = self.filter{$0.isEthics == true && $0.isBusiness == true}
        } else if (acc == true) && (bus == false) && (eth == false) {
            sortedClasses = self.filter{$0.isAccounting == true}
        } else if (acc == false) && (bus == true) && (eth == false) {
            sortedClasses = self.filter{$0.isBusiness == true}
        } else if (acc == false) && (bus == false) && (eth == true) {
            sortedClasses = self.filter{$0.isEthics == true}
        } else if (acc == false) && (bus == false) && (eth == false) {
            sortedClasses = self
        } else {
            sortedClasses = self
        }
        (sectionNames, arrayArrayClasses) = sortedClasses.classesForTableViewSections(colleges: dict)
        return (sectionNames, arrayArrayClasses)
    }
    func classesForTableViewSections(colleges: [Int:String]) -> ([String], [[Class]]) {
        var reversedDict = Dictionary(uniqueKeysWithValues: colleges.map({($1, $0)}))
        var sortedCollegenames = reversedDict.keys.sorted()
        reversedDict["User Added Classes"] = 0
        //makes user added classes always appear last in class list selection table
        sortedCollegenames.append("User Added Classes")
        var sectionClasses: [[Class]] = []
        var classTitles: [String] = []
        //needs to be sorted here so classes appear in the same order
        for i in sortedCollegenames {
            var counter = 0
            classTitles.append(i)
            var array: [Class] = []
            for item in self {
                if item.collegeID == reversedDict[i] {
                    array.append(item)
                    counter += 1
                }
            }
            if counter == 0 && i != "User Added Classes" {
                classTitles.removeLast()
                array = []
                counter = 0
            } else {
                // sort the classes right here alphabetically by course number
                sectionClasses.append(array.sorted(by: { (c1, c2) -> Bool in
                    c1.courseNum < c2.courseNum
                }))
                array = []
                counter = 0
            }
        }
        // need to sort by the class titles to ensure that the sections appear in the same order between different page visits, need to sort both different aarrays in the same order, while sorting by classTitle
        return (classTitles, sectionClasses)
    }
}
