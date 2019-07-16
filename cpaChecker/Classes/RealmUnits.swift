//
//  RealmUnits.swift
//  cpaChecker
//
//  Created by Steven Dito on 5/31/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//
import Foundation
import RealmSwift

class RealmUnits: Object {
    @objc dynamic var identifier: String?
    @objc dynamic var units = 0
    @objc dynamic var semesterOrQuarter: String?
}

extension Array where Element: RealmUnits {
    func calculateTotalRealmUnits(key: String) -> Int {
        var counter: Double = 0
        let semToQtr = 1.5
        self.forEach { (term) in
            if let s = term.semesterOrQuarter {
                if s == "quarter" {
                    counter += Double(term.units)
                } else if s == "semester" {
                    counter += (Double(term.units) * semToQtr)
                }
            }
        }
        // returns int to round down the numbers
        if key == "quarter" {
            return Int(counter)
        } else if key == "semester" {
            return Int(round(counter/semToQtr))
        }
        return 0
    }
}


