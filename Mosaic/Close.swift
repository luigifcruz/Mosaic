//
//  Close.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 5/1/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import UIKit

class Close: UIStoryboardSegue {
    override func perform() {
        let source = self.sourceViewController
        let destination = self.destinationViewController
        
        UIView.animateWithDuration(0.4, animations: { 
             source.view.transform = CGAffineTransformMakeTranslation(0, source.view.frame.height)
            }) { (finished) in
                destination.view.removeFromSuperview()
                delay(0.001) {
                    destination.setNeedsStatusBarAppearanceUpdate()
                    source.presentViewController(destination, animated: false, completion: {
                    })
                }
        }
    }
}
