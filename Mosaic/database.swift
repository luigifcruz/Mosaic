//
//  database.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/25/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import RealmSwift

class GeneralConfig: Object {
    var cardStatus = List<Card>()
}

class Bubble: Object {
    dynamic var label = ""
    dynamic var number: Float = 0.0
    dynamic var height = CGFloat()
    dynamic var width = CGFloat()
    dynamic var type = ""
}

class Card: Object {
    dynamic var name = ""
    dynamic var enabled = false
    dynamic var color = ""
    
    var bubbles = List<Bubble>()
}

class DayResume: Object {
    dynamic var day: String?
    dynamic var date: NSDate?
    dynamic var updated: NSDate?
    dynamic var points = Double()
    
    var cardsOfTheDay = List<Card>()
    
    override class func primaryKey() -> String {
        return "day"
    }
}