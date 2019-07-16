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
    /*
    class func numberOfUnits(for classes: [Class], key: String) -> Int {
        var counter: Double = 0
        let semToQtr = 1.5
        
        classes.forEach { (c) in
            if c.semesterOrQuarter == "quarter" {
                counter += Double(c.numUnits)
            } else if c.semesterOrQuarter == "semester" {
                counter += (Double(c.numUnits) * semToQtr)
            }
        }
        if key == "quarter" {
            return Int(round(counter))
        } else if key == "semester" {
            return Int(round(counter/semToQtr))
        }
        return 0
    }
 */
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
    func sumOfQuarterUnits() -> Double {
        return self.map({$0.quarterUnits!}).reduce(0, +)
    }
    func addQuarterUnits() {
        self.forEach { (c) in
            if c.semesterOrQuarter == "semester" {
                c.quarterUnits = (Double(c.numUnits) * 1.5)
            } else {
                c.quarterUnits = Double(c.numUnits)
            }
        }
    }
}
