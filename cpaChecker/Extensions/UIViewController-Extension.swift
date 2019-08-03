//
//  UIViewController-Extension.swift
//  cpaChecker
//
//  Created by Steven Dito on 8/3/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import Foundation
import UIKit



extension UIViewController {
    
    func add(popUp: StatusPopUpVC) {
        self.addChild(popUp)
        popUp.view.frame = self.view.frame
        self.view.addSubview(popUp.view)
        popUp.didMove(toParent: self)
    }
}
