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
    func rotate(boolean: Bool) {
        if boolean == false {
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform(rotationAngle: .pi/1)
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform(rotationAngle: 0)
            }
        }
    }
}
