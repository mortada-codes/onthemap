//
//  PinMarkerView.swift
//  on the map
//
//  Created by mahmoud mortada on 2/16/19.
//  Copyright © 2019 mahmoud mortada. All rights reserved.
//

import MapKit

class PinMarkerView :MKAnnotationView {
    
    override var annotation: MKAnnotation?{
        willSet{
            canShowCallout = true
            calloutOffset = CGPoint(x:-0.5,y:-0.5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            image = UIImage(named: "")
        }
    }
}
