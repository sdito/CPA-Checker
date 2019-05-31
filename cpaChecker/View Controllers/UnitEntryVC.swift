//
//  UnitEntryVC.swift
//  cpaChecker
//
//  Created by Steven Dito on 5/30/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit

class UnitEntryVC: UIViewController, UITextFieldDelegate {
    
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
        // create, currently if ccEthics is the one that makes total greater than ccUnits, keybaord show doesnt work correctly
    }
    
}


