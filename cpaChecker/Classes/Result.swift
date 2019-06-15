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
