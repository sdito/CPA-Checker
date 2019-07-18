//
//  RealmNewClasses.swift
//  cpaChecker
//
//  Created by Steven Dito on 6/7/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class RealmNewClass: Object {
    @objc dynamic var courseNum: String = ""
    @objc dynamic var isAccounting: Bool = false
    @objc dynamic var isBusiness: Bool = false
    @objc dynamic var isEthics: Bool = false
    @objc dynamic var numUnits: Int = 0
    @objc dynamic var mustBeEthics: Bool = false
    @objc dynamic var semesterOrQuarter: String = ""
}

extension Array where Element: RealmNewClass {
    func addNewClassesTo(courses: [Class]) -> [Class] {
        var toReturn: [Class] = courses
        var allCourseNums: [String] = []
        for name in courses {
            allCourseNums.append(name.courseNum)
        }
        for item in self {
            let newClass = Class(courseNum: item.courseNum.uppercased(), title: "User added class", description: nil, isAccounting: item.isAccounting, isBusiness: item.isBusiness, isEthics: item.isEthics, numUnits: item.numUnits, offeredFall: nil, offeredWinter: nil, offeredSpring: nil, offeredSummer: nil, mustBeEthics: item.mustBeEthics, collegeID: 0, semesterOrQuarter: item.semesterOrQuarter)
            if allCourseNums.contains(newClass.courseNum) {
                //do nothing
            } else {
                toReturn.append(newClass)
            }
        }
        return toReturn
    }
}
