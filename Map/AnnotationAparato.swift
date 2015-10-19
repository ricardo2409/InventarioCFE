//
//  AnnotationAparato.swift
//  Map
//
//  Created by Ricardo Trevino on 4/5/15.
//  Copyright (c) 2015 Ricardo Trevino. All rights reserved.
//

import MapKit
import Parse

class AnnotationAparato: NSObject, MKAnnotation {
    let type: Int
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let url: String
    let subtitle: String?
    
    init(type: Int, coordinate: CLLocationCoordinate2D, title: String, url:String, subtitle: String) {
        
        self.type = type
        self.coordinate = coordinate
        self.title = title
        self.url = url
        self.subtitle = subtitle
        super.init()
    }
    
}