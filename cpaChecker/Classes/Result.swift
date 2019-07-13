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
    let accountingNeeded = SharedUnits.shared.units["totalAccounting"]!
    let businessNeeded = SharedUnits.shared.units["totalBusiness"]!
    let ethicsNeeded = SharedUnits.shared.units["totalEthics"]!
    let totalNeeded = SharedUnits.shared.units["totalUnits"]!
    
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
    classesUserIsTaking.forEach { (c) in
        print("\(c.courseNum), number: \(c.numUnits), quarter: \(c.quarterUnits), \(c.mustBeEthics)")
    }
    
}
