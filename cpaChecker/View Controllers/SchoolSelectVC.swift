//
//  SchoolSelectVC.swift
//  cpaChecker
//
//  Created by Steven Dito on 6/15/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit
import SQLite


class SchoolSelectVC: UIViewController {

    @IBOutlet weak var continueLabel: UIButton!
    
    @IBOutlet weak var collegeNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var whatSchoolSelected: String?
    
    var schoolIdentifier: [String:Int] = [:]
    
    let path = Bundle.main.path(forResource: "cpa", ofType: "db")!
    
    /*
    var tempCollegeList = ["California Polytechnic State University, San Luis Obispo", "University of California - Santa Barbara", "University of California - Los Angeles", "University of Southern California", "Stanford", "Harvard", "San Diego State University", "Santa Clara University", "University of California - San Diego", "California Polytechnic State University, Pomona"]
    var string = "string"
    var filteredCollegeList: [String] = []
    */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .lightGray
        continueLabel.setGradientBackground(colorOne: Colors.lightLightGray, colorTwo: Colors.lightGray)
        tableView.delegate = self
        tableView.dataSource = self
        //filteredCollegeList = tempCollegeList
        let db = try? Connection(path, readonly: true)
        for s in try! db!.prepare(
            """
            SELECT name, collegeID FROM colleges
            """
            ) {
                schoolIdentifier[s[0] as! String] = Int(s[1] as! Int64)
                
        }
    }
    @IBAction func continuePressed(_ sender: Any) {
        if whatSchoolSelected == nil {
            
        } else {
            performSegue(withIdentifier: "continuePressed", sender: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        var ac: [Class] = []
        let index = schoolIdentifier[whatSchoolSelected!]
        let db = try? Connection(path, readonly: true)
        for c in try! db!.prepare("""
            SELECT * FROM classes co
            WHERE collegeID = \(index ?? 0)
            """)
                {
                    let add = Class.init(
                        courseNum: c[0] as! String,
                        title: c[1] as! String,
                        description: c[2] as? String,
                        isAccounting: intToBool(int: Int(c[3] as! Int64)) ?? false,
                        isBusiness: intToBool(int: Int(c[4] as! Int64)) ?? false,
                        isEthics: intToBool(int: Int(c[5] as! Int64)) ?? false,
                        numUnits: Int(c[6] as! Int64),
                        offeredFall: nil,
                        offeredWinter: nil,
                        offeredSpring: nil,
                        offeredSummer: nil,
                        mustBeEthics: intToBool(int: Int(c[11] as! Int64)) ?? false,
                        collegeID: Int(c[12] as! Int64))
                    ac.append(add)
                    
                        
            }
        SharedAllClasses.shared.sharedAllClasses = ac
    }
}


extension SchoolSelectVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolIdentifier.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collegeCell")
        //let school = filteredCollegeList[indexPath.row]
        let school = Array(schoolIdentifier.keys)[indexPath.row]
        cell?.textLabel?.text = school
        cell?.textLabel?.font = UIFont(name: "avenir", size: 17)
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        collegeNameLabel.text = Array(schoolIdentifier.keys)[indexPath.row]
        whatSchoolSelected = Array(schoolIdentifier.keys)[indexPath.row]
        UserDefaults.standard.set(Array(schoolIdentifier.keys)[indexPath.row], forKey: "college")
    }
}


func intToBool(int: Int?) -> Bool? {
    if int ==  1 {
        return true
    } else if int == 0 {
        return false
    } else {
        return nil
    }
}


