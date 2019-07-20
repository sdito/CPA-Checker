//
//  String - Extension.swift
//  cpaChecker
//
//  Created by Steven Dito on 7/17/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import Foundation
import SQLite

extension String {
    func turnSQLstrToArray() -> [String] {
        var schoolIdentifier: [Int:String] = [:]
        let path = Bundle.main.path(forResource: "cpa", ofType: "db")!
        let db = try? Connection(path, readonly: true)
        for s in try! db!.prepare(
            """
            SELECT name, collegeID FROM colleges
            order by name
            """
            ) {
                //schoolIdentifier[s[0] as! String] = Int(s[1] as! Int64)
                schoolIdentifier[Int(s[1] as! Int64)] = s[0] as? String
        }
        var array: [Int] = []
        var num = ""
        
        for c in self {
            if c == "," {
                if let n = Int(num) {
                    array.append(n)
                }
                num = ""
            } else if c == self.last {
                num.append(c)
                if let n = Int(num) {
                    array.append(n)
                }
            } else if "0"..."9" ~= c {
                num.append(c)
            }
        }
        var names: [String] = []
        for item in array {
            if let school = schoolIdentifier[item] {
                names.append(school)
            }
        }
        return names
    }
    mutating func changeUnitType() {
        switch self {
        case "quarter":
            self = "semester"
        case "semester":
            self = "quarter"
        default:
            self = "quarter"
        }
    }
}
