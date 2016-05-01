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
import CoreLocation

class MainViewController: UIViewController, UIGestureRecognizerDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let realm = try! Realm()
    let locManager = CLLocationManager()
    var today: Results<DayResume>!
    
    var segueSender: CGPoint?
    
    var weatherSummary: String! = ""
    var weatherFahrenheit: String! = ""
    
    var quote = ""
    var weatherCondition = ""
    var locationString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        today = delegate.realm.objects(DayResume)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainViewController.reloadCollection(_:)), name:"ReloadBubbles", object: nil)
        
        locManager.requestWhenInUseAuthorization()
        locManager.delegate = self
        locManager.location?.coordinate
    }

    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse && locManager.location != nil {
            
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(locManager.location!, completionHandler: { (placemarks, error) -> Void in
                var placeMark: CLPlacemark!
                placeMark = placemarks?[0]
                
                if placeMark != nil {
                    if let city = placeMark.addressDictionary!["City"] as? NSString {
                        if let country = placeMark.addressDictionary!["Country"] as? NSString {
                            self.locationString = "\(city), \(country)"
                        }
                    }
                }
            })
            
            let URL = "https://api.forecast.io/forecast/a5833b25fcb056bd99c62d5dca8712fd/\(String(locManager.location!.coordinate.latitude)),\(String(locManager.location!.coordinate.longitude))"

            parseJSON(getJSON(URL)) { (result) in
                if let dictionary = result.valueForKey("currently") {
                    let data = dictionary as! NSDictionary
                    
                    if let temperature = data.valueForKey("temperature") {
                        self.weatherFahrenheit = String(Int(temperature as! Double))
                    }
                    
                    if let summary = data.valueForKey("icon") {
                        self.weatherSummary = summary as! String
                        NSNotificationCenter.defaultCenter().postNotificationName("ReloadBubbles", object: false)
                    }
                }
            }
        }
    }
    
    func reloadCollection(notification: NSNotification) {
        dispatch_async(dispatch_get_main_queue()) {
            self.realm.refresh()
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
            
            cell.PointsNumber.text = String(Int(today.last!.points))
            
            cell.WeatherTemp.text = weatherFahrenheit
            
            switch weatherSummary as String {
            case "clear-day":
                cell.WeatherLabel.text = "CLEAR"
                cell.MainLabel.text = "Keep Productive!"
                cell.SubLabel.text = "Nice weather for some outdoor activity."
                break;
            case "clear-night":
                cell.WeatherLabel.text = "CLEAR"
                cell.MainLabel.text = "Keep It Creative!"
                cell.SubLabel.text = "I wanna be a human to look at those stars."
                break;
            case "rain":
                cell.WeatherLabel.text = "RAINY"
                cell.MainLabel.text = "Awesomeness!"
                cell.SubLabel.text = "Great day to make internet things."
                break;
            case "snow":
                cell.WeatherLabel.text = "SNOWY"
                cell.MainLabel.text = "Moar Media!"
                cell.SubLabel.text = "A SloMo video of a snowball would be cool."
                break;
            case "wind":
                cell.WeatherLabel.text = "WINDY"
                cell.MainLabel.text = "Cut the crap!"
                cell.SubLabel.text = "Go fly a kite! It's awesome. I think. #NotHuman"
                break;
            case "fog":
                cell.WeatherLabel.text = "FOGGY"
                cell.MainLabel.text = "Procrastinating is Meh!"
                cell.SubLabel.text = "It's not a great ideia to drive today."
                break;
            case "cloudy":
                cell.WeatherLabel.text = "CLOUDY"
                cell.MainLabel.text = "Moar Media!"
                cell.SubLabel.text = "Great sky to take a timelapse!"
                break;
            case "partly-cloudy-day":
                cell.WeatherLabel.text = "CLOUDY"
                cell.MainLabel.text = "Moar Media!"
                cell.SubLabel.text = "Great sky to take a timelapse!"
                break;
            case "partly-cloudy-night":
                cell.WeatherLabel.text = "CLOUDY"
                cell.MainLabel.text = "Stay Focused!"
                cell.SubLabel.text = "Time for some commits?"
                break;
            default:
                cell.WeatherLabel.text = "SUNNY"
                break;
            }
            
            weatherCondition = cell.WeatherLabel.text!
            quote = cell.MainLabel.text!
            cell.CalendarDay.text = String(components.day)
            cell.CalendarLabel.text = String(dateFormatter.stringFromDate(NSDate())).uppercaseString
            
            return cell
        } else {
            let cardData = today.last!.cardsOfTheDay[indexPath.section - 1]
            
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("header", forIndexPath: indexPath) as! HeaderCollectionViewCell
                
                cell.name.text = cardData.name
                
                cell.name.clipsToBounds = true
                cell.name.layer.cornerRadius = 8
                
                return cell
            } else {
                if today.last!.cardsOfTheDay[indexPath.section - 1].enabled {
                    let cellData = cardData.bubbles[indexPath.row - 1]

                    switch cellData.type {
                    case "map":
                        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("map", forIndexPath: indexPath) as! MapCollectionViewCell
                        cell.load()
                        return cell
                    case "extension":
                        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("extension", forIndexPath: indexPath) as! ExtensionCollectionViewCell
                        
                        cell.number.text = String(Int(cellData.number))
                        
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
                        
                        cell.number.text = String(Int(cellData.number))
                        
                        let swipeGesture = UILongPressGestureRecognizer(target: self, action: #selector(MainViewController.didPress(_:)))
                        swipeGesture.delegate = self
                        cell.bubble.addGestureRecognizer(swipeGesture)
                        
                        cell.name.text = cellData.label
                        cell.name.textColor = UIColor(hexString: cardData.color)
                        cell.bubble.layer.backgroundColor = UIColor(hexString: cardData.color).CGColor
                        cell.bubble.layer.cornerRadius = cell.bubble.frame.height / 2
                        
                        return cell
                    case "extensionLarge":
                        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("extensionLarge", forIndexPath: indexPath) as! ExtensionCollectionViewCell
                        
                        cell.number.text = String(Int(cellData.number))
                        
                        let swipeGesture = UILongPressGestureRecognizer(target: self, action: #selector(MainViewController.didPress(_:)))
                        swipeGesture.delegate = self
                        cell.bubble.addGestureRecognizer(swipeGesture)
                        
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
                    
                    switch today.last!.cardsOfTheDay[(indexPath?.section)! - 1].name {
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
        let informationModal = ShareViewController(nibName: "ShareViewController", bundle: nil)
        
        var data = shareData()
        
        data.points = String(Int(today.last!.points))
        data.weatherNumber = weatherFahrenheit
        data.weatherCondition = weatherCondition
        data.location = locationString
        data.tPoints = cardPoint(today.last!.cardsOfTheDay, name: "Twitter")
        data.hPoints = cardPoint(today.last!.cardsOfTheDay, name: "Health")
        data.pPoints = cardPoint(today.last!.cardsOfTheDay, name: "Photos")
        
        informationModal.data = data
        
        UIGraphicsBeginImageContextWithOptions(informationModal.view.frame.size, false, 0);
        informationModal.view.drawViewHierarchyInRect(informationModal.view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        let shareText = "\(quote) #MosaicApp"
        
        let vc = UIActivityViewController(activityItems: [shareText, image], applicationActivities: [])
        presentViewController(vc, animated: true, completion: nil)
    }
    

    let informationModal = GeneralModalViewController(nibName: "GeneralModalViewController", bundle: nil)
    let informationView = BlurViewController(nibName: "BlurViewController", bundle: nil)
    var bubbleSuperview: UIView?
    var bubblePosition: CGPoint?
    var infoIsRogue = false
    var infoIsRogueIndexPath: NSIndexPath?
    
    func didPress(recognizer: UIGestureRecognizer){
        /*segueSender = recognizer.locationInView(collectionView)
        performSegueWithIdentifier("ExplodeBubble", sender: self)*/
        
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
                    
                    bubbleSuperview = cell.superview!
                    bubblePosition = cell.frame.origin
                    

                    informationModal.bubble = today.last!.cardsOfTheDay[(infoIsRogueIndexPath?.section)! - 1].bubbles[infoIsRogueIndexPath!.row - 1]
                    
                    window.addSubview(cell)
                    cell.frame.origin = cellPositionScreen!
                    
                    let primitivePosition = cellPositionScreen!.y - 10 - informationModal.view.frame.height
                    
                    window.addSubview(informationModal.view)
                    
                    let ratio = (cell.bubble.frame.width - 5) / informationModal.view.frame.width
                    informationModal.view.transform = CGAffineTransformMakeScale(ratio, ratio)
                    informationModal.view.frame.origin = cellPositionScreen!
                
                    
                    UIView.animateWithDuration(0.2, animations: {
                        self.informationModal.view.transform = CGAffineTransformIdentity
                        self.informationModal.view.frame.origin.y = primitivePosition
                        self.informationModal.view.frame.origin.x = 0
                        
                        self.informationView.view.alpha = 1
                    })
                }
            }
        } else {
            let cell = collectionView.cellForItemAtIndexPath(infoIsRogueIndexPath!) as! ExtensionCollectionViewCell
            
            UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: CGFloat(0.2), initialSpringVelocity: CGFloat(1), options: .AllowUserInteraction, animations: {
                self.informationView.view.alpha = 0
                self.informationModal.view.alpha = 0
                }, completion: { Void in()
                    self.informationModal.view.transform = CGAffineTransformIdentity
                    self.informationModal.view.removeFromSuperview()
                    self.informationModal.view.alpha = 1
                    
                    self.bubbleSuperview!.addSubview(cell)
                    cell.frame.origin = self.bubblePosition!
                    self.informationView.view.removeFromSuperview()
                    self.infoIsRogue = false
            })
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .Default
    }
}