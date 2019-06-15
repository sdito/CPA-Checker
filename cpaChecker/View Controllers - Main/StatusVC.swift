//
//  StatusVC.swift
//  cpaChecker
//
//  Created by Steven Dito on 5/31/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit
import RealmSwift

class StatusVC: UIViewController {
    
    var realm = try! Realm()
    var result: Result?
    var classesForTable: [Class] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var accountingUnitsNumber: UILabel!
    @IBOutlet weak var businessUnitsNumber: UILabel!
    @IBOutlet weak var ethicsUnitsNumber: UILabel!
    @IBOutlet weak var totalUnitsNumber: UILabel!
    @IBOutlet weak var combinationLabel: UILabel!
    @IBOutlet weak var forGradient: UIView!
    
    @IBOutlet weak var originalView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    var accounting = true
    var business = false
    var ethics = false
    var taking = true
    var available = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        forGradient.setGradientBackground(colorOne: Colors.lightLightGray, colorTwo: Colors.lightGray)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        result = calculateStatus()
        accountingUnitsNumber.text = result?.accountingUnits.description
        businessUnitsNumber.text = result?.businessUnits.description
        ethicsUnitsNumber.text = result?.ethicsUnits.description
        totalUnitsNumber.text = result?.totalUnits.description
        classesForTable = result!.accountingClasses
        tableView.reloadData()
    }
    
    
    
    @IBAction func accountingPressed(_ sender: Any) {
        accounting = true
        business = false
        ethics = false
        whatClassesForTable()
        if classesForTable.isEmpty == true {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            setCombinationLabel()
        }
    }
    @IBAction func businessPressed(_ sender: Any) {
        accounting = false
        business = true
        ethics = false
        whatClassesForTable()
        if classesForTable.isEmpty == true {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            setCombinationLabel()
        }
        
    }
    @IBAction func ethicsPressed(_ sender: Any) {
        accounting = false
        business = false
        ethics = true
        whatClassesForTable()
        if classesForTable.isEmpty == true {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            setCombinationLabel()
        }
        
    }
    @IBAction func totalPressed(_ sender: Any) {
        // still need to implement
        
    }
    @IBAction func showTaking(_ sender: Any) {
        taking = true
        available = false
        whatClassesForTable()
        if classesForTable.isEmpty == true {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            setCombinationLabel()
        }
        
    }
    @IBAction func showAvailable(_ sender: Any) {
        taking = false
        available = true
        whatClassesForTable()
        if classesForTable.isEmpty == true {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            setCombinationLabel()
        }
        
    }
    func whatClassesForTable() {
        if (accounting == true) && (taking == true) {
            classesForTable = result!.accountingClasses
        } else if (accounting == true) && (available == true) {
            classesForTable = result!.accountingClassesLeft
        } else if (business == true) && (taking == true) {
            classesForTable = result!.businessClasses
        } else if (business == true) && (available == true) {
            classesForTable = result!.businessClassesLeft
        } else if (ethics == true) && (taking == true) {
            classesForTable = result!.ethicsClasses
        } else if (ethics == true) && (available == true) {
            classesForTable = result!.ethicsClassesLeft
        } else {
            classesForTable = result!.accountingClasses
        }
    }
    func setCombinationLabel() {
        var classType: String?
        var takeAvailable: String?
        if accounting == true {
            classType = "Accounting"
        } else if business == true {
            classType = "Business"
        } else if ethics == true {
            classType = "Ethics"
        }
        if taking == true {
            takeAvailable = "Taking"
        } else if available == true {
            takeAvailable = "Available"
        }
        let message = "\(classType ?? "") - \(takeAvailable ?? "")"
        combinationLabel.text = message.description
    }

    // code could definitely be cleaner; takes classes from realm and converts that into result to be displayed
    func calculateStatus() -> Result {
        let accountingNeeded = 45
        let businessNeeded = 57
        let ethicsNeeded = 15
        
        var totalUnits: Int = 0
        var accountingUnits: Int = 0
        var businessUnits: Int = 0
        var ethicsUnits: Int = 0
        
        var accountingClasses: [Class] = []
        var businessClasses: [Class] = []
        var ethicsClasses: [Class] = []
        
        var accountingClassesLeft: [Class] = []
        var businessClassesLeft: [Class] = []
        var ethicsClassesLeft: [Class] = []
        
        var tempAccountingClasses = Array(realm.objects(RealmClass.self).filter("isAccounting = true"))
        var tempEthicsClasses = Array(realm.objects(RealmClass.self).filter("isEthics = true and isAccounting = false"))
        var tempBusinessClasses = Array(realm.objects(RealmClass.self).filter("isBusiness = true and isAccounting = false and isEthics = false"))

        
        for item in tempAccountingClasses {
            if item.courseNum == "BUS 424" {
                tempEthicsClasses.insert(item, at: 0)
                tempAccountingClasses.removeAll{$0.courseNum == "BUS 424"}
            }
        }
        //let currAccounting = howManyUnits(objects: tempAccountingClasses)
        let currBusiness = howManyUnits(objects: tempBusinessClasses)
        let currEthics = howManyUnits(objects: tempEthicsClasses)
        
        
        // possible extra accounting (BUS 425) could be added to ethics, need to add case for that
        //let currExtraAccounting = currAccounting - accountingNeeded
        //let currExtraBusiness = currBusiness - businessNeeded // shouldnt need to use
        let currExtraEthics = currEthics - ethicsNeeded
        
        let extraEthicsClasses = currExtraEthics / 4
        let neededBusinessClasses = (businessNeeded - currBusiness) / 4
        
        if (extraEthicsClasses >= 1) && (neededBusinessClasses > 0) {
            let extraClasses = extraEthicsClasses
            var neededBusinessClasses = businessNeeded / 4
            var amountToSwitch = min(extraClasses, neededBusinessClasses)
            
            for item in tempEthicsClasses {
                if (item.isBusiness == true) && (item.isAccounting == false) && (amountToSwitch > 0) {
                    let forDelete = item.courseNum
                    tempBusinessClasses.append(item)
                    tempEthicsClasses.removeAll{$0.courseNum == forDelete}
                    amountToSwitch -= 1
                    neededBusinessClasses -= 1
                }
            }
        }
        
        // NEED TO TEST
        // Fix issue for if there are less than 4 extra accounting units and not enough business units; the extra units from accounting should be pushed into business
//        let extraAccountingClasses = currExtraAccounting / 4  class
//        if (extraAccountingClasses >= 1) && (neededBusinessClasses > 0) {
//            var amtSwitch = min(extraAccountingClasses, neededBusinessClasses)
//            
//            for item in tempAccountingClasses {
//                if (item.isBusiness == true) && (amtSwitch > 0) {
//                    let forDelete = item.courseNum
//                    tempBusinessClasses.append(item)
//                    tempAccountingClasses.removeAll{$0.courseNum == forDelete}
//                    amtSwitch -= 1
//                    neededBusinessClasses -= 1
//                }
//            }
//        }

        (accountingClasses, accountingClassesLeft) = stringToClass(strings: tempAccountingClasses, type: "acc")
        (businessClasses, businessClassesLeft) = stringToClass(strings: tempBusinessClasses, type: "bus")
        (ethicsClasses, ethicsClassesLeft) = stringToClass(strings: tempEthicsClasses, type: "eth")
        
        let unitsRealm = Array(realm.objects(RealmUnits.self))
        for item in unitsRealm {
            if item.identifier == "ACC - CC" {
                accountingUnits = accountingUnits + item.units
            } else if item.identifier == "BUS - CC" {
                businessUnits = businessUnits + item.units
            } else if item.identifier == "ETH - CC" {
                ethicsUnits = ethicsUnits + item.units
            } else {
                totalUnits = totalUnits + item.units
            }
        }
        
        for item in accountingClasses {
            accountingUnits = accountingUnits + item.numUnits
        }
        for item in businessClasses {
            businessUnits = businessUnits + item.numUnits
        }
        for item in ethicsClasses {
            ethicsUnits = ethicsUnits + item.numUnits
        }
        
        // if there are extra accounting units and not enough business units, this will add the extra accounting units into business units
        if (accountingUnits > accountingNeeded) && (businessUnits < businessNeeded) {
            let amountToTransfer = min(accountingUnits - accountingNeeded, businessNeeded - businessUnits)
            accountingUnits = accountingUnits - amountToTransfer
            businessUnits = businessUnits + amountToTransfer
        }
        
        return Result(totalUnits: totalUnits, accountingUnits: accountingUnits, businessUnits: businessUnits, ethicsUnits: ethicsUnits, accountingClasses: accountingClasses, businessClasses: businessClasses, ethicsClasses: ethicsClasses, accountingClassesLeft: accountingClassesLeft, businessClassesLeft: businessClassesLeft, ethicsClassesLeft: ethicsClassesLeft)
    }
    
    func howManyUnits(objects: [RealmClass]) -> Int {
        var returnNum = 0
        for item in objects {
            returnNum += item.numUnits
        }
        return returnNum
    }
    
    // this adds a class that is already taken to the wrong section
    func stringToClass(strings: [RealmClass], type: String) -> ([Class], [Class]) {
        var classes: [Class] = []
        var notTakingClasses: [Class] = []
        
        var stringClasses: [String] = []
        strings.forEach { (item) in
            stringClasses.append(item.courseNum)
        }
        // original 'strings' ([RealmClass]) in set [String] format for classes being taken from realm
        let setStrings = Set(stringClasses)
        
        
        // maybe not the best way to use 'type' in this scenario to sort them
        SharedAllClasses.shared.sharedAllClasses.forEach { units in
            let className = units.courseNum
            if setStrings.contains(className) {
                classes.append(units)
            } else if (units.isAccounting == true) && (type == "acc") {
                notTakingClasses.append(units)
            } else if (units.isBusiness == true) && (type == "bus") {
                notTakingClasses.append(units)
            } else if (units.isEthics == true) && (type == "eth") {
                notTakingClasses.append(units)
            }
        }
        return (classes, notTakingClasses)
    }
    
    /* To generate messages for paged scroll view, example messages first
        1. Good job! All the conditions are met.
        2. Need 5 more accounting units. Some community college accounting classes are exactly 5 units. Check them out.
        3. Can't double count (BUS 212, BUS 214, AGB 214).
        4. Can't double count BUS 215 and AGB 323
        5. Need more ethics units. Could take an ethics class for C elective if not taken yet.
        6. Need more total units. Look for some interesting free elective classes to take.
        7. Need more accounting units (not exactly 5), look into more accounting electives or community college classes.
        8. Need more business units. Look through your other classes that could count and add them to the class list.
        9. Hopefully the application has been helpful!
        10. Sum of community college subjects (cc accounting, cc business, cc ethics) is greater than total commmunity college units. Community college classes, like other classes, can only count for one subject maximum.
     
     use code/storyboard fro handtracker app, add another view for each message that applies, be able to scroll through the views with a page counter at the top, arrow on the first view to signify that they can be scrolled, something on the lsat view to show that it is at the end
     
     potentially use another type to help be able to sort and keep organized
    */
}


extension StatusVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classesForTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = classesForTable[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "statusCell") as! StatusCell
        cell.statusCellUI(object: object)
        return cell
    }
}
