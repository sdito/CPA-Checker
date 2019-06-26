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
    
    @IBOutlet var wholeView: UIView!
    @IBOutlet weak var statusScrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var accountingUnitsNumber: UILabel!
    @IBOutlet weak var businessUnitsNumber: UILabel!
    @IBOutlet weak var ethicsUnitsNumber: UILabel!
    @IBOutlet weak var totalUnitsNumber: UILabel!
    @IBOutlet weak var combinationLabel: UILabel!
    @IBOutlet weak var forGradient: UIView!
    
    @IBOutlet weak var originalView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var pageStackView: UIStackView!
    
    
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
        statusScrollView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //addNewClassIfStraightToStatus()
        result = calculateStatus()
        accountingUnitsNumber.text = result?.accountingUnits.description
        businessUnitsNumber.text = result?.businessUnits.description
        ethicsUnitsNumber.text = result?.ethicsUnits.description
        totalUnitsNumber.text = result?.totalUnits.description
        //classesForTable = result!.accountingClasses
        tableView.reloadData()
        let numViews = stackView.subviews.count
        if numViews == 1 {
            //print("Do nothing")
        } else {
            for view in stackView.subviews {
                if view == originalView {
                    //nothing
                } else {
                    stackView.removeArrangedSubview(view)
                    view.removeFromSuperview()
                    //remove pageStackViews
                    if let anotherView = pageStackView.arrangedSubviews.first {
                        pageStackView.removeArrangedSubview(anotherView)
                        anotherView.removeFromSuperview()
                    }
                }
                //            for _ in 1...(numViews - 1) {
                //                let view = stackView.subviews[0]
                //                stackView.removeArrangedSubview(view)
            }
        }
        let accurrateMessages = decideWhatMessagesAndHandleDeletion(result: result!)
        
        for item in accurrateMessages {
            let view = Bundle.main.loadNibNamed("StatusView", owner: nil, options: nil)?.first as? StatusView
            view?.setUI(message: item)
            stackView.insertArrangedSubview(view!, at: 0)
            let pageView = UIView()
            pageView.backgroundColor = .black
            pageStackView.insertArrangedSubview(pageView, at: 0)
        }
        haveCorrectPageViewAppears()
        
        
        // to set the message scroll view to the left most page and setting the correct page tracker to the gray color for every time the view appears
        statusScrollView.setContentOffset(CGPoint(x: 1, y: 1), animated: false)
        for item in pageStackView.arrangedSubviews {
            if item == pageStackView.arrangedSubviews.first! {
                item.backgroundColor = .gray
            } else {
                item.backgroundColor = .black
            }
        }
        

        whatClassesForTable()
        tableView.reloadData()
    }
    
    
    @IBAction func accountingPressed(_ sender: Any) {
        accounting = true
        business = false
        ethics = false
        whatClassesForTable()
        if classesForTable.isEmpty == true {
            //tableView.isHidden = true
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
            //tableView.isHidden = true
        } else {
            tableView.isHidden = false
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            
        }
        setCombinationLabel()
    }
    @IBAction func ethicsPressed(_ sender: Any) {
        accounting = false
        business = false
        ethics = true
        whatClassesForTable()
        if classesForTable.isEmpty == true {
            //tableView.isHidden = true
        } else {
            tableView.isHidden = false
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            
        }
        setCombinationLabel()
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
            
        }
        setCombinationLabel()
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
        
        // add a bool value to support this for when multiple universities are in the application
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
        

        // need to get rid of duplicates i.e. a class is in not taking classes if it counts for multiple sections, so need to test to make sure the class is not in this set before adding it to the not taking list
        var allNumsTaking: Set<String> = []
        for item in realm.objects(RealmClass.self) {
            allNumsTaking.insert(item.courseNum)
        }
        
        
        SharedAllClasses.shared.sharedAllClasses.forEach { units in
            let className = units.courseNum
            if setStrings.contains(className) {
                classes.append(units)
            } else if (units.isAccounting == true) && (type == "acc") && (allNumsTaking.contains(units.courseNum) == false) {
                notTakingClasses.append(units)
            } else if (units.isBusiness == true) && (type == "bus") && (allNumsTaking.contains(units.courseNum) == false) {
                notTakingClasses.append(units)
            } else if (units.isEthics == true) && (type == "eth") && (allNumsTaking.contains(units.courseNum) == false) {
                notTakingClasses.append(units)
            }
        }
        return (classes, notTakingClasses)
    }
    
    // could show total count of negative messages to easily see status
    func decideWhatMessagesAndHandleDeletion(result: Result) -> [String] {
        // need to make this work eventually for a semester school too
        var messages: [String] = []
        
        let accountingNeeded = 45
        let businessNeeded = 57
        let ethicsNeeded = 15
        let totalNeeded = 225
        let accountingDifference = result.accountingUnits - accountingNeeded
        let businessDifference = result.businessUnits - businessNeeded
        let ethicsDifference = result.ethicsUnits - ethicsNeeded
        let totalDifference = result.totalUnits - totalNeeded
        
        var accS: String {
            if abs(accountingDifference) == 1 {
                return ""
            } else {
                return "s"
            }
        }
        var busS: String {
            if abs(businessDifference) == 1 {
                return ""
            } else {
                return "s"
            }
        }
        var ethS: String {
            if abs(ethicsDifference) == 1 {
                return ""
            } else {
                return "s"
            }
        }
        var totS: String {
            if abs(totalDifference) == 1 {
                return ""
            } else {
                return "s"
            }
        }
        
        
        if accountingDifference == -5 {
            messages.append("Need 5 more accounting units. Some community college accounting classes are exactly 5 units. Check them out.")
        } else if accountingDifference < 0 {
            messages.append("Need \(abs(accountingDifference)) more accounting unit\(accS), look into more accounting electives or community college classes.")
        }
        if businessDifference < 0 {
            messages.append("Need \(abs(businessDifference)) more business unit\(busS). Look through your other classes that could count and add them to the class list.")
        }
        if ethicsDifference < 0 {
            messages.append("Need \(abs(ethicsDifference)) more ethics unit\(ethS). Check for any free elective classes that could meet the ethics requirement.")
        }
        if totalDifference < 0 {
            messages.append("Need \(abs(totalDifference)) more total unit\(totS). Look for some interesting free elective classes to take.")
        }
        
        if messages.isEmpty == true {
            messages.append("Good job! All the conditions are met.")
        }
        
        return messages
    }

    
    func isVisible(view: UIView) -> Bool {
        //let screenRect = wholeView.bounds
        let scrollRect = statusScrollView.bounds
        let center = view.center
        if scrollRect.contains(center) {
            return true
        } else {
            return false
        }
    }
    
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


extension StatusVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var counter = 0
        if scrollView == statusScrollView {
            for view in stackView.subviews {
                if isVisible(view: view) == true {
                    pageStackView.subviews[counter].backgroundColor = .gray
                } else {
                    pageStackView.subviews[counter].backgroundColor = .black
                }
                counter += 1
            }
        }
    }
    func haveCorrectPageViewAppears() {
        // this isnt correctly being called when viewDidAppear is called, need to fix
        var counter = 0
        for view in stackView.subviews {
            if isVisible(view: view) == true {
                pageStackView.subviews[counter].backgroundColor = .gray
            } else {
                pageStackView.subviews[counter].backgroundColor = .black
            }
            counter += 1
        }
    }
    
    func addNewClassIfStraightToStatus() {
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
            }
        }
    }
}


