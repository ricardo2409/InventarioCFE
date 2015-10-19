//
//  Aparato.swift
//  Map
//
//  Created by Ricardo Trevino on 4/5/15.
//  Copyright (c) 2015 Ricardo Trevino. All rights reserved.
//

import Foundation
import MapKit

class Aparato: NSObject, MKAnnotation {
    
    var tipoAparato = 0
    
    let title: String?
    let modelo: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, modelo: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.modelo = modelo
        self.coordinate = coordinate
        super.init()
    }
    func pinColor() -> MKPinAnnotationColor  {
        switch tipoAparato {
        case 1:
            return .Red
        case 2:
            return .Purple
        default:
            return .Green
        }
    }
}