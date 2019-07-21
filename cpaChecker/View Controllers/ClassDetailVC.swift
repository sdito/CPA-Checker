//
//  ClassDetailVC.swift
//  cpaChecker
//
//  Created by Steven Dito on 5/28/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit
import RealmSwift

class ClassDetailVC: UIViewController {
    
    var units: Class?

    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var courseNumLabel: UILabel!
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var courseDescriptionLabel: UILabel!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var isAccounting: UILabel!
    @IBOutlet weak var isBusiness: UILabel!
    @IBOutlet weak var isEthics: UILabel!
    @IBOutlet weak var isFall: UILabel!
    @IBOutlet weak var isWinter: UILabel!
    @IBOutlet weak var isSpring: UILabel!
    @IBOutlet weak var isSummer: UILabel!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        //gradientView.setGradientBackground(colorOne: Colors.lightLightGray, colorTwo: Colors.lightGray)
    }
    private func setColorForLabel(boolean: Bool?, label: UILabel) {
        if boolean == true {
            label.textColor = Colors.main
        } else if boolean == false {
            label.textColor = .white
        } else {
            label.text = ""
        }
    }
    //allows user to see detailed view of selected class
    func createUI() {
        courseNumLabel.text = units?.courseNum
        courseTitleLabel.text = units?.title
        
        unitsLabel.text = "\(String(describing: units!.numUnits)) units"
        
        if let text = units?.courseDescription {
            courseDescriptionLabel.text = text
        } else {
            courseDescriptionLabel.text = "No description available."
        }
        setColorForLabel(boolean: units?.isAccounting, label: isAccounting)
        setColorForLabel(boolean: units?.isBusiness, label: isBusiness)
        setColorForLabel(boolean: units?.isEthics, label: isEthics)
        setColorForLabel(boolean: units?.offeredFall, label: isFall)
        setColorForLabel(boolean: units?.offeredWinter, label: isWinter)
        setColorForLabel(boolean: units?.offeredSpring, label: isSpring)
        setColorForLabel(boolean: units?.offeredSummer, label: isSummer)
        if units?.mustBeEthics == true {
            isEthics.text = "  Professional Ethics"
        }
    }
}
