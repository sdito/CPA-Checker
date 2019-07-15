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

func calculateTotalUnits(terms: [RealmUnits], key: String) -> Int {
    // first put them all into quarter units
    var counter: Double = 0
    let semToQtr = 1.5
    terms.forEach { (term) in
        if let s = term.semesterOrQuarter {
            if s == "quarter" {
                counter += Double(term.units)
            } else if s == "semester" {
                counter += (Double(term.units) * semToQtr)
            }
        }
    }
    // might need to round down before just rounding the numbers
    if key == "quarter" {
        return Int(counter)
    } else if key == "semester" {
        return Int(round(counter/semToQtr))
    }
    return 0
}

/*
extension Array where Element: RealmUnits {
    func calculateToUnits(key: String) -> Int {
        
        return 10
    }
}
*/

