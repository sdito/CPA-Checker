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
    
    @IBOutlet weak var accountingSubjectsStack: UIStackView!
    @IBOutlet weak var businessSubjectsStack: UIStackView!
    @IBOutlet weak var accountingStudyStack: UIStackView!
    @IBOutlet weak var ethicsStudyStack: UIStackView!
    
    @IBOutlet weak var accountingSubjectsArrow: UILabel!
    @IBOutlet weak var businessSubjectsArrow: UILabel!
    @IBOutlet weak var accountingStudyArrow: UILabel!
    @IBOutlet weak var ethicsStudyArrow: UILabel!
    
    
    @IBOutlet weak var viewArea: UIView!
    
    let acountingSubjectsMessage = "36 Quarter Units\n\nAccounting, Auditing, Taxation, Financial Reporting, Financial Statement Analysis, External & Internal Reporting"
    let busRelatedSubsMessage = "36 Quarter Units\n\nBusiness Administration, Business Management, Business Communication, Economics, Finance, Business Law, Marketing, Statistics, Mathematics, Computer Science & Information Systems, Business Related Law Courses Offered at an Accredited Law School, Any Accounting Subjects in excess of the 36 Units needed to fulfill the accounting requirement"
    let accountingStudyMessage = "30 Quarter Units\n\nMinimum 6 semester in accounting subjects (see above). Maximum 14 semester units in business-related subjects (see above). Maximum 9 semester units in other academic work relevant to business and accounting. Maximum 6 quarter units in internships/independent studies in accounting and/or business-related subjects. Completion of a Master of Accounting, Taxation, or Laws in Taxation is equivalent to 30 quarter units of accounting study."
    let ethicsStudyMessage = "15 Quarter Units\n\nMinimum 4 quarter units in accounting ethics of accountants' professional responsibilities; the course must be completed at an upper division level or higher, unless it was completed at a community college. Maximum 11 quarter units in courses in any of the following subject areas: Auditing, Government & Society, Business Leadership, Business Law, Corporate Governance, Corporate Social Responsibility, Ethics, Fraud, Human Resources Management, Legal Environment of Business, Management of Organizations, Morals, Organizational Behavior, Professional Responsibilities. Maximum 4 quarter units in courses from the following disciplines: Philosophy, Religion, Theology. Course title must contain one of the following words or terms, or the sole name in the course title is the name of the discipline: Introduction, General, Fundamentals of, Survey of, Introductory, Principles of, Foundations of."
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func accountingSubjects(_ sender: Any) {
        addAndRemoveText(stack: accountingSubjectsStack, labelText: acountingSubjectsMessage, boolean: accountingSubjects, arrow: accountingSubjectsArrow)
        accountingSubjects = !accountingSubjects
    }
    @IBAction func businessSubjects(_ sender: Any) {
        addAndRemoveText(stack: businessSubjectsStack, labelText: busRelatedSubsMessage, boolean: buinessSubjects, arrow: businessSubjectsArrow)
        buinessSubjects = !buinessSubjects
    }
    @IBAction func accountingStudy(_ sender: Any) {
        addAndRemoveText(stack: accountingStudyStack, labelText: accountingStudyMessage, boolean: accountingStudy, arrow: accountingStudyArrow)
        accountingStudy = !accountingStudy
    }
    @IBAction func ethicsStudy(_ sender: Any) {
        addAndRemoveText(stack: ethicsStudyStack, labelText: ethicsStudyMessage, boolean: ethicsStudy, arrow: ethicsStudyArrow)
        ethicsStudy = !ethicsStudy
    }
    
    func addAndRemoveText(stack: UIStackView, labelText: String, boolean: Bool, arrow: UILabel) {
        let label = UILabel()
        label.text = labelText
        label.numberOfLines = 0
        label.font = UIFont(name: "avenir", size: 17)
        if boolean == false {
            stack.insertArrangedSubview(label, at: 1)
        } else {
            let view = stack.subviews.last!
            view.removeFromSuperview()
        }
        if boolean == false {
            arrow.transform = CGAffineTransform(rotationAngle: .pi/1)
        } else {
            arrow.transform = CGAffineTransform(rotationAngle: 0)
        }
    }
    
    @IBAction func helpPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "helpVC") as! HelpVC
        self.present(vc, animated: false, completion: nil)
    }
    
}

