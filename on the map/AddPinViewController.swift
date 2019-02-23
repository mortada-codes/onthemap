//
//  AddPinViewController.swift
//  on the map
//
//  Created by mahmoud mortada on 10/12/18.
//  Copyright © 2018 mahmoud mortada. All rights reserved.
//

import UIKit

class AddPinViewController :UIViewController{
    
    
    let pinService = PinService()
    @IBOutlet weak var tfWebsite: UITextField!
    @IBOutlet weak var tfLocation: UITextField!
  
    
    @IBAction func onCancelAction(_ sender: Any) {
            self.dismiss(animated: true)
    }
 

    @IBAction func findLocationPressed(_ sender: Any) {
   
        guard let  location  = tfLocation.text,!location.isEmpty  else {
            alertMessage(message: "Enter your location")
            return
        }

        
        guard let website = tfWebsite.text ,  !website.isEmpty else {
             alertMessage(message: "Enter your website")
            return
        }
        
            performSegue(withIdentifier: "pickLocation", sender: sender)
       
    }
    
    
    func alertMessage(message:String) ->Void{
        let alert =      UIAlertController(title: "Error", message:message,preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                    let targetController = segue.destination as! AddLocationViewController
                targetController.location = tfLocation?.text!
        targetController.website = tfWebsite?.text!
    }
}
