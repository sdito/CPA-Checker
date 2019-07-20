//
//  FirstViewController.swift
//  cpaChecker
//
//  Created by Steven Dito on 5/28/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit

class InstructionsVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    private var accountingSubjects = false
    private var buinessSubjects = false
    private var accountingStudy = false
    private var ethicsStudy = false
    private var professionalEthics = false
    
    @IBOutlet weak var accountingSubjectsStack: UIStackView!
    @IBOutlet weak var businessSubjectsStack: UIStackView!
    @IBOutlet weak var accountingStudyStack: UIStackView!
    @IBOutlet weak var ethicsStudyStack: UIStackView!
    @IBOutlet weak var professionalEthicsStack: UIStackView!
    
    @IBOutlet weak var accountingSubjectsArrow: UILabel!
    @IBOutlet weak var businessSubjectsArrow: UILabel!
    @IBOutlet weak var accountingStudyArrow: UILabel!
    @IBOutlet weak var ethicsStudyArrow: UILabel!
    @IBOutlet weak var professionalEthicsArrow: UILabel!
    @IBOutlet weak var degreeInfo: UILabel!
    
    
    
    @IBOutlet weak var viewArea: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // if a user's colleges selected include a semester and quarter school, let the user decide if the app should use semester or quarter
        if let units = UserDefaults.standard.value(forKey: "units") as? String {
            if units == "user" {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "quarterSemesterID") as! QuarterSemesterVC
                self.present(vc, animated: false, completion: nil)
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        degreeInfo.text = "Baccalaureate Degree & \(SharedUnits.shared.units["totalUnits"] ?? 0) \(SharedUnits.shared.text) Units"
    }
    
    @IBAction func accountingSubjects(_ sender: Any) {
        // add or remove text from stack view after user selects related button, text depends on if semester or quarter, rotate the arrow depending on if the user is adding the text or removing the text
        accountingSubjectsStack.addOrRemoveFromSV(txt: Messages.accountingSubjects, boolean: accountingSubjects, textColor: .white)
        accountingSubjectsArrow.rotate(boolean: accountingSubjects)
        accountingSubjects = !accountingSubjects
    }
    @IBAction func businessSubjects(_ sender: Any) {
        businessSubjectsStack.addOrRemoveFromSV(txt: Messages.businessSubjects, boolean: buinessSubjects, textColor: .white)
        businessSubjectsArrow.rotate(boolean: buinessSubjects)
        buinessSubjects = !buinessSubjects

    }
    @IBAction func accountingStudy(_ sender: Any) {
        accountingStudyStack.addOrRemoveFromSV(txt: Messages.accountingStudy, boolean: accountingStudy, textColor: .white)
        accountingStudyArrow.rotate(boolean: accountingStudy)
        accountingStudy = !accountingStudy
    }
    @IBAction func ethicsStudy(_ sender: Any) {
        ethicsStudyStack.addOrRemoveFromSV(txt: Messages.ethicsStudy, boolean: ethicsStudy, textColor: .white)
        ethicsStudyArrow.rotate(boolean: ethicsStudy)
        ethicsStudy = !ethicsStudy
    }
    @IBAction func professionalEthics(_ sender: Any) {
        professionalEthicsStack.addOrRemoveFromSV(txt: Messages.professionalEthics, boolean: professionalEthics, textColor: .white)
        professionalEthicsArrow.rotate(boolean: professionalEthics)
        professionalEthics = !professionalEthics
    }
    
    @IBAction func helpPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "helpVC") as! HelpVC
        self.present(vc, animated: false, completion: nil)
    }

}

