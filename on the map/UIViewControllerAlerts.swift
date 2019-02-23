//
//  UIViewControllerAlerts.swift
//  on the map
//
//  Created by mahmoud mortada on 2/23/19.
//  Copyright © 2019 mahmoud mortada. All rights reserved.
//

import UIKit


extension UIViewController {
    
    
    
    
    func alertMessage(loadingAlertView:UIAlertController =  UIAlertController(title: "Loading", message:nil,preferredStyle:.alert)) ->Void{
        
    
        
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: loadingAlertView.view.bounds)
            loadingIndicator.autoresizingMask = .flexibleHeight
            loadingIndicator.center = loadingAlertView.view.center;
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            loadingIndicator.startAnimating();
            loadingAlertView.view.addSubview(loadingIndicator)
        
        present(loadingAlertView, animated: true)
        
    }
    
}
