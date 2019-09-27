//
//  AppDelegate.swift
//  cpaChecker
//
//  Created by Steven Dito on 5/28/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import UIKit
import SQLite

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //print(UserDefaults.standard.string(forKey: "college") as Any)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        if UserDefaults.standard.string(forKey: "college") != nil {
            let vc: UITabBarController = storyboard.instantiateViewController(withIdentifier: "tab") as! UITabBarController
            vc.modalPresentationStyle = .fullScreen
            let path = Bundle.main.path(forResource: "cpa", ofType: "db")!
            var schoolIdentifier: [String:Int] = [:]
            let db = try? Connection(path, readonly: true)
            for s in try! db!.prepare(
                """
            SELECT name, collegeID FROM colleges
            order by name
            """
                ) {
                    schoolIdentifier[s[0] as! String] = Int(s[1] as! Int64)
                    
            }
            let indii = UserDefaults.standard.string(forKey: "college")
            var ac: [Class] = []
            for c in try! db!.prepare("""
                SELECT courseNumber, title, description, isAccounting, isBusiness, isEthics, numberUnits, offeredFall, offeredWinter, offeredSpring, offeredSummer, mustBeEthics, cl.collegeID, isSemester FROM classes cl
                join colleges co
                on cl.collegeID = co.collegeID
                WHERE cl.collegeID in (\(indii ?? "0"))
                """)
            {
                var sq: String {
                    if c[13] as! Int64 == 1 {
                        return "semester"
                    } else {
                        return "quarter"
                    }
                }
                
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
                    collegeID: Int(c[12] as! Int64),
                    semesterOrQuarter: sq)
                ac.append(add)
                
                
            }
            SharedAllClasses.shared.sharedAllClasses = ac
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            
            
        } else {
            let otherVC: WelcomeVC = storyboard.instantiateViewController(withIdentifier: "welcome") as! WelcomeVC
            otherVC.modalPresentationStyle = .fullScreen
            
            self.window?.rootViewController = otherVC
            self.window?.makeKeyAndVisible()
            
            
        }

        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        //to make sure the status pop up does not get stuck on the screen
        StatusPopUpVC.popUp.popOverVC.view.removeFromSuperview()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
