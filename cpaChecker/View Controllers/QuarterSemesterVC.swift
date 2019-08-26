//
//  QuarterSemesterVC.swift
//  cpaChecker
//
//  Created by Steven Dito on 7/7/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit


// only gets called when the user selects at least one quarter system school and one semester system school, user is able to change this value later  
class QuarterSemesterVC: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func done(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            UserDefaults.standard.set("semester", forKey: "units")
        } else if segmentedControl.selectedSegmentIndex == 1 {
            UserDefaults.standard.set("quarter", forKey: "units")
        }
        dismiss(animated: false, completion: nil)
    }
}
