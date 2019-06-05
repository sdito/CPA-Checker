//
//  SecondViewController.swift
//  cpaChecker
//
//  Created by Steven Dito on 5/28/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit
import RealmSwift

let allClasses = createClasses()

class ClassListSelectionVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "classDetailSegue" {
            let destVC = segue.destination as! ClassDetailVC
            destVC.units = sender as? Class
        }
    }
}

extension ClassListSelectionVC: ClassCellDelegate {
    func classSwitchPressed(units: Class) {
        let realmClass = RealmClass()
        realmClass.courseNum = units.courseNum
        realmClass.title = units.title
        realmClass.isAccounting = units.isAccounting
        realmClass.isBusiness = units.isBusiness
        realmClass.isEthics = units.isEthics
        realmClass.numUnits = units.numUnits
        
        if realm.objects(RealmClass.self).filter("courseNum = '\(units.courseNum)'").count >= 1 {
            try! realm.write {
                let realmToDelete = realm.objects(RealmClass.self).filter("courseNum = '\(units.courseNum)'")
                realm.delete(realmToDelete)
            }
        } else {
            try! realm.write {
                realm.add(realmClass)
            }
        }
    }
}
extension ClassListSelectionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allClasses.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let units = allClasses[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCell") as! ClassCell
        cell.setClassData(units: units)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let units = allClasses[indexPath.row]
        performSegue(withIdentifier: "classDetailSegue", sender: units)
    }
}
