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
    
    @IBOutlet weak var universityArrow: UILabel!
    @IBOutlet weak var termsArrow: UILabel!
    @IBOutlet weak var aboutArrow: UILabel!
    
    
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
        // do not have to delete all the classes from database technically, would only show in status when that specific university is selected
        /*
        try! realm.write {
            realm.deleteAll()
        }
         */
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
        label.text = "Select the below button to select a new University to calculate CPA status for. Selecting a new university will erase all of the data you currently have. This action can't be undone.\n\nAre you sure you want to select a new University?"
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
        if newSchool == false {
            universityArrow.transform = CGAffineTransform(rotationAngle: .pi/1)
        } else {
            universityArrow.transform = CGAffineTransform(rotationAngle: 0)
        }
        
        newSchool = !newSchool
    }
    @IBAction func termsPressed(_ sender: Any) {
        let label = UILabel()
        label.text = "No guarantee in the accuracy of the app. Recalculate with an outside source to ensure accuracy.\n\nContact resources from your university to ensure accuracy."
        label.numberOfLines = 0
        label.font = UIFont(name: "avenir", size: 17)
        label.textAlignment = .center
        if terms == false {
            termsStackView.insertArrangedSubview(label, at: 1)
        } else {
            let view = termsStackView.subviews.last!
            view.removeFromSuperview()
        }
        // rotate the arrow in a label 180 degrees
        if terms == false {
            termsArrow.transform = CGAffineTransform(rotationAngle: .pi/1)
        } else {
            termsArrow.transform = CGAffineTransform(rotationAngle: 0)
        }
        terms = !terms
    }
    @IBAction func aboutPressed(_ sender: Any) {
        let label = UILabel()
        label.text = "To filter classes, select 'Accounting' 'Business' and/or 'Ethics' on the Classes tab\n\nTo add a new class to the Classes tab, select the plus button on the top. Added classes can be deleted by swiping the class on the table."
        label.numberOfLines = 0
        label.font = UIFont(name: "avenir", size: 17)
        label.textAlignment = .center
        if about == false {
            aboutStackView.insertArrangedSubview(label, at: 1)
        } else {
            let view = aboutStackView.subviews.last!
            view.removeFromSuperview()
        }
        // rotate the arrow in a label 180 degrees
        if about == false {
            aboutArrow.transform = CGAffineTransform(rotationAngle: .pi/1)
        } else {
            aboutArrow.transform = CGAffineTransform(rotationAngle: 0)
        }
        about = !about
    }
}
