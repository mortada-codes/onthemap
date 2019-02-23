//
//  PinService.swift
//  on the map
//
//  Created by mahmoud mortada on 10/12/18.
//  Copyright © 2018 mahmoud mortada. All rights reserved.
//

import Foundation

class PinService {
    
    let STUDENT_URL: String = "https://parse.udacity.com/parse/classes/StudentLocation?order=-updatedAt";
   
       let urlSession = URLSession.shared
    func studentLocation(errorCallback:@escaping (_ e:Error?)->Void,onSuccess:@escaping (_ data:Result)->Void){
        
        
        var urlRequest = URLRequest(url: URL(string: STUDENT_URL)!)
        urlRequest.httpMethod = "get"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        urlRequest.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let task = urlSession.dataTask(with: urlRequest){ data, response,error in
            guard data != nil else {
                errorCallback(error)
                return
            }
            
            do{
                let decoder = JSONDecoder()
                  let student = try (decoder.decode(Result.self, from: data!))
                onSuccess(student)
                
            }catch{
                print(error)
            }
            
      
            
            }
        
        task.resume()
    }
    
    
    
    func postStudent(pin pinPost:StudentInformation, oncomplete:@escaping (_ error:Error?,_ result:StudentInformation?)->Void){
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    let encoder = JSONEncoder()
    
    request.httpBody =   try? encoder.encode(pinPost)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
               oncomplete(error,nil)
                return
            }
            
            
            oncomplete(nil,nil)
        }
        task.resume()
    }
    
    
    func updateStudent(pin pinPost:StudentInformation, oncomplete:@escaping (_ error:Error,_ result:StudentInformation)->Void){
        let urlString = "https://parse.udacity.com/parse/classes/StudentLocation/8ZExGR5uX8"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
     
        let encoder = JSONEncoder()
        
        request.httpBody =   try? encoder.encode(pinPost)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
    
    
    func getStudentLocation(id:String){
        let request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/users/\(id)")!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error...
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
    }
    
}
