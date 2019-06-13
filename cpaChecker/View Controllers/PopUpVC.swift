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
        print(Realm.Configuration.defaultConfiguration.fileURL)
        let realmClass = RealmNewClass()
        var isAccounting: Bool
        var isBusiness: Bool
        var isEthics: Bool
        if accounting.selectedSegmentIndex == 0 {
            isAccounting = true
        } else {
            isAccounting = false
        }
        if business.selectedSegmentIndex == 0 {
            isBusiness = true
        } else {
            isBusiness = false
        }
        if ethics.selectedSegmentIndex == 0 {
            isEthics = true
        } else {
            isEthics = false
        }
        realmClass.courseNum = (courseNameTextEntry.text ?? "")
        realmClass.numUnits = (Int(numberUnitsTextEntry.text ?? "") ?? 0)
        realmClass.isAccounting = isAccounting
        realmClass.isBusiness = isBusiness
        realmClass.isEthics = isEthics
        try! realm.write {
            realm.add(realmClass)
        }
        
        delegate.removeBlurViews()
        delegate.resetTableData()
        view.removeFromSuperview()
    }
    @IBAction func exitPressed(_ sender: Any) {
        delegate.removeBlurViews()
        view.removeFromSuperview()
    }
    
}
