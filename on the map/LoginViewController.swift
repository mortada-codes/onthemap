//
//  LoginViewController.swift
//  on the map
//
//  Created by mahmoud mortada on 10/12/18.
//  Copyright © 2018 mahmoud mortada. All rights reserved.
//

import Foundation
import UIKit


class LoginViewController :UIViewController{
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    let authService = AuthService()
    
    override func viewDidLoad() {
        self.definesPresentationContext = true
    }
    
    
    @IBAction func onLoginPressed(_ sender: UIButton) {
        let email =   tfEmail.text
        let password = tfPassword.text
        guard  !email!.isEmpty  ||  !password!.isEmpty else {
            alertMessage(message: "Please type correct email and password")
            return
        }
        
        authService.login(email: email!, password: password!, errorCallback: { (err:Error?)  in
            DispatchQueue.main.async {
                    
                self.alertMessage(message: "Login Failed")
                
            }
      
        }) { (user) in
            DispatchQueue.main.async {
                   self.onLoggedIn()
            }
         
        }
        
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        
        UIApplication.shared.open(URL(string: "https://www.udacity.com")!)
    }
    
    func onLoggedIn(){
        let appController = storyboard?.instantiateViewController(withIdentifier: "AppMainNav")
        present(appController!, animated: true)
    }
    
    
    func alertMessage(message:String) ->Void{
        let alert =      UIAlertController(title: "Error", message:message,preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
    
    
    
}
