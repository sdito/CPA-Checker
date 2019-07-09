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

// used to allow user to add another class to main list
class PopUpVC: UIViewController {
    var delegate: PopUpDelegate!
    
    var realm = try! Realm()
    @IBOutlet weak var courseNameTextEntry: UITextField!
    @IBOutlet weak var numberUnitsTextEntry: UITextField!
    
    
    @IBOutlet weak var semesterQuarter: UISegmentedControl!
    @IBOutlet weak var accounting: UISegmentedControl!
    @IBOutlet weak var business: UISegmentedControl!
    @IBOutlet weak var ethics: UISegmentedControl!
    private var professionalEthics: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        courseNameTextEntry.delegate = self
        numberUnitsTextEntry.delegate = self
        courseNameTextEntry.becomeFirstResponder()
    }
    
    @IBAction func isProfessionalEthics(_ sender: Any) {
        professionalEthics = !professionalEthics
        print(professionalEthics)
    }
    
    
    //create the class
    @IBAction func donePressed(_ sender: Any) {
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
        realmClass.courseNum = (courseNameTextEntry.text?.uppercased() ?? "")
        realmClass.numUnits = (Int(numberUnitsTextEntry.text ?? "") ?? 0)
        realmClass.isAccounting = isAccounting
        realmClass.isBusiness = isBusiness
        realmClass.isEthics = isEthics
        realmClass.mustBeEthics = professionalEthics
        
        // for continue on alert
        func endNewClass(alert: UIAlertAction!) {
            try! realm.write {
                realm.add(realmClass)
            }
            
            delegate.removeBlurViews()
            delegate.resetTableData()
            view.removeFromSuperview()
        }
        // have an alert if the class data for added class is not complete
        if (realmClass.courseNum == "") || (realmClass.isAccounting == false && realmClass.isBusiness == false && realmClass.isEthics == false ) || realmClass.numUnits == 0 {
            let alert = UIAlertController(title: "Incomplete class data.", message: "Are you sure you still want to proceed?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .destructive, handler: endNewClass))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            
        } else {
            try! realm.write {
                realm.add(realmClass)
            }
            
            delegate.removeBlurViews()
            delegate.resetTableData()
            view.removeFromSuperview()
        }
        
        
    }
    @IBAction func exitPressed(_ sender: Any) {
        delegate.removeBlurViews()
        view.removeFromSuperview()
    }
}

extension PopUpVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == courseNameTextEntry {
            textField.resignFirstResponder()
            numberUnitsTextEntry.becomeFirstResponder()
        } else if textField == numberUnitsTextEntry {
            textField.resignFirstResponder()
            courseNameTextEntry.becomeFirstResponder()
        }
        return true
    }
}
