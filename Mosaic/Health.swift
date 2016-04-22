//
//  health.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/21/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import Foundation
import HealthKit

let healthKitStore:HKHealthStore = HKHealthStore()

class Health {
    class func getPermission() {
        let healthKitTypesToRead = Set(arrayLiteral:
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierStepCount)!,
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierFlightsClimbed)!,
            HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierDistanceWalkingRunning)!,
            HKObjectType.workoutType()
        )
        
        let newCompletion: ((Bool, NSError?) -> Void) = {
            (success, error) -> Void in
            
            if !success {
                print("You didn't allow HealthKit to access these write data types.\nThe error was:\n \(error!.description).")
                
                return
            }
        }
        
        healthKitStore.requestAuthorizationToShareTypes(nil, readTypes: healthKitTypesToRead, completion: newCompletion)
    }
    
    class func getStepCount(completion: (result: Int) -> Void) {
        let stepsCount = HKQuantityType.quantityTypeForIdentifier(
            HKQuantityTypeIdentifierStepCount)
        let stepSort = [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]
        
        
        let step = HKSampleQuery(sampleType: stepsCount!, predicate: nil, limit: 1000, sortDescriptors: stepSort) { (query, results, err) in
            var numberOfSteps = 0.0

            for result in results! as! [HKQuantitySample] {
                if isSameDays(NSDate(), result.startDate) {
                    numberOfSteps += result.quantity.doubleValueForUnit(HKUnit.countUnit())
                }
            }
            
            completion(result: Int(numberOfSteps))
        }
        
        healthKitStore.executeQuery(step)
    }
    
    class func getWalkingDistance(completion: (result: Int) -> Void) {
        let walkingDistance = HKQuantityType.quantityTypeForIdentifier(
            HKQuantityTypeIdentifierDistanceWalkingRunning)
        let walkingSort = [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]
        
        
        let step = HKSampleQuery(sampleType: walkingDistance!, predicate: nil, limit: 1000, sortDescriptors: walkingSort) { (query, results, err) in
            var walkingDistance = 0.0
            
            for result in results! as! [HKQuantitySample] {
                if isSameDays(NSDate(), result.startDate) {
                    walkingDistance += result.quantity.doubleValueForUnit(HKUnit.meterUnit())
                }
            }
            
            completion(result: Int(walkingDistance))
        }
        
        healthKitStore.executeQuery(step)
    }
    
    class func getFlightsClimbed(completion: (result: Int) -> Void) {
        let flightsCount = HKQuantityType.quantityTypeForIdentifier(
            HKQuantityTypeIdentifierFlightsClimbed)
        let flightsSort = [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]
        
        
        let step = HKSampleQuery(sampleType: flightsCount!, predicate: nil, limit: 1000, sortDescriptors: flightsSort) { (query, results, err) in
            var flightsCount = 0.0
            
            for result in results! as! [HKQuantitySample] {
                if isSameDays(NSDate(), result.startDate) {
                    flightsCount += result.quantity.doubleValueForUnit(HKUnit.countUnit())
                }
            }
            
            completion(result: Int(flightsCount))
        }
        
        healthKitStore.executeQuery(step)
    }
}

func isSameDays(date1:NSDate, _ date2:NSDate) -> Bool {
    let calendar = NSCalendar.currentCalendar()
    let comps1 = calendar.components([NSCalendarUnit.Month , NSCalendarUnit.Year , NSCalendarUnit.Day], fromDate:date1)
    let comps2 = calendar.components([NSCalendarUnit.Month , NSCalendarUnit.Year , NSCalendarUnit.Day], fromDate:date2)
    
    return (comps1.day == comps2.day) && (comps1.month == comps2.month) && (comps1.year == comps2.year)
}