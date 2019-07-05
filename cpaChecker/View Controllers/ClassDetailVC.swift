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
    
    //allows user to see detailed view of selected class
    func createUI() {
        courseNumLabel.text = units?.courseNum
        courseTitleLabel.text = units?.title
        courseDescriptionLabel.text = units?.courseDescription
        unitsLabel.text = "\(String(describing: units!.numUnits)) units"
        if units?.isAccounting == true {
            isAccounting.textColor = Colors.main
        } else {
            isAccounting.textColor = .white
        }
        if units?.isBusiness == true {
            isBusiness.textColor = Colors.main
        } else {
            isBusiness.textColor = .white
        }
        if units?.isEthics == true {
            isEthics.textColor = Colors.main
        } else {
            isEthics.textColor = .white
        }
        if units?.offeredFall == true {
            isFall.textColor = Colors.main
        } else if units?.offeredFall == false{
            isFall.textColor = .white
        } else {
            isFall.text = ""
        }
        if units?.offeredWinter == true {
            isWinter.textColor = Colors.main
        } else if units?.offeredWinter == false{
            isWinter.textColor = .white
        } else {
            isWinter.text = ""
        }
        if units?.offeredSpring == true {
            isSpring.textColor = Colors.main
        } else if units?.offeredSpring == false{
            isSpring.textColor = .white
        } else {
            isSpring.text = ""
        }
        if units?.offeredSummer == true {
            isSummer.textColor = Colors.main
        } else if units?.offeredSummer == false {
            isSummer.textColor = .white
        } else {
            isSummer.text = ""
        }
        if units?.mustBeEthics == true {
            isEthics.text = "  Professional Ethics"
        }
    }
}
