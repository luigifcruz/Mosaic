//
//  ExplodeSegue.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 5/1/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import UIKit

class ExplodeSegue: UIStoryboardSegue {
    override func perform() {
        let source = self.sourceViewController as! MainViewController
        let destination = self.destinationViewController as! DetailViewController
        
        if let indexPath = source.collectionView.indexPathForItemAtPoint(source.segueSender!) {
            let cell = source.collectionView.cellForItemAtIndexPath(indexPath) as! ExtensionCollectionViewCell
            let cellPositionScreen = cell.bubble.superview?.convertPoint(cell.bubble.frame.origin, toView: nil)
            
            if let window: UIWindow = UIApplication.sharedApplication().keyWindow {
                cell.bubble.frame.origin = cellPositionScreen!
                destination.view.backgroundColor = cell.bubble.backgroundColor
                window.addSubview(cell.bubble)
                cell.number.alpha = 0
                
                UIView.animateWithDuration(0.25, animations: {
                    cell.bubble.transform = CGAffineTransformMakeScale(25, 25)
                }) { (finished) in
                    destination.view.removeFromSuperview()
                    delay(0.001) {
                        destination.bubbleBackground = darkerColorForColor(cell.bubble.backgroundColor!.colorWithAlphaComponent(0.15))
                        destination.textColor = lighterColorForColor(cell.bubble.backgroundColor!)
                        
                        destination.setNeedsStatusBarAppearanceUpdate()
                        
                        source.presentViewController(destination, animated: false, completion: {
                            destination.view.transform = CGAffineTransformMakeScale(0.90, 0.90)
                            destination.view.alpha = 0
                            window.sendSubviewToBack(cell.bubble)
                            
                            UIView.animateWithDuration(0.2, delay: 0, options: [.AllowAnimatedContent], animations: {
                                destination.view.transform = CGAffineTransformIdentity
                                destination.view.alpha = 1
                                }, completion: { (finished) in
                                    cell.bubble.removeFromSuperview()
                                    source.collectionView.reloadData()
                            })
                        })
                    }
                }
            }
        }
    }
}
