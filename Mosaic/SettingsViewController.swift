//
//  SettingsViewController.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/30/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import UIKit

struct didYouKnowData {
    var title = ""
    var description = ""
    var image = ""
}

struct settingsData {
    var type = "know"
    var know = didYouKnowData()
    var header = ""
}

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var settingData: [settingsData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var didYouKnowHeader = settingsData()
        didYouKnowHeader.type = "header"
        didYouKnowHeader.header = "DID YOU KNOW?"
        
        var didYouKnow1 = settingsData()
        didYouKnow1.type = "knowButton"
        didYouKnow1.know.title = "3D Touch Feedback Buttons"
        didYouKnow1.know.description = "Mosaic buttons react to the force you press them. This helps them feel more real, don't you think? Go ahead an try it!"
        
        var didYouKnow2 = settingsData()
        didYouKnow2.type = "knowImage"
        didYouKnow2.know.image = "information.jpg"
        didYouKnow2.know.title = "Bubble Information"
        didYouKnow2.know.description = "Long press to see more details and informations about the bubble."
        
        var didYouKnow3 = settingsData()
        didYouKnow3.type = "know"
        didYouKnow3.know.title = "Awesome Sharing Options"
        didYouKnow3.know.description = "The share button on the top bar generates a cool looking image of your points to share anywhere!"
        
        var didYouKnow4 = settingsData()
        didYouKnow4.type = "knowImage"
        didYouKnow4.know.image = "quotes.jpg"
        didYouKnow4.know.title = "Environment Based Suggestions"
        didYouKnow4.know.description = "The app humanly suggests what to do based on data provided. Focusing in productivity."
        
        var didYouKnow5 = settingsData()
        didYouKnow5.type = "know"
        didYouKnow5.know.title = "New Cards Coming Soon"
        didYouKnow5.know.description = "Great new cards such as GitHub, HomeKit, Automatic, Swarm and even more!"
        
        settingData.appendContentsOf([didYouKnowHeader, didYouKnow1, didYouKnow2, didYouKnow4, didYouKnow3, didYouKnow5])
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch settingData[indexPath.row].type {
        case "header":
            return CGFloat(45)
        case "knowImage":
            return CGFloat(345)
        case "knowButton":
            return CGFloat(165)
        case "know":
            return CGFloat(103)
        default:
            return CGFloat(0)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch settingData[indexPath.row].type {
        case "header":
            let cell = tableView.dequeueReusableCellWithIdentifier(settingData[indexPath.row].type, forIndexPath: indexPath) as! HeaderTableViewCell
            
            cell.headerTitle.text = settingData[indexPath.row].header
            return cell
        case "knowImage":
            let cell = tableView.dequeueReusableCellWithIdentifier(settingData[indexPath.row].type, forIndexPath: indexPath) as! DidYouKnowTableViewCell
            
            cell.knowTitle.text = settingData[indexPath.row].know.title
            cell.knowDescription.text = settingData[indexPath.row].know.description
            
            cell.knowImage.image = UIImage(named: settingData[indexPath.row].know.image)
            
            cell.knowView.layer.cornerRadius = 17
            cell.knowView.clipsToBounds = true
            cell.knowImage.layer.cornerRadius = 14
            cell.knowImage.clipsToBounds = true
            
            return cell
        case "knowButton":
            let cell = tableView.dequeueReusableCellWithIdentifier(settingData[indexPath.row].type, forIndexPath: indexPath) as! DidYouKnowTableViewCell
            
            cell.knowTitle.text = settingData[indexPath.row].know.title
            cell.knowDescription.text = settingData[indexPath.row].know.description
            cell.button.layer.cornerRadius = cell.button.frame.height / 2
            cell.knowView.layer.cornerRadius = 17
            cell.knowView.clipsToBounds = true
            
            return cell
        case "know":
            let cell = tableView.dequeueReusableCellWithIdentifier(settingData[indexPath.row].type, forIndexPath: indexPath) as! DidYouKnowTableViewCell
            
            cell.knowTitle.text = settingData[indexPath.row].know.title
            cell.knowDescription.text = settingData[indexPath.row].know.description
            
            cell.knowView.layer.cornerRadius = 17
            cell.knowView.clipsToBounds = true
            
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(settingData[indexPath.row].type, forIndexPath: indexPath) as! DidYouKnowTableViewCell
            return cell
        }
    }
    
    var count = 0
    @IBAction func click(sender: AnyObject) {
        count += 1
        if count == 5 {
            if let window: UIWindow = UIApplication.sharedApplication().keyWindow {

            }
        }
    }

}
