//
//  View-Extension.swift
//  cpaChecker
//
//  Created by Steven Dito on 7/19/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    func insertBlurredBackground() {
        let blurredBackgroundView = UIVisualEffectView()
        blurredBackgroundView.frame = UIScreen.main.bounds
        blurredBackgroundView.effect = UIBlurEffect(style: .dark)
        
        self.addSubview(blurredBackgroundView)
    }
    func removeBlurredBackground() {
        for subview in self.subviews {
            if subview.isKind(of: UIVisualEffectView.self) {
                subview.removeFromSuperview()
            }
        }
    }
}
