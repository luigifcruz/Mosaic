//
//  Twitter.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/21/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import Foundation


struct tweetScheme {
    var text = ""
    var date: NSDate?
    var retweets: Int?
    var likes: Int?
}

class Twitter {
    class func getPermission() {
        account.requestAccessToAccountsWithType(accountType, options: nil, completion: {(success: Bool, error: NSError!) -> Void in
            TrackerMaster.updateCardStatus("Twitter", date: NSDate(), status: success)
        })
    }
    /*
    class func getUserID(completion: (result: String) -> Void) {
        delegate.swifter!.getAccountVerifyCredentials(success: { user in
            if let userID = user!["id_str"]!.string {
                completion(result: userID)
            }
        })
    }
    
    class func getParameterInteger(tweets: [JSONValue], parameter: String, completion: (result: Int) -> Void) {
        var count = 0
        for tweet in tweets {
            if let dateString = tweet["created_at"].string {
                if let parameterInteger = tweet[parameter].integer {
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "eee MMM dd HH:mm:ss ZZZZ yyyy"
                    let tweetDay = dateFormatter.dateFromString(dateString)
                    
                    if isSameDays(tweetDay!, NSDate()) {
                        count += parameterInteger
                    }
                }
            }
        }
        completion(result: count)
    }
    
    class func getCountOfParameter(tweets: [JSONValue], parameter: String, completion: (result: Int) -> Void) {
        var count = 0
        for tweet in tweets {
            if let dateString = tweet["created_at"].string {
                if tweet[parameter].string != nil {
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "eee MMM dd HH:mm:ss ZZZZ yyyy"
                    let tweetDay = dateFormatter.dateFromString(dateString)
                    
                    if isSameDays(tweetDay!, NSDate()) {
                        count += 1
                    }
                }
            }
        }
        completion(result: count)
    }
    
    class func getTweets(UserID: String, completion: (result: Int) -> Void) {
        delegate.swifter!.getStatusesUserTimelineWithUserID(UserID, count: 100, success: { tweets in
            getCountOfParameter(tweets!, parameter: "id_str", completion: { (result) in
                completion(result: result)
            })
        })
    }
    
    class func getRetweets(UserID: String, completion: (result: Int) -> Void) {
        delegate.swifter!.getStatusesRetweetsOfMeWithCount(100, success: { tweets in
            getParameterInteger(tweets!, parameter: "retweet_count", completion: { (result) in
                completion(result: result)
            })
        })
    }
    
    class func getMentions(UserID: String, completion: (result: Int) -> Void) {
        delegate.swifter!.getStatusesMentionTimelineWithCount(100, success: { tweets in
            getCountOfParameter(tweets!, parameter: "id_str", completion: { (result) in
                completion(result: result)
            })
        }, failure: nil)
    }*/
}