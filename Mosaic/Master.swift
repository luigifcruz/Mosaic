//
//  DataGather.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/25/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import RealmSwift
import MapKit
import CoreLocation
import Foundation

class TrackerMaster {
    
    class func initiate(completion: () -> Void) {
        print("Initialization required.")
    
        do {
            try delegate.realm.write({
                let general = GeneralConfig()
                delegate.realm.add(general)
                
                // Twitter Card Delegate
                let TwitterCard = Card()
                TwitterCard.name = "Twitter"
                TwitterCard.enabled = false
                TwitterCard.color = "#00aced"
                
                let TwitterTweetBubble = Bubble()
                
                TwitterTweetBubble.label = "TWEETS"
                TwitterTweetBubble.number = 0
                
                TwitterTweetBubble.pointWeight = 0.1
                
                TwitterTweetBubble.infoTitle = "Tweet Number"
                TwitterTweetBubble.infoDescription = "Counts how many tweets you sent today."
                
                TwitterTweetBubble.type = "extension"
                TwitterTweetBubble.height = CGFloat(95)
                TwitterTweetBubble.width = CGFloat(95)
                
                let TwitterMentionsBubble = Bubble()
                
                TwitterMentionsBubble.label = "MENTIONS"
                TwitterMentionsBubble.number = 0
                
                TwitterMentionsBubble.pointWeight = 0.2
                
                TwitterMentionsBubble.infoTitle = "Mentions Number"
                TwitterMentionsBubble.infoDescription = "Counts how many mentions you received today."
                
                TwitterMentionsBubble.type = "extension"
                TwitterMentionsBubble.height = CGFloat(95)
                TwitterMentionsBubble.width = CGFloat(95)
                
                let TwitterLikesBubble = Bubble()
                
                TwitterLikesBubble.label = "LIKES"
                TwitterLikesBubble.number = 0
                
                TwitterLikesBubble.pointWeight = 0.5
                
                TwitterLikesBubble.infoTitle = "Likes Number"
                TwitterLikesBubble.infoDescription = "Counts how many likes you received today."
                
                TwitterLikesBubble.type = "extension"
                TwitterLikesBubble.height = CGFloat(95)
                TwitterLikesBubble.width = CGFloat(95)
                
                let TwitterRetweetsBubble = Bubble()
                
                TwitterRetweetsBubble.label = "RETWEETS"
                TwitterRetweetsBubble.number = 0
                
                TwitterRetweetsBubble.pointWeight = 1
                
                TwitterRetweetsBubble.infoTitle = "Retweets Number"
                TwitterRetweetsBubble.infoDescription = "Counts how many retweets you received today."
                
                TwitterRetweetsBubble.type = "extension"
                TwitterRetweetsBubble.height = CGFloat(95)
                TwitterRetweetsBubble.width = CGFloat(95)
                
                let TwitterPadding1Bubble = Bubble()
                
                TwitterPadding1Bubble.label = "PADDING"
                TwitterPadding1Bubble.number = 0
                TwitterPadding1Bubble.type = "paddingMedium"
                TwitterPadding1Bubble.height = CGFloat(20)
                TwitterPadding1Bubble.width = CGFloat(400)
                
                TwitterCard.bubbles.appendContentsOf([TwitterTweetBubble, TwitterMentionsBubble, TwitterLikesBubble, TwitterRetweetsBubble, TwitterPadding1Bubble])
                
                // Health Card Delegate
                let HealthCard = Card()
                HealthCard.name = "Health"
                HealthCard.enabled = false
                HealthCard.color = "#FB894B"
                
                let HealthWalkingBubble = Bubble()
                
                HealthWalkingBubble.label = "DISTANCE"
                HealthWalkingBubble.number = 0
                
                HealthWalkingBubble.pointWeight = 0.01
                
                HealthWalkingBubble.infoTitle = "Running + Walking Distance"
                HealthWalkingBubble.infoDescription = "Your Walking + Running distance today. Data from Health app."
                
                HealthWalkingBubble.type = "extensionMedium"
                HealthWalkingBubble.height = CGFloat(95)
                HealthWalkingBubble.width = CGFloat(143)
                
                let HealthStepsBubble = Bubble()
                
                HealthStepsBubble.label = "STEPS"
                HealthStepsBubble.number = 0
                
                HealthStepsBubble.pointWeight = 0.002
                
                HealthStepsBubble.infoTitle = "Steps Number"
                HealthStepsBubble.infoDescription = "Counts how many steps you gave today. Data from Health app."
                
                HealthStepsBubble.type = "extensionMedium"
                HealthStepsBubble.height = CGFloat(95)
                HealthStepsBubble.width = CGFloat(143)
                
                let HealthFlightsBubble = Bubble()
                
                HealthFlightsBubble.label = "FLOORS"
                HealthFlightsBubble.number = 0
                
                HealthFlightsBubble.pointWeight = 0.5
                
                HealthFlightsBubble.infoTitle = "Floors Climbed"
                HealthFlightsBubble.infoDescription = "Counts how many floors you climbed today. Data from Health app."
                
                HealthFlightsBubble.type = "extension"
                HealthFlightsBubble.height = CGFloat(95)
                HealthFlightsBubble.width = CGFloat(95)
                
                let HealthPadding1Bubble = Bubble()
                
                HealthPadding1Bubble.label = "PADDING"
                HealthPadding1Bubble.number = 0
                HealthPadding1Bubble.type = "paddingMedium"
                HealthPadding1Bubble.height = CGFloat(15)
                HealthPadding1Bubble.width = CGFloat(400)
                
                HealthCard.bubbles.appendContentsOf([HealthWalkingBubble, HealthStepsBubble, HealthFlightsBubble, HealthPadding1Bubble])
                
                // Photos Card Delegate
                let PhotosCard = Card()
                PhotosCard.name = "Photos"
                PhotosCard.enabled = false
                PhotosCard.color = "#505050"
                
                let PhotosMapBubble = Bubble()
                
                PhotosMapBubble.label = "MAP"
                PhotosMapBubble.number = 0
                
                PhotosMapBubble.infoTitle = "a"
                PhotosMapBubble.infoDescription = "a"
                
                PhotosMapBubble.type = "map"
                PhotosMapBubble.height = CGFloat(171)
                PhotosMapBubble.width = CGFloat(400)
                
                let PhotosLiveBubble = Bubble()
                
                PhotosLiveBubble.label = "LIVE"
                PhotosLiveBubble.number = 0
                
                PhotosLiveBubble.pointWeight = 3
                
                PhotosLiveBubble.infoTitle = "Live Photos Count"
                PhotosLiveBubble.infoDescription = "Counts how many awesome Live Photos you took today."
                
                PhotosLiveBubble.type = "extension"
                PhotosLiveBubble.height = CGFloat(95)
                PhotosLiveBubble.width = CGFloat(95)
                
                let PhotosTotalBubble = Bubble()
                
                PhotosTotalBubble.label = "PHOTOS"
                PhotosTotalBubble.number = 0
                
                PhotosTotalBubble.pointWeight = 1
                
                PhotosTotalBubble.infoTitle = "Photos Count"
                PhotosTotalBubble.infoDescription = "Counts how many photos you took today. This includes screenshots."
                
                PhotosTotalBubble.type = "extension"
                PhotosTotalBubble.height = CGFloat(95)
                PhotosTotalBubble.width = CGFloat(95)
                
                let PhotosVideosBubble = Bubble()
                
                PhotosVideosBubble.label = "VIDEOS"
                PhotosVideosBubble.number = 0
                
                PhotosVideosBubble.pointWeight = 4
                
                PhotosVideosBubble.infoTitle = "Video Count"
                PhotosVideosBubble.infoDescription = "Counts how many videos you took today."
                
                PhotosVideosBubble.type = "extension"
                PhotosVideosBubble.height = CGFloat(95)
                PhotosVideosBubble.width = CGFloat(95)
                
                let PhotosSloMoBubble = Bubble()
                
                PhotosSloMoBubble.label = "SLOMO"
                PhotosSloMoBubble.number = 0
                
                PhotosSloMoBubble.pointWeight = 7
                
                PhotosSloMoBubble.infoTitle = "Slow Motion Videos"
                PhotosSloMoBubble.infoDescription = "Counts how many SloMo Videos you took today."
                
                PhotosSloMoBubble.type = "extension"
                PhotosSloMoBubble.height = CGFloat(95)
                PhotosSloMoBubble.width = CGFloat(95)
                
                let PhotosPadding1Bubble = Bubble()
                
                PhotosPadding1Bubble.label = "PADDING"
                PhotosPadding1Bubble.number = 0
                PhotosPadding1Bubble.type = "paddingMedium"
                PhotosPadding1Bubble.height = CGFloat(15)
                PhotosPadding1Bubble.width = CGFloat(400)
                
                PhotosCard.bubbles.appendContentsOf([PhotosMapBubble, PhotosTotalBubble, PhotosLiveBubble, PhotosVideosBubble, PhotosSloMoBubble, PhotosPadding1Bubble])
                
                general.cardStatus.appendContentsOf([PhotosCard, HealthCard, TwitterCard])
            })
            completion()
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
    
    class func updateData() {
        print("Request to update.")
        dispatch_async(dispatch_get_main_queue()) {
            delegate.realm.refresh()
            let dayCard = delegate.realm.objects(DayResume).last!.cardsOfTheDay
            
            for card in dayCard {
                if card.enabled {
                    switch card.name {
                    case "Twitter":
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), {
                            Twitter.getUserID() {
                                (result) in
                                Twitter.getTweets(result, completion: { (result) in
                                    saveOnCard(card, result: result, term: "TWEETS")
                                })
                                Twitter.getMentions(result, completion: { (result) in
                                    saveOnCard(card, result: result, term: "MENTIONS")
                                })
                                Twitter.getRetweets(result, completion: { (result) in
                                    saveOnCard(card, result: result, term: "RETWEETS")
                                })
                            }
                            
                        })
                        break;
                    case "Health":
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                            Health.getWalkingDistance() {
                                (result) in
                                saveOnCard(card, result: result, term: "DISTANCE")
                            }
                            Health.getStepCount() {
                                (result) in
                                saveOnCard(card, result: result, term: "STEPS")
                            }
                            Health.getFlightsClimbed() {
                                (result) in
                                saveOnCard(card, result: result, term: "FLOORS")
                            }
                        })
                        break;
                    case "Photos":
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                            Photos.getLivePhotosCount(NSDate()) {
                                (result) in
                                saveOnCard(card, result: result, term: "LIVE")
                            }
                            Photos.getSloMoCount(NSDate()) {
                                (result) in
                                saveOnCard(card, result: result, term: "SLOMO")
                            }
                            Photos.getMediaCount(NSDate(), media: .Image) {
                                (result) in
                                saveOnCard(card, result: result, term: "PHOTOS")
                            }
                            Photos.getMediaCount(NSDate(), media: .Video) {
                                (result) in
                                saveOnCard(card, result: result, term: "VIDEOS")
                            }
                        })
                        break;
                    default:
                        break;
                    }
                }
            }
            pontuation()
        }
    }
    
    class func pontuation() {
        dispatch_async(dispatch_get_main_queue()) {
            delegate.realm.refresh()
            let day = delegate.realm.objects(DayResume).last!
            
            var points: Double = 0.0
            for card in day.cardsOfTheDay {
                var cardPoint: Double = 0.0
                
                for bubble in card.bubbles {
                    cardPoint += Double(bubble.number) * Double(bubble.pointWeight)
                    points += Double(bubble.number) * Double(bubble.pointWeight)
                }
                
                do {
                    try delegate.realm.write({
                        card.points = cardPoint
                    })
                } catch {
                    print("Failed to save.")
                }
            }
            
            do {
                try delegate.realm.write({
                    day.points = points
                })
            } catch {
                print("Failed to save.")
            }
            NSNotificationCenter.defaultCenter().postNotificationName("ReloadBubbles", object: false)
        }
    }
    
    class func saveOnCard(card: Card, result: Int, term: String) {
        dispatch_async(dispatch_get_main_queue()) {
            do {
                try delegate.realm.write({
                    let bubbleNumber = card.bubbles.filter("label == %@", term).first!
                    bubbleNumber.number = Float(result)
                })
            } catch {
                print("Can't save.")
            }
            pontuation()
        }
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
        updateData()
        NSNotificationCenter.defaultCenter().postNotificationName("ReloadBubbles", object: false)
    }
    
    class func rainbows() {
        let realm = try! Realm()
        print(realm.objects(DayResume))
        print(realm.objects(GeneralConfig))
    }
}

func cardPoint(cards: List<Card>, name: String) -> String {
    return String(Int(cards.filter("name == %@", name).first!.points))
}

func getJSON(urlToRequest: String) -> NSData {
    if let url = NSURL(string: urlToRequest) {
        if let data = NSData(contentsOfURL: url) {
            return data
        }
    }

    return NSData()
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

func lighterColorForColor(color: UIColor) -> UIColor {
    
    var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
    
    if color.getRed(&r, green: &g, blue: &b, alpha: &a){
        return UIColor(red: min(r + 0.2, 1.0), green: min(g + 0.2, 1.0), blue: min(b + 0.2, 1.0), alpha: a)
    }
    
    return UIColor()
}

func darkerColorForColor(color: UIColor) -> UIColor {
    
    var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
    
    if color.getRed(&r, green: &g, blue: &b, alpha: &a){
        return UIColor(red: max(r - 0.2, 0.0), green: max(g - 0.2, 0.0), blue: max(b - 0.2, 0.0), alpha: a)
    }
    
    return UIColor()
}

public func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}