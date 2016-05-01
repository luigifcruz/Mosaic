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
        let destination = self.destinationViewController
        
        if let indexPath = source.collectionView.indexPathForItemAtPoint(source.segueSender!) {
            let cell = source.collectionView.cellForItemAtIndexPath(indexPath) as! ExtensionCollectionViewCell
            let cellPositionScreen = cell.bubble.superview?.convertPoint(cell.bubble.frame.origin, toView: nil)
            
            if let window: UIWindow = UIApplication.sharedApplication().keyWindow {
                cell.bubble.frame.origin = cellPositionScreen!
                destination.view.backgroundColor = cell.bubble.backgroundColor
                window.addSubview(cell.bubble)
                cell.number.alpha = 0
                
                UIView.animateWithDuration(0.4, animations: {
                    cell.bubble.transform = CGAffineTransformMakeScale(25, 25)
                }) { (finished) in
                    destination.view.removeFromSuperview()
                    delay(0.001) {
                        source.presentViewController(destination, animated: false, completion: {
                            cell.bubble.removeFromSuperview()
                        })
                    }
                }
            }
        }
    }
}
