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
    var whatSchoolSelected: Set<String> = []
    
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
            order by name
            """
            ) {
                schoolIdentifier[s[0] as! String] = Int(s[1] as! Int64)
                
        }
    }
    @IBAction func continuePressed(_ sender: Any) {
        if whatSchoolSelected.isEmpty == true {
            
        } else {
            performSegue(withIdentifier: "continuePressed", sender: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        var index: [Int] = []
        var sqlSelect: String = ""
        var ac: [Class] = []
        whatSchoolSelected.forEach({ (item) in
            index.append(schoolIdentifier[item]!)
            sqlSelect.append(",\(String(describing: schoolIdentifier[item]!))")
        })
        sqlSelect.remove(at: sqlSelect.startIndex)
        UserDefaults.standard.set(sqlSelect, forKey: "college")
        print(sqlSelect)
        let db = try? Connection(path, readonly: true)
        for c in try! db!.prepare("""
            SELECT * FROM classes co
            WHERE collegeID in (\(sqlSelect))
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
        //collegeNameLabel.text = Array(schoolIdentifier.keys)[indexPath.row]
        let value = Array(schoolIdentifier.keys)[indexPath.row]
        print(value)
        
        whatSchoolSelected.insert(value)
        /*
        if whatSchoolSelected.contains(value) {
            print("remove")
            whatSchoolSelected.remove(value)
        } else {
            whatSchoolSelected.insert(value)
            print("Add")
        }
        */
        collegeNameLabel.text = setToString(set: whatSchoolSelected)
        print(whatSchoolSelected)
        //UserDefaults.standard.set(whatSchoolSelected, forKey: "colleges")
        
        //UserDefaults.standard.set(Array(schoolIdentifier.keys)[indexPath.row], forKey: "college")
        //print(Array(schoolIdentifier.keys)[indexPath.row])
        //print(UserDefaults.value(forKey: "colleges"))
    }
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let value = Array(schoolIdentifier.keys)[indexPath.row]
        print(value)
        whatSchoolSelected.remove(value)
        collegeNameLabel.text = setToString(set: whatSchoolSelected)
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
func setToString(set: Set<String>) -> String {
    var text = ""
    for item in set {
        if text == "" {
            text += item
        } else {
            text += " + \(item)"
        }
    }
    return text
}

