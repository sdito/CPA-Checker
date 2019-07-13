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
    @IBOutlet weak var totalUnitsRequired: UILabel!
    
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

    @IBOutlet weak var fall1S: UISegmentedControl!
    @IBOutlet weak var winter1S: UISegmentedControl!
    @IBOutlet weak var spring1S: UISegmentedControl!
    @IBOutlet weak var fall2S: UISegmentedControl!
    @IBOutlet weak var winter2S: UISegmentedControl!
    @IBOutlet weak var spring2S: UISegmentedControl!
    @IBOutlet weak var fall3S: UISegmentedControl!
    @IBOutlet weak var winter3S: UISegmentedControl!
    @IBOutlet weak var spring3S: UISegmentedControl!
    @IBOutlet weak var fall4S: UISegmentedControl!
    @IBOutlet weak var winter4S: UISegmentedControl!
    @IBOutlet weak var spring4S: UISegmentedControl!
    @IBOutlet weak var apOtherS: UISegmentedControl!
    @IBOutlet weak var ccUnitsS: UISegmentedControl!
    
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
        
        
        // could most likely go bad
        textFieldAmount()

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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        totalUnitsRequired.text = "\(SharedUnits.shared.units["totalUnits"] ?? 0) Total Units Required"
    }
    override func viewWillAppear(_ animated: Bool) {
        segmentedControlStartingSegment()
    }
    // since in a tab bar and no segue, is this a bad way to update the realm about the units? or should I update them another way
    override func viewWillDisappear(_ animated: Bool) {
        // works, but is it the right way to just create an instance on each view controller of the realm? or should I put it in a shared class and access it that way?
        //print(Realm.Configuration.defaultConfiguration.fileURL)
        // clean up textfields before doing this, dont allow anything but numbers
        let f1 = RealmUnits()
        f1.identifier = "Fall 1"
        f1.units = Int(fall1.text ?? "") ?? 0
        f1.semesterOrQuarter = scToSemesterOrQuarter(segmentedControl: fall1S)
        let f2 = RealmUnits()
        f2.identifier = "Fall 2"
        f2.units = Int(fall2.text ?? "") ?? 0
        f2.semesterOrQuarter = scToSemesterOrQuarter(segmentedControl: fall2S)
        let f3 = RealmUnits()
        f3.identifier = "Fall 3"
        f3.units = Int(fall3.text ?? "") ?? 0
        f3.semesterOrQuarter = scToSemesterOrQuarter(segmentedControl: fall3S)
        let f4 = RealmUnits()
        f4.identifier = "Fall 4"
        f4.units = Int(fall4.text ?? "") ?? 0
        f4.semesterOrQuarter = scToSemesterOrQuarter(segmentedControl: fall4S)
        
        let w1 = RealmUnits()
        w1.identifier = "Winter 1"
        w1.units = Int(winter1.text ?? "") ?? 0
        w1.semesterOrQuarter = scToSemesterOrQuarter(segmentedControl: winter1S)
        let w2 = RealmUnits()
        w2.identifier = "Winter 2"
        w2.units = Int(winter2.text ?? "") ?? 0
        w2.semesterOrQuarter = scToSemesterOrQuarter(segmentedControl: winter2S)
        let w3 = RealmUnits()
        w3.identifier = "Winter 3"
        w3.units = Int(winter3.text ?? "") ?? 0
        w3.semesterOrQuarter = scToSemesterOrQuarter(segmentedControl: winter3S)
        let w4 = RealmUnits()
        w4.identifier = "Winter 4"
        w4.units = Int(winter4.text ?? "") ?? 0
        w4.semesterOrQuarter = scToSemesterOrQuarter(segmentedControl: winter4S)
        
        let s1 = RealmUnits()
        s1.identifier = "Spring 1"
        s1.units = Int(spring1.text ?? "") ?? 0
        s1.semesterOrQuarter = scToSemesterOrQuarter(segmentedControl: spring1S)
        let s2 = RealmUnits()
        s2.identifier = "Spring 2"
        s2.units = Int(spring2.text ?? "") ?? 0
        s2.semesterOrQuarter = scToSemesterOrQuarter(segmentedControl: spring2S)
        let s3 = RealmUnits()
        s3.identifier = "Spring 3"
        s3.units = Int(spring3.text ?? "") ?? 0
        s3.semesterOrQuarter = scToSemesterOrQuarter(segmentedControl: spring3S)
        let s4 = RealmUnits()
        s4.identifier = "Spring 4"
        s4.units = Int(spring4.text ?? "") ?? 0
        s4.semesterOrQuarter = scToSemesterOrQuarter(segmentedControl: spring4S)
        
        let apO = RealmUnits()
        apO.identifier = "AP and Other"
        apO.units = Int(apOther.text ?? "") ?? 0
        apO.semesterOrQuarter = scToSemesterOrQuarter(segmentedControl: apOtherS)
        let cc = RealmUnits()
        cc.identifier = "Community College"
        cc.units = Int(ccUnits.text ?? "") ?? 0
        cc.semesterOrQuarter = scToSemesterOrQuarter(segmentedControl: ccUnitsS)
        
        let realmObjects: [RealmUnits] = [f1, f2, f3, f4, w1, w2, w3, w4, s1, s2, s3, s4, apO, cc]
        //add textfields to an array instead
        try! realm.write {
            let allUnitsToDelete = realm.objects(RealmUnits.self)
            realm.delete(allUnitsToDelete)
            realm.add(realmObjects)
        }
        segmentedControlStartingSegment()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    //alert for function resetUnitsData()
    @IBAction func resetAlertPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Reset Units?", message: "This will reset only the data on this page.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reset", style: .destructive, handler: resetUnitsData))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.activeTextField?.text = ""
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func helpPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "helpVC") as! HelpVC
        self.present(vc, animated: false, completion: nil)
    }
    
    
    // set all the textfields back to empty
    func resetUnitsData(alert: UIAlertAction!) {
        try! realm.write {
            let realmUnitsData = realm.objects(RealmUnits.self)
            realm.delete(realmUnitsData)
        }
        textFieldAmount()
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
        UIView.animate(withDuration: 0.5) {
            self.view.frame.origin.y = 0
        }
        
    }
    
    // to push current textfield above the keyboard if below, need to fix issue with black screen at bottom after dismissed
    @objc func keyboardWillChange(notification: Notification) {
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect) else {
            return
        }
        //kbHeight = keyboardRect.height
        //var tally: CGFloat = 0
        if (activeTextField?.frame.origin.y ?? 0) > keyboardRect.height {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.frame.origin.y = -((self.activeTextField?.frame.origin.y)! - keyboardRect.height)

            })
            
            //tally += -((activeTextField?.frame.origin.y)! - keyboardRect.height)
        } else if (activeTextField?.frame.origin.y) ?? 0 < keyboardRect.height {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.frame.origin.y = 0
            })
        }
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeTextField = textField
        return true
    }
    
    
    
    //probably could have done this a shorter way
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
            textField.resignFirstResponder()
            fall1.becomeFirstResponder()
        }
        return true
    }
    /*
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
 */
    func handleExtraEthicsOverCC() {
        // create, currently if ccEthics is the one that makes total greater than ccUnits (and error alert pop up), keybaord show doesnt work correctly and textfield is hidden
    }
    func textFieldAmount() {
        let f1text = realm.objects(RealmUnits.self).filter("identifier = 'Fall 1'").first?.units.description
        fall1.text = (f1text == "0") ? "" : f1text
        let f2text = realm.objects(RealmUnits.self).filter("identifier = 'Fall 2'").first?.units.description
        fall2.text = (f2text == "0") ? "" : f2text
        let f3text = realm.objects(RealmUnits.self).filter("identifier = 'Fall 3'").first?.units.description
        fall3.text = (f3text == "0") ? "" : f3text
        let f4text = realm.objects(RealmUnits.self).filter("identifier = 'Fall 4'").first?.units.description
        fall4.text = (f4text == "0") ? "" : f4text
        let w1text = realm.objects(RealmUnits.self).filter("identifier = 'Winter 1'").first?.units.description
        winter1.text = (w1text == "0") ? "" : w1text
        let w2text = realm.objects(RealmUnits.self).filter("identifier = 'Winter 2'").first?.units.description
        winter2.text = (w2text == "0") ? "" : w2text
        let w3text = realm.objects(RealmUnits.self).filter("identifier = 'Winter 3'").first?.units.description
        winter3.text = (w3text == "0") ? "" : w3text
        let w4text = realm.objects(RealmUnits.self).filter("identifier = 'Winter 4'").first?.units.description
        winter4.text = (w4text == "0") ? "" : w4text
        let s1text = realm.objects(RealmUnits.self).filter("identifier = 'Spring 1'").first?.units.description
        spring1.text = (s1text == "0") ? "" : s1text
        let s2text = realm.objects(RealmUnits.self).filter("identifier = 'Spring 2'").first?.units.description
        spring2.text = (s2text == "0") ? "" : s2text
        let s3text = realm.objects(RealmUnits.self).filter("identifier = 'Spring 3'").first?.units.description
        spring3.text = (s3text == "0") ? "" : s3text
        let s4text = realm.objects(RealmUnits.self).filter("identifier = 'Spring 4'").first?.units.description
        spring4.text = (s4text == "0") ? "" : s4text
        let apOtext = realm.objects(RealmUnits.self).filter("identifier = 'AP and Other'").first?.units.description
        apOther.text = (apOtext == "0") ? "" : apOtext
        let ccUtext = realm.objects(RealmUnits.self).filter("identifier = 'Community College'").first?.units.description
        ccUnits.text = (ccUtext == "0") ? "" : ccUtext

    }
    func scToSemesterOrQuarter(segmentedControl: UISegmentedControl) -> String {
        if segmentedControl.selectedSegmentIndex == 0 {
            return "semester"
        } else {
            return "quarter"
        }
    }
    
    // to set the segmented controls to the correct display of either semester or quarter when the app is loaded for the first time or a subsequent time
    func segmentedControlStartingSegment() {
        let objects = Array(realm.objects(RealmUnits.self))
        if objects.isEmpty == true {
            // preload the entry for quarters to whatever the user selected since it is the first time using the app
            if let userSelected = UserDefaults.standard.value(forKey: "units") as? String {
                var num: Int?
                if userSelected == "semester" {
                    num = 0
                } else if userSelected == "quarter" {
                    num = 1
                }
                if let n = num {
                   fall1S.selectedSegmentIndex = n; fall2S.selectedSegmentIndex = n; fall3S.selectedSegmentIndex = n; fall4S.selectedSegmentIndex = n; winter1S.selectedSegmentIndex = n; winter2S.selectedSegmentIndex = n; winter3S.selectedSegmentIndex = n; winter4S.selectedSegmentIndex = n; spring1S.selectedSegmentIndex = n; spring2S.selectedSegmentIndex = n; spring3S.selectedSegmentIndex = n; spring4S.selectedSegmentIndex = n; apOtherS.selectedSegmentIndex = n; ccUnitsS.selectedSegmentIndex = n
                }
            }
            
        } else {
            //preload the type of units to whatever the user had from before
            let match: [String?:UISegmentedControl] = ["Fall 1":fall1S, "Fall 2":fall2S, "Fall 3":fall3S, "Fall 4":fall4S, "Winter 1":winter1S, "Winter 2":winter2S, "Winter 3":winter3S, "Winter 4":winter4S, "Spring 1":spring1S, "Spring 2":spring2S, "Spring 3":spring3S, "Spring 4":spring4S, "AP and Other":apOtherS, "Community College":ccUnitsS]
            match.forEach { (pair) in
                let object = objects.filter{$0.identifier == pair.key}.first
                if object?.semesterOrQuarter == "semester" {
                    match[object?.identifier]?.selectedSegmentIndex = 0
                } else if object?.semesterOrQuarter == "quarter" {
                    match[object?.identifier]?.selectedSegmentIndex = 1
                }
            }
        }
    }
}

