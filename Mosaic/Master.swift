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
                
                let TwitterRepliesBubble = Bubble()
                
                TwitterRepliesBubble.label = "REPLIES"
                TwitterRepliesBubble.number = 0
                
                TwitterRepliesBubble.pointWeight = 0.2
                
                TwitterRepliesBubble.infoTitle = "Reply Number"
                TwitterRepliesBubble.infoDescription = "Counts how many replies you received today."
                
                TwitterRepliesBubble.type = "extension"
                TwitterRepliesBubble.height = CGFloat(95)
                TwitterRepliesBubble.width = CGFloat(95)
                
                let TwitterFollowersBubble = Bubble()
                
                TwitterFollowersBubble.label = "FOLLOWERS"
                TwitterFollowersBubble.number = 0
                
                TwitterFollowersBubble.pointWeight = 1
                
                TwitterFollowersBubble.infoTitle = "New Followers Number"
                TwitterFollowersBubble.infoDescription = "Counts how many new followers you have today."
                
                TwitterFollowersBubble.type = "extensionLarge"
                TwitterFollowersBubble.height = CGFloat(95)
                TwitterFollowersBubble.width = CGFloat(200)
                
                let TwitterPadding1Bubble = Bubble()
                
                TwitterPadding1Bubble.label = "PADDING"
                TwitterPadding1Bubble.number = 0
                TwitterPadding1Bubble.type = "paddingMedium"
                TwitterPadding1Bubble.height = CGFloat(20)
                TwitterPadding1Bubble.width = CGFloat(400)
                
                TwitterCard.bubbles.appendContentsOf([TwitterTweetBubble, TwitterFollowersBubble, TwitterRepliesBubble, TwitterPadding1Bubble])
                
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
                
                PhotosVideosBubble.pointWeight = 5
                
                PhotosVideosBubble.infoTitle = "Video Count"
                PhotosVideosBubble.infoDescription = "Counts how many videos you took today."
                
                PhotosVideosBubble.type = "extension"
                PhotosVideosBubble.height = CGFloat(95)
                PhotosVideosBubble.width = CGFloat(95)
                
                let PhotosColorBubble = Bubble()
                
                PhotosColorBubble.label = "COLOR"
                PhotosColorBubble.number = 0
                
                PhotosColorBubble.infoTitle = "Video Count"
                PhotosColorBubble.infoDescription = "Counts how many tweets you sent today."
                
                PhotosColorBubble.type = "extension"
                PhotosColorBubble.height = CGFloat(95)
                PhotosColorBubble.width = CGFloat(95)
                
                let PhotosPadding1Bubble = Bubble()
                
                PhotosPadding1Bubble.label = "PADDING"
                PhotosPadding1Bubble.number = 0
                PhotosPadding1Bubble.type = "paddingMedium"
                PhotosPadding1Bubble.height = CGFloat(15)
                PhotosPadding1Bubble.width = CGFloat(400)
                
                PhotosCard.bubbles.appendContentsOf([PhotosMapBubble, PhotosTotalBubble, PhotosLiveBubble, PhotosVideosBubble, PhotosColorBubble, PhotosPadding1Bubble])
                
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
                        break;
                    case "Health":
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
                        break;
                    case "Photos":
                        Photos.getLivePhotosCount(NSDate()) {
                            (result) in
                            saveOnCard(card, result: result, term: "LIVE")
                        }
                        Photos.getMediaCount(NSDate(), media: .Image) {
                            (result) in
                            saveOnCard(card, result: result, term: "PHOTOS")
                        }
                        Photos.getMediaCount(NSDate(), media: .Video) {
                            (result) in
                            saveOnCard(card, result: result, term: "VIDEOS")
                        }
                        break;
                    default:
                        break;
                    }
                }
            }
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
            NSNotificationCenter.defaultCenter().postNotificationName("ReloadBubbles", object: false)
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