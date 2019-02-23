//
//  ViewController.swift
//  on the map
//
//  Created by mahmoud mortada on 6/30/18.
//  Copyright © 2018 mahmoud mortada. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let pinService :PinService  = PinService()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        mapView.delegate = self
        
    self.loadPins()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addPinsToMap()
    }
    
    
    func loadPins(){
        self.pinService.studentLocation(errorCallback: { (err) in
            
        }, onSuccess: { (data) in
            DispatchQueue.main.async {
                let appDelegate =  UIApplication.shared.delegate as! AppDelegate
                appDelegate.pins = data.results
                self.mapView.addAnnotations(data.results.filter({ (s) -> Bool in
                    return s.firstName != nil && s.latitude != nil && s.longitude != nil
                }).map({ (student) -> StudentMarker in
                    return   StudentMarker(title: student.firstName!, subtitle: student.lastName!, discipline: student.mapString!, latidute: student.latitude!, longitude: student.longitude!)
                }))
                
            }
            
        })
    }
    
    
    func addPinsToMap(){
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let pins =  appDelegate.pins
        
        self.mapView.addAnnotations((pins?.filter({ (s) -> Bool in
            return s.firstName != nil && s.latitude != nil && s.longitude != nil
        }).map({ (student) -> StudentMarker in
            return   StudentMarker(title: student.firstName!, subtitle: student.mediaURL!, discipline: student.mapString!, latidute: student.latitude!, longitude: student.longitude!)
        }))!)
        
    }

}





extension MapViewController:MKMapViewDelegate{
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        self.mapView = mapView
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
            
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }

    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
                let annotation = view.annotation as! StudentMarker
    
        
        if let urlString = annotation.subtitle {
            if let url = URL(string:urlString) {
                UIApplication.shared.open(url)
            }else{
                UIApplication.shared.open(URL(string:"https://www.google.com/search?q=\(urlString)")!)
            }
        }
    
    }
    
    
}




