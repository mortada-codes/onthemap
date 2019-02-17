//
//  UserAccount.swift
//  on the map
//
//  Created by mahmoud mortada on 2/15/19.
//  Copyright © 2019 mahmoud mortada. All rights reserved.
//

import Foundation


struct Account:Codable {
    let registered:Bool
    let key:String
    enum CodingKeys : String, CodingKey {
        case registered
        case  key
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self )
        self.registered = try! values.decode(Bool.self, forKey: .registered)
                self.key = try! values.decode(String.self, forKey: .key)
    }
}

struct  Session :Codable {
    let id:String
    let expiration:String
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self )
        self.id = try! values.decode(String.self, forKey: .id)
        self.expiration = try! values.decode(String.self, forKey: .expiration)
    }
    
    enum CodingKeys : String, CodingKey {
        case id
        case  expiration
    }
    
}

struct User :Codable{
    let account:Account
    let session:Session
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy:CodingKeys.self )
        self.account = try! values.decode(Account.self, forKey: .account)
        self.session = try! values.decode(Session.self, forKey: .session)
    }
    
    enum CodingKeys : String, CodingKey {
        case account
        case  session
    }
    
    
}

