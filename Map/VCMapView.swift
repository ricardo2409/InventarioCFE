//
//  VCMapView.swift
//  Map
//
//  Created by Ricardo Trevino on 4/5/15.
//  Copyright (c) 2015 Ricardo Trevino. All rights reserved.
//

import Foundation
import MapKit

extension ViewController: MKMapViewDelegate{
    // 1
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let annotation = annotation as? Aparato {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIView
            }
            view.pinColor = annotation.pinColor()
            
            return view
        }
        return nil
    }
}