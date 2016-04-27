//
//  MainViewController.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/21/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import UIKit
import Charts
import RealmSwift
import MapKit

class MainViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let realm = try! Realm()
    
    var today: Results<DayResume>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        today = delegate.realm.objects(DayResume)
        delegate.main = self
    }
    
    
    func reloadCollection() {
        dispatch_async(dispatch_get_main_queue()) {
            self.today = self.realm.objects(DayResume)
            self.collectionView.reloadData()
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return today.last!.cardsOfTheDay.count + 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if today.last!.cardsOfTheDay[section - 1].enabled {
                return today.last!.cardsOfTheDay[section - 1].bubbles.count + 1
            } else {
                return 2
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: 400, height: 195)
        } else {
            if indexPath.row == 0 {
                return CGSize(width: 400, height: 48)
            } else {
                if today.last!.cardsOfTheDay[indexPath.section - 1].enabled {
                    let cell = today.last!.cardsOfTheDay[indexPath.section - 1].bubbles[indexPath.row - 1]
                    return CGSize(width: cell.width, height: cell.height)
                } else {
                    return CGSize(width: 400, height: 74)
                }
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("main", forIndexPath: indexPath) as! MainCollectionViewCell
            
            cell.PointsView.layer.cornerRadius = 5
            cell.PointsView.clipsToBounds = true
            cell.CalendarLabel.layer.cornerRadius = 5
            cell.CalendarLabel.clipsToBounds = true
            cell.WeatherLabel.layer.cornerRadius = 5
            cell.WeatherLabel.clipsToBounds = true
            cell.MasterView.layer.cornerRadius = 15
            cell.MasterView.clipsToBounds = true
            
            let date = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Day , .Month, .Year], fromDate: date)
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MMM"
            
            cell.CalendarDay.text = String(components.day)
            cell.CalendarLabel.text = String(dateFormatter.stringFromDate(NSDate())).uppercaseString
            
            return cell
        } else {
            let cardData = today.last!.cardsOfTheDay[indexPath.section - 1]
            
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("header", forIndexPath: indexPath) as! HeaderCollectionViewCell
                
                cell.name.text = cardData.name
                cell.bubble.layer.backgroundColor = UIColor(hexString: cardData.color).CGColor
                
                cell.name.clipsToBounds = true
                cell.name.layer.cornerRadius = 8
                cell.bubble.layer.cornerRadius = cell.bubble.frame.height / 2
                cell.shareBubble.layer.cornerRadius = cell.bubble.frame.height / 2
                
                return cell
            } else {
                if today.last!.cardsOfTheDay[indexPath.section - 1].enabled {
                    let cellData = cardData.bubbles[indexPath.row - 1]
                    
                    switch cellData.type {
                    case "map":
                        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("map", forIndexPath: indexPath) as! MapCollectionViewCell
                        
                        cell.MapView.layer.cornerRadius = 15
                        cell.MapView.clipsToBounds = true
                        
                        return cell
                    case "extension":
                        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("extension", forIndexPath: indexPath) as! ExtensionCollectionViewCell
                        
                        let swipeGesture = UILongPressGestureRecognizer(target: self, action: #selector(MainViewController.didPress(_:)))
                        swipeGesture.delegate = self
                        cell.bubble.addGestureRecognizer(swipeGesture)
                        
                        cell.name.text = cellData.label
                        cell.bubble.layer.backgroundColor = UIColor(hexString: cardData.color).CGColor
                        cell.name.textColor = UIColor(hexString: cardData.color)
                        cell.bubble.layer.cornerRadius = cell.bubble.frame.height / 2
                        
                        return cell
                    case "extensionMedium":
                        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("extensionMedium", forIndexPath: indexPath) as! ExtensionCollectionViewCell
                        
                        cell.name.text = cellData.label
                        cell.name.textColor = UIColor(hexString: cardData.color)
                        cell.bubble.layer.backgroundColor = UIColor(hexString: cardData.color).CGColor
                        cell.bubble.layer.cornerRadius = cell.bubble.frame.height / 2
                        
                        return cell
                    case "extensionLarge":
                        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("extensionLarge", forIndexPath: indexPath) as! ExtensionCollectionViewCell
                        
                        cell.name.text = cellData.label
                        cell.name.textColor = UIColor(hexString: cardData.color)
                        cell.bubble.layer.backgroundColor = UIColor(hexString: cardData.color).CGColor
                        cell.bubble.layer.cornerRadius = cell.bubble.frame.height / 2
                        
                        return cell
                    default:
                        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("paddingMedium", forIndexPath: indexPath)
                        return cell
                    }
                } else {
                    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("allow", forIndexPath: indexPath) as! AllowCollectionViewCell
                    cell.button.layer.cornerRadius = cell.button.frame.height / 2
                    return cell
                }
            }
        }
    }
    
    @IBAction func activateCard(sender: AnyObject) {
        if let button = sender as? UIButton {
            if let superview = button.superview {
                if let cell = superview.superview as? AllowCollectionViewCell {
                    let indexPath = collectionView.indexPathForCell(cell)
                    
                    switch today.last!.cardsOfTheDay[(indexPath?.section)!].name {
                    case "Twitter":
                        Twitter.getPermission()
                        break;
                    case "Photos":
                        Photos.getPermission()
                        break;
                    case "Health":
                        Health.getPermission()
                        break;
                    default: break;
                    }
                }
            }
        }
    }
    
    @IBAction func shareSection(sender: AnyObject) {
        if let button = sender as? UIButton {
            if let superview = button.superview {
                if let cell = superview.superview as? HeaderCollectionViewCell {
                    let indexPath = collectionView.indexPathForCell(cell)
                    let cell = collectionView.cellForItemAtIndexPath(indexPath!)!
                    
                    UIGraphicsBeginImageContextWithOptions(cell.frame.size, false, 0);
                    cell.drawViewHierarchyInRect(cell.bounds, afterScreenUpdates: true)
                    let image = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                    
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                }
            }
        }
    }
    
    let informationView = BlurViewController(nibName: "BlurViewController", bundle: nil)
    var infoIsRogue = false
    var infoIsRogueIndexPath: NSIndexPath?
    
    func didPress(recognizer: UIGestureRecognizer){
        let location = recognizer.locationInView(collectionView)
        
        if recognizer.state == .Began || recognizer.state == .Changed {
            if !infoIsRogue {
                infoIsRogue = true
                infoIsRogueIndexPath = collectionView.indexPathForItemAtPoint(location)
                
                let cell = collectionView.cellForItemAtIndexPath(infoIsRogueIndexPath!) as! ExtensionCollectionViewCell
                let cellPositionScreen = cell.superview?.convertPoint(cell.frame.origin, toView: nil)
                
                informationView.view.alpha = 0
                if let window: UIWindow = UIApplication.sharedApplication().keyWindow {
                    
                    window.addSubview(informationView.view)
                    informationView.didMoveToParentViewController(self)
                    
                    informationView.view.frame.size.width = view.frame.size.width
                    informationView.view.frame.size.height = view.frame.size.height
                    
                    window.addSubview(cell)
                    cell.frame.origin = cellPositionScreen!
                    
                    UIView.animateWithDuration(0.2, animations: {
                        self.informationView.view.alpha = 1
                    })
                }
            }
        } else {
            /*UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: CGFloat(0.2), initialSpringVelocity: CGFloat(1), options: .AllowUserInteraction, animations: {
             self.informationView.view.alpha = 0
             }, completion: { Void in()
             self.informationView.view.removeFromSuperview()
             })*/
        }
    }
}