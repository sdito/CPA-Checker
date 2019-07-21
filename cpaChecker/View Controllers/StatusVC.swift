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
    
    @IBOutlet weak var neededAccountingLabel: UILabel!
    @IBOutlet weak var neededBusinessLabel: UILabel!
    @IBOutlet weak var neededEthicsLabel: UILabel!
    @IBOutlet weak var totalNeededLabel: UILabel!
    
    
    private var accounting = true
    private var business = false
    private var ethics = false
    private var taking = true
    private var available = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = true
        //forGradient.setGradientBackground(colorOne: Colors.lightLightGray, colorTwo: Colors.lightGray)
        statusScrollView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //addNewClassIfStraightToStatus()
        
        
        result = Result.calculateResult(units: Array(realm.objects(RealmUnits.self)), key: UserDefaults.standard.value(forKey: "units") as! String, realmClasses: Array(realm.objects(RealmClass.self)))
        //result = calculateStatus()
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

            }
        }
        let accurrateMessages = result!.getMessages()
        
        for item in accurrateMessages {
            let view = Bundle.main.loadNibNamed("StatusView", owner: nil, options: nil)?.first as? StatusView
            view?.setUI(message: item)
            stackView.insertArrangedSubview(view!, at: 0)
            let pageView = UIView()
            pageView.backgroundColor = .white
            pageStackView.insertArrangedSubview(pageView, at: 0)
            
            //to add an arrow (or technically remove the arrow) to only have arrow on first view, confusing since in reverse order
            if item != accurrateMessages.last {
                view?.arrow.isHidden = true
            }
        }
        
        haveCorrectPageViewAppears()
        
        
        // to set the message scroll view to the left most page and setting the correct page tracker to the gray color for every time the view appears
        statusScrollView.setContentOffset(CGPoint(x: 1, y: 1), animated: false)
        for item in pageStackView.arrangedSubviews {
            if item == pageStackView.arrangedSubviews.first! {
                item.backgroundColor = Colors.main
            } else {
                item.backgroundColor = .white
            }
        }
        classesForTable = result!.selectedClasses(acc: accounting, bus: business, eth: ethics, taking: taking, available: available)
        tableView.reloadData()
        neededAccountingLabel.text = "\(SharedUnits.shared.units["totalAccounting"]!)"
        neededBusinessLabel.text = "\(SharedUnits.shared.units["totalBusiness"]!)"
        neededEthicsLabel.text = "\(SharedUnits.shared.units["totalEthics"]!)"
        totalNeededLabel.text = "\(SharedUnits.shared.units["totalUnits"]!)"
    }
    @IBAction func helpPressed(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "helpVC") as! HelpVC
        self.present(vc, animated: false, completion: nil)
    }
    
    
    @IBAction func accountingPressed(_ sender: Any) {
        accounting = true
        business = false
        ethics = false
        updateTableStuff()
    }
    @IBAction func businessPressed(_ sender: Any) {
        accounting = false
        business = true
        ethics = false
        updateTableStuff()
    }
    @IBAction func ethicsPressed(_ sender: Any) {
        accounting = false
        business = false
        ethics = true
        updateTableStuff()
    }
    @IBAction func totalPressed(_ sender: Any) {
        accounting = true
        business = true
        ethics = true
        updateTableStuff()
        
    }
    @IBAction func showTaking(_ sender: Any) {
        taking = true
        available = false
        updateTableStuff()
    }
    @IBAction func showAvailable(_ sender: Any) {
        taking = false
        available = true
        updateTableStuff()
    }

    
    func updateTableStuff() {
        classesForTable = result!.selectedClasses(acc: accounting, bus: business, eth: ethics, taking: taking, available: available)
        if classesForTable.isEmpty == true {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            
        }
        var classType: String?
        var takeAvailable: String?
        if accounting == true && business == true && ethics == true {
            classType = "All"
        }
        else if accounting == true {
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
        let sorted = classesForTable.sortClasses()
        let object = sorted[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "statusCell") as! StatusCell
        cell.statusCellUI(object: object)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)!.isHighlighted = true
        tableView.reloadData()
    }
}


extension StatusVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var counter = 0
        if scrollView == statusScrollView {
            for view in stackView.subviews {
                if isVisible(view: view) == true {
                    pageStackView.subviews[counter].backgroundColor = Colors.main
                } else {
                    pageStackView.subviews[counter].backgroundColor = .white
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
    //not being used anywhere currently
    func addNewClassIfStraightToStatus() {
        for item in realm.objects(RealmNewClass.self) {
            let newClass = Class(courseNum: item.courseNum.uppercased(), title: "User added class", description: nil, isAccounting: item.isAccounting, isBusiness: item.isBusiness, isEthics: item.isEthics, numUnits: item.numUnits, offeredFall: nil, offeredWinter: nil, offeredSpring: nil, offeredSummer: nil, mustBeEthics: item.mustBeEthics, collegeID: nil, semesterOrQuarter: item.semesterOrQuarter)
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
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //to hide and subsequently remove the arrow on the first subview when the user first scrolls after VC appears
        if scrollView == statusScrollView {
          stackView.arrangedSubviews.first?.subviews.forEach {subview in
            if type(of: subview) == UIImageView.self {
                UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {subview.alpha = 0}, completion: {done in subview.removeFromSuperview()})
                }
            }
        }
    }
}


