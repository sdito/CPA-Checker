//
//  StatusView.swift
//  cpaChecker
//
//  Created by Steven Dito on 6/14/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit

class StatusView: UIView {

    @IBOutlet weak var label: UILabel!
    
    func setUI(message: String) {
        self.label.text = message
    }
}
