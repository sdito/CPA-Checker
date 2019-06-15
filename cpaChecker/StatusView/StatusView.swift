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
    @IBOutlet weak var view: UIView!
    var message = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
