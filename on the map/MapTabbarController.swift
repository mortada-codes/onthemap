//
//  MapTabbarController.swift
//  on the map
//
//  Created by mahmoud mortada on 2/14/19.
//  Copyright © 2019 mahmoud mortada. All rights reserved.
//

import UIKit

class MapTabbarController :UITabBarController {
    
    @IBAction func onLogout(_ sender: Any) {
        
  self.dismiss(animated: true)
    }
    let pinService  = PinService()
    
    @IBAction func onReferesh(_ sender: Any) {
        loadPins()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    
}
extension MapTabbarController {
    
    func loadPins(){
        self.pinService.studentLocation(errorCallback: { (err) in
            
        }, onSuccess: { (data) in
            DispatchQueue.main.async {
                let appDelegate =  UIApplication.shared.delegate as! AppDelegate
                appDelegate.pins = data.results
                
            }
            
        })
    }
}
