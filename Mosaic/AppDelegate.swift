//
//  AppDelegate.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/19/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import UIKit
import CoreLocation
import SwifteriOS
import Accounts
import RealmSwift

let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
let account = ACAccountStore()
let accountType = account.accountTypeWithAccountTypeIdentifier(
    ACAccountTypeIdentifierTwitter)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let realm = try! Realm()
    var window: UIWindow?
    var swifter: Swifter?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let days = realm.objects(DayResume)
        
        let arrayOfAccounts = account.accountsWithAccountType(accountType)
        
        if arrayOfAccounts.count > 0 {
            let twitterAccount = arrayOfAccounts.last as! ACAccount
            swifter = Swifter(account: twitterAccount)
        }

        if days.count > 0 {
            if isSameDays((days.last!.date)!, NSDate()){
                TrackerMaster.updateData()
            } else {
                TrackerMaster.newDay() {
                    TrackerMaster.updateData()
                }
            }
        } else {
            TrackerMaster.initiate() {
                TrackerMaster.newDay() {
                    TrackerMaster.updateData()
                }
            }
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

