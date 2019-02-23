//
//  PinsTableViewController.swift
//  on the map
//
//  Created by mahmoud mortada on 10/12/18.
//  Copyright © 2018 mahmoud mortada. All rights reserved.
//

import UIKit

class PinsTableViewController : UITableViewController{
    
    var pins:[StudentInformation] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    

    
    override func viewDidAppear(_ animated: Bool) {
     
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        pins = appDelegate.pins!
      
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var view  = tableView.dequeueReusableCell(withIdentifier:"pinCell" )
        
        if(view == nil){
            view = UITableViewCell()
        }
        let pin = pins[indexPath.row]
        
        view?.textLabel?.text = pin.firstName
        view?.detailTextLabel?.text = pin.mediaURL
    
        return view!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let urlString = pins[indexPath.row].mediaURL{
            if let url = URL(string:urlString) {
            UIApplication.shared.open(url)
            }else{
                UIApplication.shared.open(URL(string:"https://www.google.com/search?q=\(urlString)")!)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pins.count
    }
    
    
    
    
    
}
