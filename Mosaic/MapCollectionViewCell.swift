//
//  MapCollectionViewCell.swift
//  Mosaic
//
//  Created by Luigi Freitas Cruz on 4/26/16.
//  Copyright © 2016 Luigi Freitas. All rights reserved.
//

import UIKit
import MapKit

class MapCollectionViewCell: UICollectionViewCell, MKMapViewDelegate {
    @IBOutlet weak var MapView: MKMapView!
    var imageLocations: [ImageLocation]?
    
    func load() {
        MapView.layer.cornerRadius = 15
        MapView.clipsToBounds = true
        MapView.delegate = self
        
        
        Photos.getMediaLocation(NSDate(), media: .Image) {
            (result) in
            self.imageLocations = result
            
            var annotations: [MKPointAnnotation] = []
            for location in self.imageLocations! {
                let myAnnotation = MKPointAnnotation()
                myAnnotation.coordinate = location.coordinate!
    
                annotations.append(myAnnotation)
            }
            self.MapView.addAnnotations(annotations)
            self.MapView.showAnnotations(self.MapView.annotations, animated: true)
        }

    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {

        let anView = MKAnnotationView(annotation: annotation, reuseIdentifier: String(annotation.coordinate))

        anView.image = imageLocations![0].image
        anView.backgroundColor = UIColor.clearColor()
        anView.frame.size = CGSize(width: 45, height: 45)
        anView.canShowCallout = false
        anView.layer.borderColor = UIColor.whiteColor().CGColor
        anView.layer.borderWidth = 2
        anView.layer.cornerRadius = anView.frame.height / 2
        anView.clipsToBounds = true
        
        return anView
    }
}
