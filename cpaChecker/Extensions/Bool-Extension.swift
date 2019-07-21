//
//  Bool-Extension.swift
//  cpaChecker
//
//  Created by Steven Dito on 7/20/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import Foundation
import UIKit

extension Bool {
    func setLabelColor(_ label: UILabel) {
        if self == true {
            label.textColor = Colors.main
        } else if self == false {
            label.textColor = .white
        } else {
            label.text = ""
        }
    }
}
