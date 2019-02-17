//
//  AuthService.swift
//  on the map
//
//  Created by mahmoud mortada on 10/12/18.
//  Copyright © 2018 mahmoud mortada. All rights reserved.
//

import Foundation


enum AuthError:Error{
   case WRONGUSERNAMEANDPASSWORD
}


class AuthService {
    let LOGIN_URL: String = "https://onthemap-api.udacity.com/v1/session";
    // https://parse.udacity.com/parse/classes
    let urlSession = URLSession.shared
    func login(email:String,password:String,errorCallback:@escaping (_ e:Error?)->Void,onSuccess:@escaping (_ data:User?)->Void){

        let body = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}"
        var urlRequest = URLRequest(url: URL(string: LOGIN_URL)!)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = body.data(using:.utf8)
        let task = urlSession.dataTask(with: urlRequest){data, response,error in
            guard error == nil else {
                errorCallback(error)
                return
            }
            
            if let res   = response as? HTTPURLResponse {
                print(res.statusCode)
                if(res.statusCode != 200  ){
                    errorCallback(AuthError.WRONGUSERNAMEANDPASSWORD)
                    return
                }
            }
        
            
            let decoder = JSONDecoder()
            guard data != nil else {
                return
            }
            do{
            let user = try? decoder.decode(User.self, from: data!)
            
            
                onSuccess(user)
            
            }catch{
                   print(error)
            }
            
        }
        
        task.resume()
    }
    
    
 
    
    func deleteSession(){
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
    }
    
}
