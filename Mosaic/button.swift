//
//  button.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/19/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//


import UIKit

class bouncyButton: UIButton {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            if traitCollection.forceTouchCapability == UIForceTouchCapability.Available {
                touched(Float(touch.force))
            } else {
                touched(0)
            }
        }
        super.touchesBegan(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        restore()
        super.touchesEnded(touches, withEvent: event)
    }
    
    override var highlighted: Bool {
        didSet { if highlighted { highlighted = false } }
    }
    
    func touched(force: Float) {
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: CGFloat(0.45), initialSpringVelocity: CGFloat(6.0), options: .AllowUserInteraction, animations: {
            
            let globalPercentage = ((force+1)/2) * 100
            
            var realForce: Float = 0
            
            if globalPercentage <= 50 {
                let partialForce = ((globalPercentage/50) * 100)
                realForce = 0.1 - ((partialForce/100)*0.1)
            } else {
                let partialForce = (((globalPercentage-50)/50) * 100)
                realForce = -(partialForce/100)*0.1
            }
            
            self.transform = CGAffineTransformMakeScale(0.88 + CGFloat(realForce), 0.88 + CGFloat(realForce))
            },
                                   completion: { Void in()  }
        )
    }
    
    func restore() {
        UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: CGFloat(0.2), initialSpringVelocity: CGFloat(6.0), options: .AllowUserInteraction, animations: {
            self.transform = CGAffineTransformIdentity
            },
                                   completion: { Void in()  }
        )
    }
}
