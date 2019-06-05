//
//  RealmClass.swift
//  cpaChecker
//
//  Created by Steven Dito on 5/31/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class RealmClass: Object {
    @objc dynamic var courseNum: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var isAccounting: Bool = false
    @objc dynamic var isBusiness: Bool = false
    @objc dynamic var isEthics: Bool = false
    @objc dynamic var numUnits: Int = 0
    

}


