//
//  ClassesTaking.swift
//  cpaChecker
//
//  Created by Steven Dito on 5/28/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import Foundation


class ClassesTaking {
    static let shared = ClassesTaking()
    var classesTaken = Set<Class>()
    private init() {}
}
