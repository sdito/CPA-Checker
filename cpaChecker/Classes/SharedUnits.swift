//
//  SharedUnits.swift
//  cpaChecker
//
//  Created by Steven Dito on 7/8/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import Foundation


class SharedUnits {

    private let quarter: [String:Int] = ["accountingSubjects":36, "businessRelatedSubjects":36, "accountingStudy":30, "ethicsStudy":15, "totalAccounting":45, "totalBusiness":57, "totalEthics":15, "totalUnits":225]
    private let semester: [String:Int] = ["accountingSubjects":24, "businessRelatedSubjects":24, "accountingStudy":20, "ethicsStudy":10, "totalAccounting":30, "totalBusiness":38, "totalEthics":10, "totalUnits":150]
    
    
    var units: [String:Int] {
        switch UserDefaults.standard.value(forKey: "units") as! String {
        case "quarter":
            return quarter
        default:
            return semester
        }
    }
    
    var text: String {
        if let t = UserDefaults.standard.value(forKey: "units") as? String {
            return t.capitalized
        } else {
            return ""
        }
    }

    static let shared = SharedUnits()
    private init() {}
    
}

