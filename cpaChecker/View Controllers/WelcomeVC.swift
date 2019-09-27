//
//  WelcomeVC.swift
//  cpaChecker
//
//  Created by Steven Dito on 6/15/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func begin(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "schoolSelectionVC") as! SchoolSelectVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}
