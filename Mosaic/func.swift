//
//  func.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/21/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import Foundation


func isSameDays(date1:NSDate, _ date2:NSDate) -> Bool {
    let calendar = NSCalendar.currentCalendar()
    let comps1 = calendar.components([NSCalendarUnit.Month , NSCalendarUnit.Year , NSCalendarUnit.Day], fromDate:date1)
    let comps2 = calendar.components([NSCalendarUnit.Month , NSCalendarUnit.Year , NSCalendarUnit.Day], fromDate:date2)
    
    return (comps1.day == comps2.day) && (comps1.month == comps2.month) && (comps1.year == comps2.year)
}