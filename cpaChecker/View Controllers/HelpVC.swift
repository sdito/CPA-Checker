//
//  HelpVC.swift
//  cpaChecker
//
//  Created by Steven Dito on 7/1/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit
import RealmSwift


class HelpVC: UIViewController {
    private var newSchool = false
    private var about = false
    private var terms = false
    
    @IBOutlet weak var universityStackView: UIStackView!
    @IBOutlet weak var termsStackView: UIStackView!
    @IBOutlet weak var aboutStackView: UIStackView!
    
    var realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        realm = try! Realm()
    }

    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @objc func schoolButtonAction(sender: UIButton) {
        print("worked")
        // do not have to delete all the classes from database technically, would only show in status when that specific university is selected
        
        try! realm.write {
            realm.deleteAll()
        }
        
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
        label.text = "Add school change text here"
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
        newSchool = !newSchool
    }
    @IBAction func termsPressed(_ sender: Any) {
        let label = UILabel()
        label.text = "Add text about the Terms here"
        if terms == false {
            termsStackView.insertArrangedSubview(label, at: 1)
        } else {
            let view = termsStackView.subviews.last!
            view.removeFromSuperview()
        }
        terms = !terms
    }
    @IBAction func aboutPressed(_ sender: Any) {
        let label = UILabel()
        label.text = "Add text about the About here"
        if about == false {
            aboutStackView.insertArrangedSubview(label, at: 1)
        } else {
            let view = aboutStackView.subviews.last!
            view.removeFromSuperview()
        }
        about = !about
    }
    
    
}
