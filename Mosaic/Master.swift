//
//  DataGather.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/25/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import RealmSwift
import Foundation

class TrackerMaster {
    
    class func initiate() {
        print("Initialization required.")
    
        do {
            try delegate.realm.write({
                let general = GeneralConfig()
                delegate.realm.add(general)
                
                // Padding Cards
                
                let PaddingMedium = Bubble()
                
                PaddingMedium.label = "PADDING_MEDIUM"
                PaddingMedium.number = 0
                PaddingMedium.type = "paddingMedium"
                PaddingMedium.height = CGFloat(40)
                PaddingMedium.width = CGFloat(400)
                
                // Twitter Card Delegate
                let TwitterCard = Card()
                TwitterCard.name = "Twitter"
                TwitterCard.enabled = false
                TwitterCard.color = "#00aced"
                
                let TwitterTweetBubble = Bubble()
                
                TwitterTweetBubble.label = "TWEETS"
                TwitterTweetBubble.number = 0
                TwitterTweetBubble.type = "extension"
                TwitterTweetBubble.height = CGFloat(95)
                TwitterTweetBubble.width = CGFloat(95)
                
                let TwitterRepliesBubble = Bubble()
                
                TwitterRepliesBubble.label = "REPLIES"
                TwitterRepliesBubble.number = 0
                TwitterRepliesBubble.type = "extension"
                TwitterRepliesBubble.height = CGFloat(95)
                TwitterRepliesBubble.width = CGFloat(95)
                
                let TwitterFollowersBubble = Bubble()
                
                TwitterFollowersBubble.label = "FOLLOWERS"
                TwitterFollowersBubble.number = 0
                TwitterFollowersBubble.type = "extensionLarge"
                TwitterFollowersBubble.height = CGFloat(95)
                TwitterFollowersBubble.width = CGFloat(200)
                
                TwitterCard.bubbles.appendContentsOf([TwitterTweetBubble, TwitterFollowersBubble, TwitterRepliesBubble, PaddingMedium])
                
                // Health Card Delegate
                let HealthCard = Card()
                HealthCard.name = "Health"
                HealthCard.enabled = false
                HealthCard.color = "#FB894B"
                
                let HealthWalkingBubble = Bubble()
                
                HealthWalkingBubble.label = "DISTANCE"
                HealthWalkingBubble.number = 0
                HealthWalkingBubble.type = "extensionMedium"
                HealthWalkingBubble.height = CGFloat(95)
                HealthWalkingBubble.width = CGFloat(143)
                
                let HealthStepsBubble = Bubble()
                
                HealthStepsBubble.label = "STEPS"
                HealthStepsBubble.number = 0
                HealthStepsBubble.type = "extensionMedium"
                HealthStepsBubble.height = CGFloat(95)
                HealthStepsBubble.width = CGFloat(143)
                
                let HealthFlightsBubble = Bubble()
                
                HealthFlightsBubble.label = "FLIGHTS"
                HealthFlightsBubble.number = 0
                HealthFlightsBubble.type = "extension"
                HealthFlightsBubble.height = CGFloat(95)
                HealthFlightsBubble.width = CGFloat(95)
                
                HealthCard.bubbles.appendContentsOf([HealthWalkingBubble, HealthStepsBubble, HealthFlightsBubble])
                
                // Photos Card Delegate
                let PhotosCard = Card()
                PhotosCard.name = "Photos"
                PhotosCard.enabled = false
                PhotosCard.color = "#505050"
                
                let PhotosMapBubble = Bubble()
                
                PhotosMapBubble.label = "MAP"
                PhotosMapBubble.number = 0
                PhotosMapBubble.type = "map"
                PhotosMapBubble.height = CGFloat(171)
                PhotosMapBubble.width = CGFloat(400)
                
                let PhotosLiveBubble = Bubble()
                
                PhotosLiveBubble.label = "LIVE"
                PhotosLiveBubble.number = 0
                PhotosLiveBubble.type = "extension"
                PhotosLiveBubble.height = CGFloat(95)
                PhotosLiveBubble.width = CGFloat(95)
                
                let PhotosTotalBubble = Bubble()
                
                PhotosTotalBubble.label = "PHOTOS"
                PhotosTotalBubble.number = 0
                PhotosTotalBubble.type = "extension"
                PhotosTotalBubble.height = CGFloat(95)
                PhotosTotalBubble.width = CGFloat(95)
                
                let PhotosVideosBubble = Bubble()
                
                PhotosVideosBubble.label = "VIDEOS"
                PhotosVideosBubble.number = 0
                PhotosVideosBubble.type = "extension"
                PhotosVideosBubble.height = CGFloat(95)
                PhotosVideosBubble.width = CGFloat(95)
                
                let PhotosColorBubble = Bubble()
                
                PhotosColorBubble.label = "COLOR"
                PhotosColorBubble.number = 0
                PhotosColorBubble.type = "extension"
                PhotosColorBubble.height = CGFloat(95)
                PhotosColorBubble.width = CGFloat(95)
                
                
                PhotosCard.bubbles.appendContentsOf([PhotosMapBubble, PhotosLiveBubble, PhotosTotalBubble, PhotosVideosBubble, PhotosColorBubble])
                
                general.cardStatus.appendContentsOf([PhotosCard, HealthCard, TwitterCard])
            })
        } catch {
            print("Failed to creat general obeject.")
        }
    }

    class func newDay(completion: () -> Void) {
        print("Request for new day.")
        let newDay = DayResume()
        
        newDay.day = String(NSDate())
        newDay.date = NSDate()
        newDay.points = 0
        newDay.updated = NSDate()
        
        newDay.cardsOfTheDay = delegate.realm.objects(GeneralConfig).last!.cardStatus
        
        do {
            try delegate.realm.write({
                delegate.realm.add(newDay)
                completion()
            })
        } catch {
            print("Failed to add new day.")
        }
    }
    
    class func updateData(day: NSDate, service: String, completion: (result: Bool) -> Void) {
        print("Request to update \(day)")
        
        switch service {
        case "TWITTER":
            break;
        case "HEALTH":
            
            break;
        case "PHOTOS":
            break;
        default:
            break;
        }
        // Health Core
    }
    
    class func updateCardStatus(name: String, date: NSDate, status: Bool) {
        let realm = try! Realm()
        
        let day = realm.objects(DayResume).last!
        let card = day.cardsOfTheDay.filter("name == %@", name).first!
        let masterCard = realm.objects(GeneralConfig).first!.cardStatus.filter("name == %@", name).first!
        
        do {
            try realm.write({
                card.enabled = status
                day.updated = NSDate()
                masterCard.enabled = status
            })
        } catch {
            print("Cannot save new status.")
        }
        delegate.main!.reloadCollection()
    }
    
    class func getWeather() {
        
    }
    
    class func rainbows() {
        let realm = try! Realm()
        
        print(realm.objects(DayResume))
        print(realm.objects(GeneralConfig))
    }
}

func getJSON(urlToRequest: String) -> NSData{
    return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
}

func parseJSON(inputData: NSData, completion: (result: NSDictionary) -> Void) {
    do {
        let boardsDictionary = try NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
        completion(result: boardsDictionary!)
    } catch {
        print("Failed to Catch JSON.")
    }
}

extension UIColor {
    convenience init(hexString: String) {
        var cString: String = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
        if (cString.characters.count != 6) {
            self.init(white: 0.5, alpha: 1.0)
        } else {
            let rString: String = (cString as NSString).substringToIndex(2)
            let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
            let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
            
            var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0;
            NSScanner(string: rString).scanHexInt(&r)
            NSScanner(string: gString).scanHexInt(&g)
            NSScanner(string: bString).scanHexInt(&b)
            
            self.init(red: CGFloat(r) / CGFloat(255.0), green: CGFloat(g) / CGFloat(255.0), blue: CGFloat(b) / CGFloat(255.0), alpha: CGFloat(1))
        }
    }
}