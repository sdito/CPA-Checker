//
//  UITextField-Extension.swift
//  cpaChecker
//
//  Created by Steven Dito on 7/18/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension UITextField {
    func setText(term: String, objects: Results<RealmUnits>) {
        let txt = objects.filter("identifier = '\(term)'").first?.units.description
        self.text = (txt == "0") ? "" : txt
    }
    func toInt() -> Int {
        return Int(self.text ?? "") ?? 0
    }
}
