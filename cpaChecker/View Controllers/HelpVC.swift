//
//  HelpVC.swift
//  cpaChecker
//
//  Created by Steven Dito on 7/1/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit
import RealmSwift

protocol UpdateUnitLabels {
    func updateLabels()
}

class HelpVC: UIViewController {
    var delagate: UpdateUnitLabels!
    private var newSchool = false
    private var about = false
    private var terms = false
    
    @IBOutlet weak var switchUnitsOutlet: UIButton!
    @IBOutlet weak var universityStackView: UIStackView!
    @IBOutlet weak var termsStackView: UIStackView!
    @IBOutlet weak var aboutStackView: UIStackView!
    @IBOutlet weak var universityArrow: UILabel!
    @IBOutlet weak var termsArrow: UILabel!
    @IBOutlet weak var aboutArrow: UILabel!
    //@IBOutlet weak var exitOutlet: UIButton!
    
    var realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        realm = try! Realm()
        switchUnitsOutlet.setTitle(Messages.switchUnits, for: .normal)
    }

    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @objc func schoolButtonAction(sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "schoolSelectionVC") as! SchoolSelectVC
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func selectNewSchool(_ sender: Any) {
        let label = UILabel()
        let button = UIButton()
        button.setTitle("Select New University", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.setTitleShadowColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "avenir", size: 20)
        button.addTarget(self, action: #selector(schoolButtonAction), for: .touchUpInside)
        
        let firstView = universityStackView.subviews.first
        label.text = Messages.newSchoolText
        label.numberOfLines = 0
        label.font = UIFont(name: "avenir", size: 17)
        label.textAlignment = .center
        if newSchool == false {
            universityStackView.insertArrangedSubview(label, at: 1)
            universityStackView.insertArrangedSubview(button, at: 2)
        } else {
            //let view = universityStackView.subviews.last!
            universityStackView.subviews.forEach { v in
                if v != firstView {
                    v.removeFromSuperview()
                }
            }
        }
        // rotate the arrow in a label 180 degrees
        universityArrow.rotate(boolean: newSchool)
        newSchool = !newSchool
    }
    @IBAction func termsPressed(_ sender: Any) {
        termsStackView.addOrRemoveFromSV(txt: Messages.termsText, boolean: terms, textColor: .black)
        // rotate the arrow in a label 180 degrees
        termsArrow.rotate(boolean: terms)
        terms = !terms
    }
    @IBAction func aboutPressed(_ sender: Any) {
        aboutStackView.addOrRemoveFromSV(txt: Messages.aboutText, boolean: about, textColor: .black)
        // rotate the arrow in a label 180 degrees
        aboutArrow.rotate(boolean: about)
        about = !about
    }
    @IBAction func switchTypeOfUnits(_ sender: Any) {
        var str = UserDefaults.standard.value(forKey: "units") as! String
        str.changeUnitType()
        UserDefaults.standard.set(str, forKey: "units")
        switchUnitsOutlet.setTitle(Messages.switchUnits, for: .normal)
        delagate.updateLabels()
    }
}



