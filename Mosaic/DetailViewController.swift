//
//  PhotosViewController.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 5/1/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import UIKit
import Charts

class DetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var bubbleBackground: UIColor?
    var textColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: 414, height: 20)
        } else if indexPath.row == 1 {
            return CGSize(width: 414, height: 60)
        } else {
            return CGSize(width: 414, height: 198)
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("padding", forIndexPath: indexPath)
        
            return cell
        } else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("header", forIndexPath: indexPath) as! DetailHeaderCollectionViewCell

            cell.title.textColor = textColor
            cell.headerSeparator.backgroundColor = textColor?.colorWithAlphaComponent(0.95)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("mainChart", forIndexPath: indexPath) as! DetailGraphCollectionViewCell
            
            let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
            let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
            
            var dataEntries: [ChartDataEntry] = []
            
            for i in 0..<months.count {
                let dataEntry = ChartDataEntry(value: unitsSold[i], xIndex: i)
                dataEntries.append(dataEntry)
            }

            let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Units Sold")
            lineChartDataSet.drawCubicEnabled = true
            lineChartDataSet.drawFilledEnabled = true
            lineChartDataSet.colors = [bubbleBackground!]
            lineChartDataSet.drawValuesEnabled = false
            lineChartDataSet.drawCirclesEnabled = false
            lineChartDataSet.fillColor = lighterColorForColor(self.view.backgroundColor!)
            
            let lineChartData = LineChartData(xVals: months, dataSet: lineChartDataSet)
            cell.graph.data = lineChartData
            cell.graph.animate(yAxisDuration: 1)
            
            cell.graph.drawGridBackgroundEnabled = false
            cell.graph.pinchZoomEnabled = false
            cell.graph.drawBordersEnabled = false
            cell.graph.dragEnabled = false
            cell.graph.rightAxis.enabled = false
            cell.graph.xAxis.drawGridLinesEnabled = false
            
            cell.graph.xAxis.labelTextColor = textColor!.colorWithAlphaComponent(1)
            cell.graph.rightAxis.drawGridLinesEnabled = false
            cell.graph.leftAxis.drawGridLinesEnabled = false
            cell.graph.leftAxis.enabled = false
        
            cell.graph.descriptionText = ""
            cell.graph.backgroundColor = UIColor.clearColor()
            cell.graph.legend.enabled = false
            
            cell.graph.userInteractionEnabled = false
            cell.chartBackground.layer.cornerRadius = 10
            cell.chartBackground.backgroundColor = bubbleBackground
            cell.graph.clipsToBounds = true
            
            return cell
        }
    }

    
    @IBAction func close(sender: AnyObject) {
        performSegueWithIdentifier("CloseDetail", sender: self)
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}
