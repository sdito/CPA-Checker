//
//  SchoolSelectVC.swift
//  cpaChecker
//
//  Created by Steven Dito on 6/15/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit

class SchoolSelectVC: UIViewController {

    @IBOutlet weak var collegeNameLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
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
