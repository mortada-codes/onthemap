//
//  AddLocationViewController.swift
//  on the map
//
//  Created by mahmoud mortada on 2/14/19.
//  Copyright © 2019 mahmoud mortada. All rights reserved.
//

import UIKit

import MapKit
class AddLocationViewController :UIViewController{
    
    @IBOutlet weak var mapView: MKMapView!
    let pinService = PinService()
    var website:String? 
    var location:String?
    var latitude:Double?
    var longitude:Double?
    var loadingAlertView:UIAlertController?
    
    
    override func viewDidLoad() {
        mapView.delegate = self
  
        
    }
    
    @IBAction func submitPin(_ sender: Any) {
       var post = StudentInformation(uniqueKey: "", firstName: "Mo", lastName: "MoMo", mapString: location, mediaURL: website, latitude: latitude, longitude: longitude)
                alertMessage()
        pinService.postStudent(pin: post){ error, data in
            if(error != nil){
                self.errorAlertMessage(message: "error while subminting post")
                return
            }
            DispatchQueue.main.async {
                 self.dismissLoadingAlert()
             self.dismiss(animated: true)
                self.navigationController?.popViewController(animated: true)
         
            }
           
            
        }
    }
    
    
    func errorAlertMessage(message :String ){
        let alert =      UIAlertController(title: "Error", message:message,preferredStyle:.alert)
        let uiaction = UIAlertAction(title: "Yes", style: .default, handler:{ _ in
            self.dismiss(animated: true)
        })
        alert.addAction(uiaction)
        
        present(alert, animated: true)
    }
    
    
    
    func alertMessage() ->Void{
        
        if(loadingAlertView == nil){
       loadingAlertView =      UIAlertController(title: "Loading", message:nil,preferredStyle:.alert)
        var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: loadingAlertView!.view.bounds)
        loadingIndicator.autoresizingMask = .flexibleHeight
        loadingIndicator.center = loadingAlertView!.view.center;
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();

      
            loadingAlertView?.view.addSubview(loadingIndicator)
        }
        present(loadingAlertView!, animated: true)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        alertMessage()
        findLocation(address: location!)
    }
    
    func dismissLoadingAlert(){
        loadingAlertView?.dismiss(animated: true)
    }
    
}


extension AddLocationViewController :MKMapViewDelegate{
    
    
    
    
    
    func findLocation(address:String) {
        CLGeocoder().geocodeAddressString(address, completionHandler: { placemarks, error in
            self.dismissLoadingAlert()
            if (error != nil) {
                DispatchQueue.main.async {
                self.errorAlertMessage(message: "Location not found")
                }
              
                return
            }
            
            if(placemarks == nil || (placemarks != nil && (placemarks?.isEmpty)!)){
                DispatchQueue.main.async {
                    self.errorAlertMessage(message: "Location not found")
                }
                
            }
            
            
            if let placemark = placemarks?[0]  {
                    let coordinate = placemark.location?.coordinate
                self.longitude = placemark.location?.coordinate.longitude
                self.latitude  = placemark.location?.coordinate.latitude
                let name = placemark.name!
                let country = placemark.country!
                let region = placemark.administrativeArea!
                
                
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let regionCoord = MKCoordinateRegionMake(coordinate!, span)
                self.mapView.setRegion(regionCoord, animated: true)
                self.mapView.addAnnotation(StudentMarker(title: "", subtitle: "", discipline: "", latidute:self.latitude!, longitude:self.longitude!))
            }
        })
    }
    }

