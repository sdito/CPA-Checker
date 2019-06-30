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

    @IBOutlet weak var collegeNameLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var schoolSelectionNumber: Int?
    
    let path = Bundle.main.path(forResource: "cpa", ofType: "db")!
    
    
    var tempCollegeList = ["California Polytechnic State University, San Luis Obispo", "University of California - Santa Barbara", "University of California - Los Angeles", "University of Southern California", "Stanford", "Harvard", "San Diego State University", "Santa Clara University", "University of California - San Diego", "California Polytechnic State University, Pomona"]
    var string = "string"
    var filteredCollegeList: [String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        filteredCollegeList = tempCollegeList
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        var ac: [Class] = []
        let db = try? Connection(path, readonly: true)
        for c in try! db!.prepare("""
            SELECT * FROM classes co
            WHERE collegeID = 2
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
                    
                        print(add.courseNum, add.title, add.isAccounting, add.isBusiness, add.isEthics)
            }
        SharedAllClasses.shared.sharedAllClasses = ac
    }
}


extension SchoolSelectVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCollegeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collegeCell")
        let school = filteredCollegeList[indexPath.row]
        cell?.textLabel?.text = school
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        collegeNameLabel.text = filteredCollegeList[indexPath.row]
    }
}

extension SchoolSelectVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCollegeList.removeAll()
        for item in tempCollegeList {
            if item.contains(searchText) {
                filteredCollegeList.append(item)
                tableView.reloadData()
            }
        }
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


