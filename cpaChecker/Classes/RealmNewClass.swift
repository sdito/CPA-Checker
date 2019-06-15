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
    
    
}
