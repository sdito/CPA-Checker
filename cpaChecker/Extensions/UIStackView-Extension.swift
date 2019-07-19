//
//  UIStackView-Extension.swift
//  cpaChecker
//
//  Created by Steven Dito on 7/18/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import Foundation
import UIKit



extension UIStackView {
    func addOrRemoveFromSV(txt: String, boolean: Bool, textColor: UIColor) {
        if boolean == false {
            let label = UILabel()
            label.text = txt
            label.numberOfLines = 0
            label.font = UIFont(name: "avenir", size: 17)
            label.textAlignment = .center
            label.textColor = textColor
            self.insertArrangedSubview(label, at: 1)
        } else {
            let view = self.subviews.last!
            view.removeFromSuperview()
        }
    }
}
