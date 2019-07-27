//
//  UILabel-Extension.swift
//  cpaChecker
//
//  Created by Steven Dito on 7/17/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    // if needed to rotate other than 180 degrees change the function
    func rotate(boolean: Bool) {
        if boolean == false {
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform(rotationAngle: .pi/2)
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform(rotationAngle: 0)
            }
        }
    }
}
extension UIButton {
    func changeUIfor(boolean: Bool) {
        if boolean == true {
            self.alpha = 1.0
        } else {
            self.alpha = 0.55
        }
    }
}

extension Array where Element: UIButton {
    mutating func setAllToMinFontSize() {
        self.forEach({$0.titleLabel?.adjustsFontSizeToFitWidth = true})
    }
}
