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

    @IBOutlet weak var courseNumLabel: UILabel!
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var courseDescriptionLabel: UILabel!
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
        
    }
    
    func createUI() {
        courseNumLabel.text = units?.courseNum
        courseTitleLabel.text = units?.title
        courseDescriptionLabel.text = units?.courseDescription
        if units?.isAccounting == true {
            isAccounting.textColor = .green
        } else {
            isAccounting.textColor = .red
        }
        if units?.isBusiness == true {
            isBusiness.textColor = .green
        } else {
            isBusiness.textColor = .red
        }
        if units?.isEthics == true {
            isEthics.textColor = .green
        } else {
            isEthics.textColor = .red
        }
        if units?.offeredFall == true {
            isFall.textColor = .green
        } else if units?.offeredFall == false{
            isFall.textColor = .red
        } else {
            isFall.text = ""
        }
        if units?.offeredWinter == true {
            isWinter.textColor = .green
        } else if units?.offeredWinter == false{
            isWinter.textColor = .red
        } else {
            isWinter.text = ""
        }
        if units?.offeredSpring == true {
            isSpring.textColor = .green
        } else if units?.offeredSpring == false{
            isSpring.textColor = .red
        } else {
            isSpring.text = ""
        }
        if units?.offeredSummer == true {
            isSummer.textColor = .green
        } else if units?.offeredSummer == false {
            isSummer.textColor = .red
        } else {
            isSummer.text = ""
        }
    }
}
