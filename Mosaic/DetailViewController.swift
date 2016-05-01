//
//  PhotosViewController.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 5/1/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.row % 2 == 0 {
            return CGSize(width: 414, height: 20)
        } else {
            return CGSize(width: 414, height: 54)
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.row % 2 == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("padding", forIndexPath: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("header", forIndexPath: indexPath) as! DetailHeaderCollectionViewCell
            cell.title.layer.cornerRadius = 10
            cell.title.clipsToBounds = true
            return cell
        }
    }
    

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}
