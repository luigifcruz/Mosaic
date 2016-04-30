//
//  GeneralModalViewController.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/28/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import UIKit

class GeneralModalViewController: UIViewController {

    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var titleText: UILabel!
    
    var bubble = Bubble()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        descriptionText!.text = bubble.infoDescription
        titleText!.text = bubble.infoTitle
    }
    
    override func viewDidLayoutSubviews() {
        blurView.layer.cornerRadius = 16
        blurView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
