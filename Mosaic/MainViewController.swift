//
//  MainViewController.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/21/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import UIKit
import Charts

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var CalendarView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Twitter.getTweetCount(NSDate()) {
            (result) in
            print(result)
        }
    }

    override func viewDidLayoutSubviews() {
        CalendarView.layer.cornerRadius = 16
        CalendarView.clipsToBounds = true
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: 400, height: 48)
        } else if indexPath.row >= 1 && indexPath.row < 5 {
            return CGSize(width: 95, height: 95)
        } else if indexPath.row == 5 {
            return CGSize(width: 400, height: 48)
        } else {
            return CGSize(width: 200, height: 95)
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("main", forIndexPath: indexPath) as! MainCollectionViewCell
            
            cell.name.layer.cornerRadius = 8
            cell.name.clipsToBounds = true
            cell.bubble.layer.cornerRadius = cell.bubble.frame.height / 2
            cell.bubble.layer.backgroundColor = UIColor(red:0.00, green:0.67, blue:0.93, alpha:1.0).CGColor
            return cell
        } else if indexPath.row >= 1 && indexPath.row < 5 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("extension", forIndexPath: indexPath) as! ExtensionCollectionViewCell
            cell.bubble.layer.cornerRadius = cell.bubble.frame.height / 2
            cell.bubble.layer.backgroundColor = UIColor(red:0.00, green:0.67, blue:0.93, alpha:1.0).CGColor
            cell.name.textColor = UIColor(red:0.00, green:0.67, blue:0.93, alpha:1.0)
            return cell
        } else if indexPath.row == 5 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("main", forIndexPath: indexPath) as! MainCollectionViewCell
            
            cell.name.text = "Health"
            
            cell.name.layer.cornerRadius = 8
            cell.name.clipsToBounds = true
            cell.bubble.layer.cornerRadius = cell.bubble.frame.height / 2
            cell.bubble.layer.backgroundColor = UIColor(red:0.98, green:0.47, blue:0.24, alpha:1.0).CGColor
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("extensionLarge", forIndexPath: indexPath) as! ExtensionCollectionViewCell
            
            cell.bubble.layer.cornerRadius = cell.bubble.frame.height / 2
            cell.bubble.layer.backgroundColor = UIColor(red:0.98, green:0.47, blue:0.24, alpha:1.0).CGColor
            cell.name.textColor = UIColor(red:0.98, green:0.47, blue:0.24, alpha:1.0)
            return cell
        }
        
    }
}
