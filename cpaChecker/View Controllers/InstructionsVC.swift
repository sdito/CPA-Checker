//
//  FirstViewController.swift
//  cpaChecker
//
//  Created by Steven Dito on 5/28/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit
import SafariServices

class InstructionsVC: UIViewController {
    @IBOutlet weak var accountingSubjectsLabel: UILabel!
    @IBOutlet weak var busRelatedSubsLabel: UILabel!
    @IBOutlet weak var accountingStudyLabel: UILabel!
    @IBOutlet weak var ethicsStudyLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var viewArea: UIView!
    
    let acountingSubjectsMessage = "36 Quarter Units - Accounting Subjects\n-Accounting, Auditing, Taxation, Financial Reporting, Financial Statement Analysis, External & Internal Reporting"
    let busRelatedSubsMessage = "36 Quarter Units - Business-Related Subejcts\n-Business Administration, Business Management, Business Communication, Economics, Finance, Business Law, Marketing, Statistics, Mathematics, Computer Science & Information Systems, Business Related Law Courses Offered at an Accredited Law School, Any Accounting Subjects in Excess of the 36 Units needed to fulfill the accounting requirement"
    let accountingStudyMessage = "30 Quarter Units - Accounting Study\n-Minimum 6 semester in accounting subjects (see above)\n-Maximum 14 semester units in business-related subjects (see above)\n-Maximum 9 semester units in other academic work relevant to business and accounting\nMaximum 6 quarter units in internships/independent studies in accounting and/or business-related subjects\n-Completion of a Master of Accounting, Taxation, or Laws in Taxation is equivalent to 30 quarter units of accounting study."
    let ethicsStudyMessage = "15 Quarter Units - Ethics Study\n-Minimum 4 quarter units in accounting ethics of accountants' professional responsibilities; the course must be completed at an upper division level or higher, unless it was completed at a community college.\n- Maximum 11 quarter units in courses in any of the following subject areas: Auditing, Government & Society, Business Leadership, Business Law, Corporate Governance, Corporate Social Responsibility, Ethics, Fraud, Human Resources Management, Legal Environment of Business, Management of Organizations, Morals, Organizational Behavior, Professional Responsibilities\n- Maximum 4 quarter units in courses from the following disciplines: Philosophy, Religion, Theology. Course title must contain one of the following words or terms, or the sole name in the course title is the name of the discipline: Introduction, General, Fundamentals of, Survey of, Introductory, Principles of, Foundations of"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        accountingSubjectsLabel.text = acountingSubjectsMessage
        busRelatedSubsLabel.text = busRelatedSubsMessage
        accountingStudyLabel.text = accountingStudyMessage
        ethicsStudyLabel.text = ethicsStudyMessage
    }

    @IBAction func cpaWebsite(_ sender: Any) {
        let url: URL = URL(string: "https://www.calcpa.org/cpa-career-center/cpa-requirements")!
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: false, completion: nil)
    }

    
}

