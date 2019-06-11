//
//  SecondViewController.swift
//  cpaChecker
//
//  Created by Steven Dito on 5/28/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit
import RealmSwift

// WHEN CLASS IS DELETED AND TRIED TO BE ADDED AGAIN IT CURRENTLY DOES NOT WORK, PROBABLY SOMETHING FROM ALLCOURSENUMS

class ClassListSelectionVC: UIViewController {
    var sortedClasses: [Class] = SharedAllClasses.shared.sharedAllClasses
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var accountingSortedOutlet: UIButton!
    @IBOutlet weak var businessSortedOutlet: UIButton!
    @IBOutlet weak var ethicsSortedOutlet: UIButton!
    @IBOutlet weak var headerViewGradient: UIView!
    var sortAccounting = false
    var sortBusiness = false
    var sortEthics = false
    var realm = try! Realm()
    //var setTo_allCourseNums: Set<String>?
    var blurBackground: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "Realm location print didnt work")
        headerViewGradient.setGradientBackground(colorOne: Colors.lightLightGray, colorTwo: Colors.lightGray)
    }
    // need to fix the deleted class getting added again from here
//    override func viewDidAppear(_ animated: Bool) {
//        updateTableInfoAndResetData()
//        for item in realm.objects(RealmNewClass.self) {
//            let newClass = Class(courseNum: item.courseNum.uppercased(), title: "User added class", description: nil, isAccounting: item.isAccounting, isBusiness: item.isBusiness, isEthics: item.isEthics, numUnits: item.numUnits, offeredFall: nil, offeredWinter: nil, offeredSpring: nil, offeredSummer: nil)
//            var allCourseNums: [String] = []
//            for name in SharedAllClasses.shared.sharedAllClasses {
//                allCourseNums.append(name.courseNum)
//            }
//            if allCourseNums.contains(newClass.courseNum) {
//                print("Dont add")
//            } else {
//                //combinedClasses.append(newClass)
//                SharedAllClasses.shared.sharedAllClasses.append(newClass)
//                updateClassesForTableView(acc: sortAccounting, bus: sortBusiness, eth: sortEthics)
//            }
//        }
//        tableView.reloadData()
//    }
    // assimilates the classes from realm into sharedAllClasses and eventually sortedClasses through updateClassesForTableView, only does not allow duplicate classes to be shown on the table view,
    func updateTableInfoAndResetData() {
        for item in realm.objects(RealmNewClass.self) {
            let newClass = Class(courseNum: item.courseNum.uppercased(), title: "User added class", description: nil, isAccounting: item.isAccounting, isBusiness: item.isBusiness, isEthics: item.isEthics, numUnits: item.numUnits, offeredFall: nil, offeredWinter: nil, offeredSpring: nil, offeredSummer: nil)
            var allCourseNums: [String] = []
            for name in SharedAllClasses.shared.sharedAllClasses {
                allCourseNums.append(name.courseNum)
            }
            if allCourseNums.contains(newClass.courseNum) {
                //do nothing
            } else {
                //combinedClasses.append(newClass)
                SharedAllClasses.shared.sharedAllClasses.append(newClass)
                updateClassesForTableView(acc: sortAccounting, bus: sortBusiness, eth: sortEthics)
            }
        }
        tableView.reloadData()
        //tableView.scrollToRow(at: IndexPath, at: scrollPositiom, animated: bool)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "classDetailSegue" {
            let destVC = segue.destination as! ClassDetailVC
            destVC.units = sender as? Class
        }
    }
    
    @IBAction func accountingSorted(_ sender: Any) {
        sortAccounting = !sortAccounting
        if sortAccounting == true {accountingSortedOutlet.backgroundColor = .yellow
        } else {
            accountingSortedOutlet.backgroundColor = .clear
        }
        updateClassesForTableView(acc: sortAccounting, bus: sortBusiness, eth: sortEthics)
        tableView.reloadData()
    }
    @IBAction func businessSorted(_ sender: Any) {
        sortBusiness = !sortBusiness
        if sortBusiness == true {
            businessSortedOutlet.backgroundColor = .yellow
        } else {
            businessSortedOutlet.backgroundColor = .clear
        }
        updateClassesForTableView(acc: sortAccounting, bus: sortBusiness, eth: sortEthics)
        tableView.reloadData()
    }
    @IBAction func ethicsSorted(_ sender: Any) {
        sortEthics = !sortEthics
        if sortEthics == true {
            ethicsSortedOutlet.backgroundColor = .yellow
        } else {
            ethicsSortedOutlet.backgroundColor = .clear
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
    
    func overlayBlurredBackgroundView() {
        let blurredBackgroundView = UIVisualEffectView()
        blurredBackgroundView.frame = view.frame
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
extension ClassListSelectionVC: PopUpDelegate {
    func removeBlurViews() {
        removeBlurredBackgroundView()
    }
    
    func resetTableData() {
        updateTableInfoAndResetData()
    }
}
// need to get this to work to get pop up view to work correctly UI wise

extension ClassListSelectionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedClasses.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let units = sortedClasses[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCell") as! ClassCell
        cell.setClassData(units: units)
        cell.delegate = self
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let units = sortedClasses[indexPath.row]
        performSegue(withIdentifier: "classDetailSegue", sender: units)
    }
    // dont want to delete classes that are programmed in
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        if indexPath.row < createClasses().count {
//            return false
//        } else {
//            return true
//        }
        if sortedClasses[indexPath.row].courseDescription == nil {
            return true
        } else {
            return false
        }
    }
    // delete the object from the realm and also tableView if the class was user created
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let courseNum = sortedClasses[indexPath.row]
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
            sortedClasses.remove(at: indexPath.row)
            SharedAllClasses.shared.sharedAllClasses = SharedAllClasses.shared.sharedAllClasses.filter{$0.courseNum != courseNum.courseNum}
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
    }
}
