//
//  SecondViewController.swift
//  cpaChecker
//
//  Created by Steven Dito on 5/28/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit
import RealmSwift
import SQLite

class ClassListSelectionVC: UIViewController {
    var sortedClasses: [Class] = []
    
    var arrayArrayClasses: [[Class]] = []
    var sectionNames: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var accountingSortedOutlet: UIButton!
    @IBOutlet weak var businessSortedOutlet: UIButton!
    @IBOutlet weak var ethicsSortedOutlet: UIButton!
    @IBOutlet weak var headerViewGradient: UIView!
    private var sortAccounting = false
    private var sortBusiness = false
    private var sortEthics = false
    var realm = try! Realm()
    
    
    var orderedCollegeDict: [Int:[Int:String]] = [:]
    var collegeDict: [Int:String] = [:]
    //var setTo_allCourseNums: Set<String>?
    
    var blurBackground: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "Realm location print didnt work")
        //headerViewGradient.setGradientBackground(colorOne: Colors.lightLightGray, colorTwo: Colors.lightGray)
        sortedClasses = SharedAllClasses.shared.sharedAllClasses
    }
    // need to fix the deleted class getting added again from here
    override func viewDidAppear(_ animated: Bool) {
        collegeDict.removeAll()
        let p = Bundle.main.path(forResource: "cpa", ofType: "db")!
        let db = try? Connection(p, readonly: true)
        for s in try! db!.prepare(
            """
            SELECT name, collegeID FROM colleges
            order by name
            """
            ) {
                collegeDict[Int(s[1] as! Int64)] = s[0] as? String
                
        }
        (sectionNames, arrayArrayClasses) = sortedClasses.classesForTableViewSections(colleges: collegeDict)
        //updateTableInfoAndResetData()
        SharedAllClasses.shared.sharedAllClasses = Array(realm.objects(RealmNewClass.self)).addNewClassesTo(courses: SharedAllClasses.shared.sharedAllClasses)
        updateClassesForTableView(acc: sortAccounting, bus: sortBusiness, eth: sortEthics)
        tableView.reloadData()
    }

    //pop up to add classes
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "classDetailSegue" {
            let destVC = segue.destination as! ClassDetailVC
            destVC.units = sender as? Class
        }
    }
    //only show classes that have accounting and potentially others
    @IBAction func accountingSorted(_ sender: Any) {
        sortAccounting = !sortAccounting
        if sortAccounting == true {
            accountingSortedOutlet.backgroundColor = Colors.main
            accountingSortedOutlet.setTitleColor(.black, for: .normal)
        } else {
            accountingSortedOutlet.backgroundColor = .black
            accountingSortedOutlet.setTitleColor(Colors.main, for: .normal)
        }
        updateClassesForTableView(acc: sortAccounting, bus: sortBusiness, eth: sortEthics)
        tableView.reloadData()
    }
    //only show classes that have business and potentially others
    @IBAction func businessSorted(_ sender: Any) {
        sortBusiness = !sortBusiness
        if sortBusiness == true {
            businessSortedOutlet.backgroundColor = Colors.main
            businessSortedOutlet.setTitleColor(.black, for: .normal)
        } else {
            businessSortedOutlet.backgroundColor = .black
            businessSortedOutlet.setTitleColor(Colors.main, for: .normal)
        }
        updateClassesForTableView(acc: sortAccounting, bus: sortBusiness, eth: sortEthics)
        tableView.reloadData()
    }
    //only show classes that have ethics and potentially others
    @IBAction func ethicsSorted(_ sender: Any) {
        sortEthics = !sortEthics
        if sortEthics == true {
            ethicsSortedOutlet.backgroundColor = Colors.main
            ethicsSortedOutlet.setTitleColor(.black, for: .normal)
        } else {
            ethicsSortedOutlet.backgroundColor = .black
            ethicsSortedOutlet.setTitleColor(Colors.main, for: .normal)
        }
        updateClassesForTableView(acc: sortAccounting, bus: sortBusiness, eth: sortEthics)
        tableView.reloadData()
    }
    
    @IBAction func addClassPopUp(_ sender: Any) {
        overlayBlurredBackgroundView()
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popOverID") as! PopUpVC
        popOverVC.delegate = self
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    @IBAction func reset(_ sender: Any) {
        let alert = UIAlertController(title: "Reset Classes Taken?", message: "This will reset only the data on this page.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Reset", style: .destructive, handler: deleteClasses))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func deleteClasses(alert: UIAlertAction!) {
        try! realm.write {
            let all = realm.objects(RealmClass.self)
            realm.delete(all)
            tableView.reloadData()
        }
    }
    
    func overlayBlurredBackgroundView() {
        let blurredBackgroundView = UIVisualEffectView()
        blurredBackgroundView.frame = UIScreen.main.bounds//view.frame
        blurredBackgroundView.effect = UIBlurEffect(style: .dark)
        view.addSubview(blurredBackgroundView)
    }
    func removeBlurredBackgroundView() {
        for subview in view.subviews {
            if subview.isKind(of: UIVisualEffectView.self) {
                subview.removeFromSuperview()
            }
        }
    }
    
    // to filter classes in main table view based on what buttons are selected
    func updateClassesForTableView(acc: Bool, bus: Bool, eth: Bool) {
        if (acc == true) && (bus == true) && (eth == true) {
            sortedClasses = SharedAllClasses.shared.sharedAllClasses.filter{$0.isAccounting == true && $0.isBusiness == true && $0.isEthics == true}
        } else if (acc == true) && (bus == true) && (eth == false) {
            sortedClasses = SharedAllClasses.shared.sharedAllClasses.filter{$0.isAccounting == true && $0.isBusiness == true}
        } else if (acc == true) && (bus == false) && (eth == true) {
            sortedClasses = SharedAllClasses.shared.sharedAllClasses.filter{$0.isAccounting == true && $0.isEthics == true}
        } else if (acc == false) && (bus == true) && (eth == true) {
            sortedClasses = SharedAllClasses.shared.sharedAllClasses.filter{$0.isEthics == true && $0.isBusiness == true}
        } else if (acc == true) && (bus == false) && (eth == false) {
            sortedClasses = SharedAllClasses.shared.sharedAllClasses.filter{$0.isAccounting == true}
        } else if (acc == false) && (bus == true) && (eth == false) {
            sortedClasses = SharedAllClasses.shared.sharedAllClasses.filter{$0.isBusiness == true}
        } else if (acc == false) && (bus == false) && (eth == true) {
            sortedClasses = SharedAllClasses.shared.sharedAllClasses.filter{$0.isEthics == true}
        } else if (acc == false) && (bus == false) && (eth == false) {
            sortedClasses = SharedAllClasses.shared.sharedAllClasses
        } else {
            sortedClasses = SharedAllClasses.shared.sharedAllClasses
        }
        (sectionNames, arrayArrayClasses) = sortedClasses.classesForTableViewSections(colleges: collegeDict)
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

//fix ui after pop up is dismissed
extension ClassListSelectionVC: PopUpDelegate {
    func removeBlurViews() {
        removeBlurredBackgroundView()
    }
    
    func resetTableData() {
        SharedAllClasses.shared.sharedAllClasses = Array(realm.objects(RealmNewClass.self)).addNewClassesTo(courses: SharedAllClasses.shared.sharedAllClasses)
        updateClassesForTableView(acc: sortAccounting, bus: sortBusiness, eth: sortEthics)
        tableView.reloadData()
    }
}
// need to get this to work to get pop up view to work correctly UI wise

extension ClassListSelectionVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    /*
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    */
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let l = UILabel()
        l.text = sectionNames[section]
        l.font = UIFont(name: "avenir", size: 15)
        l.textColor = .black
        l.backgroundColor = .white
        l.alpha = 0.9
        return l
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayArrayClasses[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let units = arrayArrayClasses[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCell") as! ClassCell
        cell.setClassData(units: units)
        cell.delegate = self
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let units = arrayArrayClasses[indexPath.section][indexPath.row]
        performSegue(withIdentifier: "classDetailSegue", sender: units)
    }
    // dont want to delete classes that are programmed in
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if arrayArrayClasses[indexPath.section][indexPath.row].collegeID == 0 {
            return true
        } else {
            return false
        }
    }
    // delete the object from the realm and also tableView if the class was user created
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let courseNum = arrayArrayClasses[indexPath.section][indexPath.row]
            
            // doesnt work now
            //deletes class from RealmNewClass
            let count = realm.objects(RealmNewClass.self).filter("courseNum = '\(courseNum.courseNum.uppercased())'").count
            
            if count >= 1 {
                try! realm.write {
                    realm.delete(realm.objects(RealmNewClass.self).filter("courseNum = '\(courseNum.courseNum.uppercased())'"))
//                    realm.delete(realm.objects(RealmNewClass.self).filter("courseNum = '\(courseNum.courseNum.uppercased())'").first!)
                }
            }
            //used to delete class object from RealmClass if class is currently selected
            let rcCount = realm.objects(RealmClass.self).filter("courseNum = '\(courseNum.courseNum.uppercased())'").count
            if rcCount >= 1 {
                let toDelete = realm.objects(RealmClass.self).filter("courseNum = '\(courseNum.courseNum.uppercased())'")
                try! realm.write {
                    realm.delete(toDelete)
                }
            }
            //have to delete the class from both, probably could reconcile into one delete by combining them somewhere
            
            arrayArrayClasses[indexPath.section].remove(at: indexPath.row)
            
            // NOT sure if i still need to update sharedAllClasses with the deleted classes deleted, test
            SharedAllClasses.shared.sharedAllClasses = SharedAllClasses.shared.sharedAllClasses.filter{$0.courseNum != courseNum.courseNum}
            sortedClasses = sortedClasses.filter {$0.courseNum != courseNum.courseNum}
            //(sectionNames, arrayArrayClasses) = takeInClassesForTableViewSections(classes: sortedClasses, colleges: collegeDict)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
    }
}


