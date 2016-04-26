//
//  Twitter.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/21/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import Foundation
import Social
import Accounts
import Twitter

let account = ACAccountStore()
let accountType = account.accountTypeWithAccountTypeIdentifier(
    ACAccountTypeIdentifierTwitter)

class Twitter {
    class func getPermission() {
        account.requestAccessToAccountsWithType(accountType, options: nil, completion: {(success: Bool, error: NSError!) -> Void in })
    }
    
    class func getTweetCount(date: NSDate, completion: (result: Int) -> Void) {
        
    }
}