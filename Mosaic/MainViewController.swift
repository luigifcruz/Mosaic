//
//  MainViewController.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/21/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import UIKit
import Charts

class MainViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var MasterView: UIView!
    @IBOutlet weak var WeatherLabel: UILabel!
    @IBOutlet weak var CalendarLabel: UILabel!
    @IBOutlet weak var PointsView: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let today = delegate.realm.objects(DayResume).last!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        PointsView.layer.cornerRadius = 5
        PointsView.clipsToBounds = true
        CalendarLabel.layer.cornerRadius = 5
        CalendarLabel.clipsToBounds = true
        WeatherLabel.layer.cornerRadius = 5
        WeatherLabel.clipsToBounds = true
        MasterView.layer.cornerRadius = 15
        MasterView.clipsToBounds = true
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return today.cardsOfTheDay.count
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if today.cardsOfTheDay[section].enabled {
            return today.cardsOfTheDay[section].bubbles.count + 1
        } else {
            return 2
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            return CGSize(width: 400, height: 48)
        } else {
            if today.cardsOfTheDay[indexPath.section].enabled {
                let cell = today.cardsOfTheDay[indexPath.section].bubbles[indexPath.row - 1]
                return CGSize(width: cell.width, height: cell.height)
            } else {
                return CGSize(width: 400, height: 74)
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("main", forIndexPath: indexPath) as! MainCollectionViewCell
            
            cell.name.text = today.cardsOfTheDay[indexPath.section].name
            cell.shareBubble.layer.cornerRadius = cell.bubble.frame.height / 2
            cell.name.layer.cornerRadius = 8
            cell.name.clipsToBounds = true
            cell.bubble.layer.cornerRadius = cell.bubble.frame.height / 2
            cell.bubble.layer.backgroundColor = UIColor(red:0.00, green:0.67, blue:0.93, alpha:1.0).CGColor
            
            return cell
        } else {
            if today.cardsOfTheDay[indexPath.section].enabled {
                let cellData = today.cardsOfTheDay[indexPath.section].bubbles[indexPath.row - 1]
                
                switch cellData.type {
                case "extension":
                    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("extension", forIndexPath: indexPath) as! ExtensionCollectionViewCell
                    
                    cell.name.text = cellData.label
                    
                    let swipeGesture = UILongPressGestureRecognizer(target: self, action: #selector(MainViewController.didPress(_:)))
                    swipeGesture.delegate = self
                    cell.bubble.addGestureRecognizer(swipeGesture)
                    
                    cell.bubble.layer.cornerRadius = cell.bubble.frame.height / 2
                    cell.bubble.layer.backgroundColor = UIColor(red:0.00, green:0.67, blue:0.93, alpha:1.0).CGColor
                    cell.name.textColor = UIColor(red:0.00, green:0.67, blue:0.93, alpha:1.0)
                    
                    return cell
                case "extensionLarge":
                    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("extensionLarge", forIndexPath: indexPath) as! ExtensionCollectionViewCell
                    
                    cell.name.text = cellData.label
                    
                    cell.bubble.layer.cornerRadius = cell.bubble.frame.height / 2
                    cell.bubble.layer.backgroundColor = UIColor(red:0.98, green:0.47, blue:0.24, alpha:1.0).CGColor
                    cell.name.textColor = UIColor(red:0.98, green:0.47, blue:0.24, alpha:1.0)
                    
                    return cell
                default:
                    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("extensionLarge", forIndexPath: indexPath) as! ExtensionCollectionViewCell
                    return cell
                }
            } else {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("allow", forIndexPath: indexPath) as! AllowCollectionViewCell
                return cell
            }
        }
    }
    
    let informationView = BlurViewController(nibName: "BlurViewController", bundle: nil)
    
    func didPress(recognizer: UIGestureRecognizer){
        //let location = recognizer.locationInView(collectionView)
        
        switch recognizer.state {
        case .Began:
            //let indexPath = collectionView.indexPathForItemAtPoint(location)
            //let bubble = collectionView.cellForItemAtIndexPath(indexPath!) as! ExtensionCollectionViewCell
            
            informationView.view.alpha = 0
            if let window: UIWindow = UIApplication.sharedApplication().keyWindow {
                
                window.addSubview(informationView.view)
                informationView.didMoveToParentViewController(self)
                
                informationView.view.frame.size.width = view.frame.size.width
                informationView.view.frame.size.height = view.frame.size.height
                
                UIView.animateWithDuration(0.2, animations: {
                    self.informationView.view.alpha = 1
                })
            }
            break;
        case .Ended:
            UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: CGFloat(0.2), initialSpringVelocity: CGFloat(1), options: .AllowUserInteraction, animations: {
                self.informationView.view.alpha = 0
                self.setNeedsStatusBarAppearanceUpdate()
                }, completion: { Void in()
                    self.informationView.view.removeFromSuperview()
            })
            break;
        default: break
        }
    }
}
