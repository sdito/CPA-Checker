//
//  Messages.swift
//  cpaChecker
//
//  Created by Steven Dito on 7/18/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import Foundation
import UIKit

struct Messages {
    static var accountingSubjects: String {
        
        return "\(SharedUnits.shared.units["accountingSubjects"] ?? 0) \(SharedUnits.shared.text) Units\n\nAccounting, Auditing, Taxation, Financial Reporting, Financial Statement Analysis, External & Internal Reporting"
    
    }
    
    static var businessSubjects: String {
        return "\(SharedUnits.shared.units["businessRelatedSubjects"] ?? 0) \(SharedUnits.shared.text) Units\n\nBusiness Administration, Business Management, Business Communication, Economics, Finance, Business Law, Marketing, Statistics, Mathematics, Computer Science & Information Systems, Business Related Law Courses Offered at an Accredited Law School, Any Accounting Subjects in excess of the \(SharedUnits.shared.units["businessRelatedSubjects"] ?? 0) Units needed to fulfill the accounting requirement"
    }
    
    static var accountingStudy: String {
        return "\(SharedUnits.shared.units["accountingStudy"] ?? 0) \(SharedUnits.shared.text) Units\n\nMinimum 6 semester/9 quarter units in accounting subjects (see above). Maximum 14 semester/21 quarter units in business-related subjects (see above). Maximum 9 semester/14 quarter units in other academic work relevant to business and accounting. Maximum 4 semester/6 quarter units in internships/independent studies in accounting and/or business-related subjects. Completion of a Master of Accounting, Taxation, or Laws in Taxation is equivalent to 30 quarter units of accounting study"
    }
    static var ethicsStudy: String {
        
        return "\(SharedUnits.shared.units["ethicsStudy"] ?? 0) \(SharedUnits.shared.text) Units\n\nMinimum 3 semester/4 quarter units in accounting ethics of accountants' professional responsibilities; the course must be completed at an upper division level or higher, unless it was completed at a community college. Maximum 7 semester/11 quarter units in courses in any of the following subject areas: Auditing, Government & Society, Business Leadership, Business Law, Corporate Governance, Corporate Social Responsibility, Ethics, Fraud, Human Resources Management, Legal Environment of Business, Management of Organizations, Morals, Organizational Behavior, Professional Responsibilities. Maximum 3 semester/4 quarter units in courses from the following disciplines: Philosophy, Religion, Theology. Course title must contain one of the following words or terms, or the sole name in the course title is the name of the discipline: Introduction, General, Fundamentals of, Survey of, Introductory, Principles of, Foundations of"
    }
    static var switchUnits: String {
        var txt: String {
            if SharedUnits.shared.text == "Quarter" {
                return "Semester"
            } else {
                return "Quarter"
            }
        }
        return "Switch to \(txt) Units"
    }
    static let professionalEthics = "Professional Ethics is required as part of Ethics Study. An Example of a professional ethics class would be titled 'Accounting Ethics.' Professional ethics classes will be marked; tap on a class in the class selection list and see if the class qualifies"
    static let aboutText = "To filter classes, select 'Accounting' 'Business' and/or 'Ethics' on the Classes tab.\n\nTo add a new class to the Classes tab, select the plus button on the top. Added classes can be deleted by swiping the class on the table.\n\nS & Q for selecting units represents 'Semester' and 'Quarter'"
    static let newSchoolText = "Select the below button to select a new University to calculate CPA status for. Selecting a new university will not erase all the data you currently have. You will need to re-select the old university (along with the new university) if you want to add a new university to your list.\n\nAre you sure you want to select a new University?"
    static let termsText = "No guarantee in the accuracy of the app. Recalculate with an outside source to ensure accuracy.\n\nContact resources from your university to ensure accuracy."
    
}
