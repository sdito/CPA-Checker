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
        let text = "\(SharedUnits.shared.units["accountingSubjects"] ?? 0) \(SharedUnits.shared.text) Units\n\nAccounting, Auditing, Taxation, Financial Reporting, Financial Statement Analysis, External & Internal Reporting"
        accountingSubjectsStack.addOrRemoveFromSV(txt: text, boolean: accountingSubjects, textColor: .white)
        accountingSubjectsArrow.rotate(boolean: accountingSubjects)
        accountingSubjects = !accountingSubjects
    }
    @IBAction func businessSubjects(_ sender: Any) {
        let text = "\(SharedUnits.shared.units["businessRelatedSubjects"] ?? 0) \(SharedUnits.shared.text) Units\n\nBusiness Administration, Business Management, Business Communication, Economics, Finance, Business Law, Marketing, Statistics, Mathematics, Computer Science & Information Systems, Business Related Law Courses Offered at an Accredited Law School, Any Accounting Subjects in excess of the \(SharedUnits.shared.units["businessRelatedSubjects"] ?? 0) Units needed to fulfill the accounting requirement"
        businessSubjectsStack.addOrRemoveFromSV(txt: text, boolean: buinessSubjects, textColor: .white)
        businessSubjectsArrow.rotate(boolean: buinessSubjects)
        buinessSubjects = !buinessSubjects

    }
    @IBAction func accountingStudy(_ sender: Any) {
        let text = "\(SharedUnits.shared.units["accountingStudy"] ?? 0) \(SharedUnits.shared.text) Units\n\nMinimum 6 semester/9 quarter units in accounting subjects (see above). Maximum 14 semester/21 quarter units in business-related subjects (see above). Maximum 9 semester/14 quarter units in other academic work relevant to business and accounting. Maximum 4 semester/6 quarter units in internships/independent studies in accounting and/or business-related subjects. Completion of a Master of Accounting, Taxation, or Laws in Taxation is equivalent to 30 quarter units of accounting study"
        accountingStudyStack.addOrRemoveFromSV(txt: text, boolean: accountingStudy, textColor: .white)
        accountingStudyArrow.rotate(boolean: accountingStudy)
        accountingStudy = !accountingStudy
    }
    @IBAction func ethicsStudy(_ sender: Any) {
        let text = "\(SharedUnits.shared.units["ethicsStudy"] ?? 0) \(SharedUnits.shared.text) Units\n\nMinimum 3 semester/4 quarter units in accounting ethics of accountants' professional responsibilities; the course must be completed at an upper division level or higher, unless it was completed at a community college. Maximum 7 semester/11 quarter units in courses in any of the following subject areas: Auditing, Government & Society, Business Leadership, Business Law, Corporate Governance, Corporate Social Responsibility, Ethics, Fraud, Human Resources Management, Legal Environment of Business, Management of Organizations, Morals, Organizational Behavior, Professional Responsibilities. Maximum 3 semester/4 quarter units in courses from the following disciplines: Philosophy, Religion, Theology. Course title must contain one of the following words or terms, or the sole name in the course title is the name of the discipline: Introduction, General, Fundamentals of, Survey of, Introductory, Principles of, Foundations of"
        ethicsStudyStack.addOrRemoveFromSV(txt: text, boolean: ethicsStudy, textColor: .white)
        ethicsStudyArrow.rotate(boolean: ethicsStudy)
        ethicsStudy = !ethicsStudy
    }
    @IBAction func professionalEthics(_ sender: Any) {
        let text = "Professional Ethics is required as part of Ethics Study. An Example of a professional ethics class would be titled 'Accounting Ethics.' Professional ethics classes will be marked; tap on a class in the class selection list and see if the class qualifies"
        professionalEthicsStack.addOrRemoveFromSV(txt: text, boolean: professionalEthics, textColor: .white)
        professionalEthicsArrow.rotate(boolean: professionalEthics)
        professionalEthics = !professionalEthics
    }
    
    @IBAction func helpPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "helpVC") as! HelpVC
        self.present(vc, animated: false, completion: nil)
    }

}

