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
    @objc dynamic var isEthics: Bool = false
    @objc dynamic var isBusiness: Bool = false
    @objc dynamic var numUnits: Int = 0
    
//    convenience init(courseNum: String, title: String, isAccounting: Bool, isEthics: Bool, isBusiness: Bool, numUnits: (Int)) {
//        self.courseNum = courseNum
//        self.title = title
//        self.isAccounting = isAccounting
//        self.isBusiness = isBusiness
//        self.isEthics = isEthics
//        self.numUnits = numUnits
//        self.init()
//    }
    
//    required init() {
//        fatalError("init() has not been implemented")
//    }
//
//    required init(realm: RLMRealm, schema: RLMObjectSchema) {
//        fatalError("init(realm:schema:) has not been implemented")
//    }
//
//    required init(value: Any, schema: RLMSchema) {
//        fatalError("init(value:schema:) has not been implemented")
//    }
}
