//
//  StatusCell.swift
//  cpaChecker
//
//  Created by Steven Dito on 6/3/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {

    @IBOutlet weak var courseNumLabel: UILabel!
    @IBOutlet weak var courseTitleLabel: UILabel!
    
    func statusCellUI(object: Class) {
        courseNumLabel.text = object.courseNum
        courseTitleLabel.text = object.title
    }
}
