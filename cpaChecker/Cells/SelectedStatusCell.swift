//
//  SelectedStatusCell.swift
//  cpaChecker
//
//  Created by Steven Dito on 7/20/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import Foundation
import UIKit

class SelectedStatusCell: UITableViewCell {
    
    @IBOutlet weak var courseNumLabel: UILabel!
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var numUnitsLabel: UILabel!
    @IBOutlet weak var isAccountingLabel: UILabel!
    @IBOutlet weak var isBusinessLabel: UILabel!
    @IBOutlet weak var isEthicsLabel: UILabel!
    
    func setUI(course: Class) {
        courseNumLabel.text = course.courseNum
        courseTitleLabel.text = course.title
        course.isAccounting.setLabelColor(isAccountingLabel)
        course.isBusiness.setLabelColor(isBusinessLabel)
        course.isEthics.setLabelColor(isEthicsLabel)
        numUnitsLabel.text = setUnitDisplay(course: course)
    }
    
    private func setUnitDisplay(course: Class) -> String {
        if SharedUnits.shared.text.lowercased() == course.semesterOrQuarter.lowercased() {
            return "\(course.numUnits) \(SharedUnits.shared.text) Units"
        } else {
            if course.semesterOrQuarter == "semester" {
                return "\(Double(course.numUnits)*1.5) Quarter Units"
            } else if course.semesterOrQuarter == "quarter" {
                return "\(((Double(course.numUnits) / 1.5) * 10.0).rounded()/10.0) Semester Units"
            }
            return ""
        }
    }
}
