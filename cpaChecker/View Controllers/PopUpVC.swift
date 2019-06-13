//
//  PopUpVC.swift
//  cpaChecker
//
//  Created by Steven Dito on 6/12/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit
import RealmSwift


protocol PopUpDelegate {
    func removeBlurViews()
    func resetTableData()
}

class PopUpVC: UIViewController {
    var delegate: PopUpDelegate!
    
    var realm = try! Realm()
    @IBOutlet weak var courseNameTextEntry: UITextField!
    @IBOutlet weak var numberUnitsTextEntry: UITextField!
    @IBOutlet weak var accounting: UISegmentedControl!
    @IBOutlet weak var business: UISegmentedControl!
    @IBOutlet weak var ethics: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        
    }

    @IBAction func donePressed(_ sender: Any) {
        
    }
    @IBAction func exitPressed(_ sender: Any) {
        delegate.removeBlurViews()
        delegate.resetTableData()
        view.removeFromSuperview()
    }
    
}
