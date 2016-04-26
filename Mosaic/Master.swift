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
                
                // Twitter Card Delegate
                let TwitterCard = Card()
                TwitterCard.name = "Twitter"
                TwitterCard.enabled = false
                
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
                TwitterFollowersBubble.height = CGFloat(200)
                TwitterFollowersBubble.width = CGFloat(95)
                
                TwitterCard.bubbles.appendContentsOf([TwitterTweetBubble, TwitterRepliesBubble, TwitterFollowersBubble])
                
                // health Card Delegate
                let HealthCard = Card()
                HealthCard.name = "Health"
                HealthCard.enabled = false
                
                let HealthWalkingBubble = Bubble()
                
                HealthWalkingBubble.label = "DISTANCE"
                HealthWalkingBubble.number = 0
                HealthWalkingBubble.type = "extensionLarge"
                HealthWalkingBubble.height = CGFloat(200)
                HealthWalkingBubble.width = CGFloat(95)
                
                let HealthStepsBubble = Bubble()
                
                HealthStepsBubble.label = "STEPS"
                HealthStepsBubble.number = 0
                HealthStepsBubble.type = "extensionLarge"
                HealthStepsBubble.height = CGFloat(200)
                HealthStepsBubble.width = CGFloat(95)
                
                let HealthFlightsBubble = Bubble()
                
                HealthFlightsBubble.label = "FLIGHTS"
                HealthFlightsBubble.number = 0
                HealthFlightsBubble.type = "extension"
                HealthFlightsBubble.height = CGFloat(95)
                HealthFlightsBubble.width = CGFloat(95)
                
                HealthCard.bubbles.appendContentsOf([HealthWalkingBubble, HealthStepsBubble])
                
                // Photos Card Delegate
                let PhotosCard = Card()
                PhotosCard.name = "Photos"
                PhotosCard.enabled = false
                
                let PhotosLiveBubble = Bubble()
                
                PhotosLiveBubble.label = "LIVE PHOTOS"
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
                
                
                PhotosCard.bubbles.appendContentsOf([PhotosLiveBubble, PhotosTotalBubble, PhotosVideosBubble])
                
                
                general.cardStatus.appendContentsOf([TwitterCard, HealthCard, PhotosCard])
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
    
    class func updateDay(day: NSDate, completion: (result: Bool) -> Void) {
        print("Request to update \(day)")
    }
}