//
//  StudentMarker.swift
//  on the map
//
//  Created by mahmoud mortada on 2/14/19.
//  Copyright © 2019 mahmoud mortada. All rights reserved.
//


import UIKit
import MapKit
class StudentMarker :NSObject,MKAnnotation {
    let title: String?
    let subtitle: String?
 
    let coordinate: CLLocationCoordinate2D
   
    
    
    
    
     init(title:String,subtitle:String,discipline:String,latidute:Double,longitude:Double) {
            self.coordinate = CLLocationCoordinate2D(latitude: latidute, longitude: longitude)
        self.title = title
        self.subtitle = subtitle
    }
    
}
