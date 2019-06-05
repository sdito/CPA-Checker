//
//  UnitEntryVC.swift
//  cpaChecker
//
//  Created by Steven Dito on 5/30/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit
import RealmSwift

class UnitEntryVC: UIViewController, UITextFieldDelegate {
    
    var realm = try! Realm()
    
    @IBOutlet weak var fall1: UITextField!
    @IBOutlet weak var winter1: UITextField!
    @IBOutlet weak var spring1: UITextField!
    @IBOutlet weak var fall2: UITextField!
    @IBOutlet weak var winter2: UITextField!
    @IBOutlet weak var spring2: UITextField!
    @IBOutlet weak var fall3: UITextField!
    @IBOutlet weak var winter3: UITextField!
    @IBOutlet weak var spring3: UITextField!
    @IBOutlet weak var fall4: UITextField!
    @IBOutlet weak var winter4: UITextField!
    @IBOutlet weak var spring4: UITextField!
    @IBOutlet weak var apOther: UITextField!
    @IBOutlet weak var ccUnits: UITextField!
    @IBOutlet weak var ccAccounting: UITextField!
    @IBOutlet weak var ccBusiness: UITextField!
    @IBOutlet weak var ccEthics: UITextField!

    @IBOutlet weak var hideLabel: UILabel!

    
    
    var activeTextField: UITextField?
    //var kbHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try! Realm()
        
        fall1.delegate = self
        fall2.delegate = self
        fall3.delegate = self
        fall4.delegate = self
        winter1.delegate = self
        winter2.delegate = self
        winter3.delegate = self
        winter4.delegate = self
        spring1.delegate = self
        spring2.delegate = self
        spring3.delegate = self
        spring4.delegate = self
        apOther.delegate = self
        ccUnits.delegate = self
        ccAccounting.delegate = self
        ccBusiness.delegate = self
        ccEthics.delegate = self
        
        
        // could most likely go bad
        fall1.text = realm.objects(RealmUnits.self).filter("identifier = 'Fall 1'").first?.units.description
        fall2.text = realm.objects(RealmUnits.self).filter("identifier = 'Fall 2'").first?.units.description
        fall3.text = realm.objects(RealmUnits.self).filter("identifier = 'Fall 3'").first?.units.description
        fall4.text = realm.objects(RealmUnits.self).filter("identifier = 'Fall 4'").first?.units.description
        winter1.text = realm.objects(RealmUnits.self).filter("identifier = 'Winter 1'").first?.units.description
        winter2.text = realm.objects(RealmUnits.self).filter("identifier = 'Winter 2'").first?.units.description
        winter3.text = realm.objects(RealmUnits.self).filter("identifier = 'Winter 3'").first?.units.description
        winter4.text = realm.objects(RealmUnits.self).filter("identifier = 'Winter 4'").first?.units.description
        spring1.text = realm.objects(RealmUnits.self).filter("identifier = 'Spring 1'").first?.units.description
        spring2.text = realm.objects(RealmUnits.self).filter("identifier = 'Spring 2'").first?.units.description
        spring3.text = realm.objects(RealmUnits.self).filter("identifier = 'Spring 3'").first?.units.description
        spring4.text = realm.objects(RealmUnits.self).filter("identifier = 'Spring 4'").first?.units.description
        apOther.text = realm.objects(RealmUnits.self).filter("identifier = 'AP and Other'").first?.units.description
        ccUnits.text = realm.objects(RealmUnits.self).filter("identifier = 'Community College'").first?.units.description
//        ccAccounting.text
//        ccEthics.text
//        ccBusiness.text
        
        
        
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
        toolbar.setItems([doneButton], animated: false)
        toolbar.autoresizingMask = .flexibleHeight
        
        fall1.inputAccessoryView = toolbar
        fall2.inputAccessoryView = toolbar
        fall3.inputAccessoryView = toolbar
        fall4.inputAccessoryView = toolbar
        winter1.inputAccessoryView = toolbar
        winter2.inputAccessoryView = toolbar
        winter3.inputAccessoryView = toolbar
        winter4.inputAccessoryView = toolbar
        spring1.inputAccessoryView = toolbar
        spring2.inputAccessoryView = toolbar
        spring3.inputAccessoryView = toolbar
        spring4.inputAccessoryView = toolbar
        apOther.inputAccessoryView = toolbar
        ccUnits.inputAccessoryView = toolbar
        ccAccounting.inputAccessoryView = toolbar
        ccBusiness.inputAccessoryView = toolbar
        ccEthics.inputAccessoryView = toolbar
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    // since in a tab bar and no segue, is this a bad way to update the realm about the units? or should I update them another way
    override func viewWillDisappear(_ animated: Bool) {
        // works, but is it the right way to just create an instance on each view controller of the realm? or should I put it in a shared class and access it that way?
        print(Realm.Configuration.defaultConfiguration.fileURL)
        // clean up textfields before doing this, dont allow anything but numbers
        let f1 = RealmUnits()
        f1.identifier = "Fall 1"
        f1.units = Int(fall1.text ?? "") ?? 0
        let f2 = RealmUnits()
        f2.identifier = "Fall 2"
        f2.units = Int(fall2.text ?? "") ?? 0
        let f3 = RealmUnits()
        f3.identifier = "Fall 3"
        f3.units = Int(fall3.text ?? "") ?? 0
        let f4 = RealmUnits()
        f4.identifier = "Fall 4"
        f4.units = Int(fall4.text ?? "") ?? 0
        
        let w1 = RealmUnits()
        w1.identifier = "Winter 1"
        w1.units = Int(winter1.text ?? "") ?? 0
        let w2 = RealmUnits()
        w2.identifier = "Winter 2"
        w2.units = Int(winter2.text ?? "") ?? 0
        let w3 = RealmUnits()
        w3.identifier = "Winter 3"
        w3.units = Int(winter3.text ?? "") ?? 0
        let w4 = RealmUnits()
        w4.identifier = "Winter 4"
        w4.units = Int(winter4.text ?? "") ?? 0
        
        let s1 = RealmUnits()
        s1.identifier = "Spring 1"
        s1.units = Int(spring1.text ?? "") ?? 0
        let s2 = RealmUnits()
        s2.identifier = "Spring 2"
        s2.units = Int(spring2.text ?? "") ?? 0
        let s3 = RealmUnits()
        s3.identifier = "Spring 3"
        s3.units = Int(spring3.text ?? "") ?? 0
        let s4 = RealmUnits()
        s4.identifier = "Spring 4"
        s4.units = Int(spring4.text ?? "") ?? 0
        
        let apO = RealmUnits()
        apO.identifier = "AP and Other"
        apO.units = Int(apOther.text ?? "") ?? 0
        let cc = RealmUnits()
        cc.identifier = "Community College"
        cc.units = Int(ccUnits.text ?? "") ?? 0
        
        let ccA = RealmUnits()
        ccA.identifier = "ACC - CC"
        ccA.units = Int(ccAccounting.text ?? "") ?? 0
        let ccB = RealmUnits()
        ccB.identifier = "BUS - CC"
        ccB.units = Int(ccBusiness.text ?? "") ?? 0
        let ccE = RealmUnits()
        ccE.identifier = "ETH - CC"
        ccE.units = Int(ccEthics.text ?? "") ?? 0
        
        let realmObjects: [RealmUnits] = [f1, f2, f3, f4, w1, w2, w3, w4, s1, s2, s3, s4, apO, cc, ccA, ccB, ccE]
        //add textfields to an array instead
        try! realm.write {
            let allUnitsToDelete = realm.objects(RealmUnits.self)
            realm.delete(allUnitsToDelete)
            realm.add(realmObjects)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    @objc func doneClicked() {
        view.endEditing(true)
        UIView.animate(withDuration: 0.5) {
            self.view.frame.origin.y = 0
        }
        
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect) else {
            return
        }
        //kbHeight = keyboardRect.height
        //var tally: CGFloat = 0
        
        if (activeTextField?.frame.origin.y)! > keyboardRect.height {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.frame.origin.y = -((self.activeTextField?.frame.origin.y)! - keyboardRect.height)

            })
            
            //tally += -((activeTextField?.frame.origin.y)! - keyboardRect.height)
        } else if (activeTextField?.frame.origin.y)! < keyboardRect.height {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.frame.origin.y = 0
            })
        }
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeTextField = textField
        return true
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fall1 {
            textField.resignFirstResponder()
            winter1.becomeFirstResponder()
        } else if textField == winter1 {
            textField.resignFirstResponder()
            spring1.becomeFirstResponder()
        } else if textField == spring1 {
            textField.resignFirstResponder()
            fall2.becomeFirstResponder()
        } else if textField == fall2 {
            textField.resignFirstResponder()
            winter2.becomeFirstResponder()
        } else if textField == winter2 {
            textField.resignFirstResponder()
            spring2.becomeFirstResponder()
        } else if textField == spring2 {
            textField.resignFirstResponder()
            fall3.becomeFirstResponder()
        } else if textField == fall3 {
            textField.resignFirstResponder()
            winter3.becomeFirstResponder()
        } else if textField == winter3 {
            textField.resignFirstResponder()
            spring3.becomeFirstResponder()
        } else if textField == spring3 {
            textField.resignFirstResponder()
            fall4.becomeFirstResponder()
        } else if textField == fall4 {
            textField.resignFirstResponder()
            winter4.becomeFirstResponder()
        } else if textField == winter4 {
            textField.resignFirstResponder()
            spring4.becomeFirstResponder()
        } else if textField == spring4 {
            textField.resignFirstResponder()
            apOther.becomeFirstResponder()
        } else if textField == apOther {
            textField.resignFirstResponder()
            ccUnits.becomeFirstResponder()
        } else if textField == ccUnits {
            if ccUnits.text != "" {
                textField.resignFirstResponder()
                ccAccounting.becomeFirstResponder()
            } else {
            textField.resignFirstResponder()
            fall1.becomeFirstResponder()
            }
        } else if textField == ccAccounting {
            textField.resignFirstResponder()
            ccBusiness.becomeFirstResponder()
        } else if textField == ccBusiness {
            textField.resignFirstResponder()
            ccEthics.becomeFirstResponder()
        } else if textField == ccEthics {
            textField.resignFirstResponder()
            fall1.becomeFirstResponder()
        }
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if ccUnits.text != "" {
            //unhide
            ccAccounting.isHidden = false
            ccBusiness.isHidden = false
            ccEthics.isHidden = false
            hideLabel.isHidden = false
            
            if CFStringGetIntValue(ccUnits?.text as CFString?) < CFStringGetIntValue(ccAccounting?.text as CFString?) + CFStringGetIntValue(ccBusiness?.text as CFString?) + CFStringGetIntValue(ccEthics?.text as CFString?) {
                let alert = UIAlertController(title: "Error", message: "Incorrect Entry of Community College Units", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.activeTextField?.text = ""
                present(alert, animated: true, completion: nil)
            }
        } else {
            //hide
            ccAccounting.isHidden = true
            ccBusiness.isHidden = true
            ccEthics.isHidden = true
            hideLabel.isHidden = true
        }
        return true
    }
    func handleExtraEthicsOverCC() {
        // create, currently if ccEthics is the one that makes total greater than ccUnits (and error alert pop up), keybaord show doesnt work correctly and textfield is hidden
    }
    
}


