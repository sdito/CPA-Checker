//
//  StatusPopUpVC.swift
//  cpaChecker
//
//  Created by Steven Dito on 7/29/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit
import RealmSwift



class StatusPopUpVC: UIViewController {
    
    @IBOutlet weak var accountingHave: UILabel!
    @IBOutlet weak var businessHave: UILabel!
    @IBOutlet weak var ethicsHave: UILabel!
    @IBOutlet weak var totalHave: UILabel!
    
    @IBOutlet weak var accountingNeeded: UILabel!
    @IBOutlet weak var businessNeeded: UILabel!
    @IBOutlet weak var ethicsNeeded: UILabel!
    @IBOutlet weak var totalNeeded: UILabel!
    
    var realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUI(result: Result.calculateResult(units: Array(realm.objects(RealmUnits.self)), key: UserDefaults.standard.value(forKey: "units") as! String, realmClasses: Array(realm.objects(RealmClass.self))))
    }
    
    func setUI(result: Result) {
        accountingHave.text = "\(result.accountingUnits)"
        businessHave.text = "\(result.businessUnits)"
        ethicsHave.text = "\(result.ethicsUnits)"
        totalHave.text = "\(result.totalUnits)"
        
        accountingNeeded.text = "\(SharedUnits.shared.units["totalAccounting"] ?? 0)"
        businessNeeded.text = "\(SharedUnits.shared.units["totalBusiness"] ?? 0)"
        ethicsNeeded.text = "\(SharedUnits.shared.units["totalEthics"] ?? 0)"
        totalNeeded.text = "\(SharedUnits.shared.units["totalUnits"] ?? 0)"
    }

    struct popUp {
        static let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "statusPopID") as! StatusPopUpVC
        
    }
}
