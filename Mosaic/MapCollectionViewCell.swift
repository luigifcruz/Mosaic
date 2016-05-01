//
//  MapCollectionViewCell.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/26/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import UIKit
import MapKit

class CustomPointAnnotation: MKPointAnnotation {
    var image: UIImage!
}

class MapCollectionViewCell: UICollectionViewCell, MKMapViewDelegate {
    @IBOutlet weak var MapView: MKMapView!
    
    func load() {
        MapView.layer.cornerRadius = 15
        MapView.clipsToBounds = true
        MapView.delegate = self
        
        
        Photos.getMediaLocation(NSDate(), media: .Image) {
            (result) in
            
            var annotations: [CustomPointAnnotation] = []
            for location in result {
                let myAnnotation = CustomPointAnnotation()
                myAnnotation.coordinate = location.coordinate!
                myAnnotation.image = location.image
                
                annotations.append(myAnnotation)
            }
            self.MapView.addAnnotations(annotations)
            self.MapView.showAnnotations(self.MapView.annotations, animated: true)
        }

    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {

        let anView = MKAnnotationView(annotation: annotation, reuseIdentifier: String(annotation.coordinate))
    
        
        if let annotation = annotation as? CustomPointAnnotation {
            anView.image = annotation.image
            anView.backgroundColor = UIColor.clearColor()
            anView.frame.size = CGSize(width: 45, height: 45)
            anView.canShowCallout = false
            anView.layer.borderColor = UIColor.whiteColor().CGColor
            anView.layer.borderWidth = 2
            anView.layer.cornerRadius = anView.frame.height / 2
            anView.clipsToBounds = true
        }

        return anView
    }
}
