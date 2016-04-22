//
//  MainViewController.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/21/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import UIKit
import Charts

func darkerColorForColor(color: UIColor) -> UIColor {
    
    var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
    
    if color.getRed(&r, green: &g, blue: &b, alpha: &a){
        return UIColor(red: max(r - 0.2, 0.0), green: max(g - 0.2, 0.0), blue: max(b - 0.2, 0.0), alpha: a)
    }
    
    return UIColor()
}

func lighterColorForColor(color: UIColor) -> UIColor {
    
    var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
    
    if color.getRed(&r, green: &g, blue: &b, alpha: &a){
        return UIColor(red: min(r + 0.2, 1.0), green: min(g + 0.2, 1.0), blue: min(b + 0.2, 1.0), alpha: a)
    }
    
    return UIColor()
}

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var CalendarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        CalendarView.layer.cornerRadius = 16
        CalendarView.clipsToBounds = true
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.row < 1 {
            return CGSize(width: 400, height: 48)
        } else {
            return CGSize(width: 95, height: 95)
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.row < 1 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("main", forIndexPath: indexPath) as! MainCollectionViewCell
            
            cell.name.layer.cornerRadius = 8
            cell.name.clipsToBounds = true
            cell.bubble.layer.cornerRadius = cell.bubble.frame.height / 2
            cell.bubble.layer.backgroundColor = UIColor(red:0.00, green:0.67, blue:0.93, alpha:1.0).CGColor
            return cell
        } else {
            Health.getStepCount{
                (result: Int) in
                print("Step Count: \(result)")
            }
            
            Health.getWalkingDistance(){
                (result: Int) in
                print("Walking Distance: \(result)")
            }
            
            Health.getFlightsClimbed(){
                (result: Int) in
                print("Flights Climbed: \(result)")
            }

            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("extension", forIndexPath: indexPath) as! ExtensionCollectionViewCell
            cell.bubble.layer.cornerRadius = cell.bubble.frame.height / 2
            cell.bubble.layer.backgroundColor = UIColor(red:0.00, green:0.67, blue:0.93, alpha:1.0).CGColor
            cell.name.textColor = UIColor(red:0.00, green:0.67, blue:0.93, alpha:1.0)
            return cell
        }
        
    }
}
