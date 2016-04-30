//
//  ShareViewController.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/29/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import UIKit
import MapKit

struct shareData {
    var weatherNumber = ""
    var weatherCondition = ""
    var location = ""
    var points = ""
    var tPoints = ""
    var hPoints = ""
    var pPoints = ""
}

class ShareViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var calendarLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var pointsNumber: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var calendarNumber: UILabel!
    @IBOutlet weak var weatherNumber: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var photosLabel: UILabel!
    @IBOutlet weak var photosNumber: UILabel!
    @IBOutlet weak var healthNumber: UILabel!
    @IBOutlet weak var twitterNumber: UILabel!
    @IBOutlet weak var healthView: UIView!
    @IBOutlet weak var twitterView: UIView!
    @IBOutlet weak var photosView: UIView!
    
    let locManager = CLLocationManager()
    var data = shareData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month, .Year], fromDate: date)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM"
        
        calendarNumber.text = String(components.day)
        calendarLabel.text = String(dateFormatter.stringFromDate(NSDate())).uppercaseString
        
        locManager.requestWhenInUseAuthorization()
        locManager.delegate = self
        locManager.location?.coordinate
        
        twitterView.layer.backgroundColor = UIColor(red:0.00, green:0.67, blue:0.93, alpha:1.0).CGColor
        healthView.layer.backgroundColor = UIColor(red:0.98, green:0.54, blue:0.29, alpha:1.0).CGColor
        photosView.layer.backgroundColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1.0).CGColor
        
        twitterLabel.textColor = UIColor(red:0.00, green:0.67, blue:0.93, alpha:1.0)
        healthLabel.textColor = UIColor(red:0.98, green:0.54, blue:0.29, alpha:1.0)
        photosLabel.textColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1.0)
        
        weatherNumber.text = data.weatherNumber
        weatherLabel.text = data.weatherCondition
        pointsNumber.text = data.points
        twitterNumber.text = data.tPoints
        healthNumber.text = data.hPoints
        photosNumber.text = data.pPoints
        locationLabel.text = data.location
    }
    
    override func viewDidLayoutSubviews() {
        pointsLabel.layer.cornerRadius = 5
        pointsLabel.clipsToBounds = true
        calendarLabel.layer.cornerRadius = 5
        calendarLabel.clipsToBounds = true
        weatherLabel.layer.cornerRadius = 5
        weatherLabel.clipsToBounds = true
        header.layer.cornerRadius = 15
        header.clipsToBounds = true
        
        twitterView.layer.cornerRadius = twitterView.frame.height / 2
        healthView.layer.cornerRadius = healthView.frame.height / 2
        photosView.layer.cornerRadius = photosView.frame.height / 2
    }
}
