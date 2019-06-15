//
//  SharedAllClasses.swift
//  cpaChecker
//
//  Created by Steven Dito on 6/7/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import Foundation

class SharedAllClasses {
    var sharedAllClasses: [Class] = createClasses()
    static let shared = SharedAllClasses()
    private init() {}
}
