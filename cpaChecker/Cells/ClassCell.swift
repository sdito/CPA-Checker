//
//  ClassCell.swift
//  cpaChecker
//
//  Created by Steven Dito on 5/28/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit
import RealmSwift


protocol ClassCellDelegate {
    func classSwitchPressed(units: Class)
}

class ClassCell: UITableViewCell {
    
    var realm = try! Realm()
    
    @IBOutlet weak var classNumberLabel: UILabel!
    @IBOutlet weak var isAccountingLabel: UILabel!
    @IBOutlet weak var isBusinessLabel: UILabel!
    @IBOutlet weak var isEthicsLabel: UILabel!
    @IBOutlet weak var classSwitch: UISwitch!
    
    var delegate: ClassCellDelegate?
    var classItem: Class!
    
    func setClassData(units: Class) {
        classItem = units
        classNumberLabel.text = units.courseNum
        if units.isAccounting == true {
            isAccountingLabel.text = "x"
        } else {
            isAccountingLabel.text = " "
        }
        if units.isBusiness == true {
            isBusinessLabel.text = "x"
        } else {
            isBusinessLabel.text = " "
        }
        if units.isEthics == true {
            isEthicsLabel.text = "x"
        } else {
            isEthicsLabel.text = " "
        }
        
        // avoid dequeReusableCell problem
        if realm.objects(RealmClass.self).filter("courseNum = '\(units.courseNum)'").count >= 1 {
            classSwitch.isOn = true
        } else {
            classSwitch.isOn = false
        }        
    }

    @IBAction func classSwitchAction(_ sender: Any) {
        delegate?.classSwitchPressed(units: classItem!)
    }
}
