//
//  SettingsViewController.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/30/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("header", forIndexPath: indexPath) as! HeaderTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("know", forIndexPath: indexPath) as! DidYouKnowTableViewCell
            
            cell.knowView.layer.cornerRadius = 17
            cell.knowView.clipsToBounds = true
            cell.knowImage.layer.cornerRadius = 14
            cell.knowImage.clipsToBounds = true
            return cell
        }
        
    }
    
}
