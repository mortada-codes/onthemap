//
//  StudentInformation.swift
//  on the map
//
//  Created by mahmoud mortada on 10/12/18.
//  Copyright © 2018 mahmoud mortada. All rights reserved.
//

import Foundation


struct Result :Codable{
    let results:[StudentInformation]
    
    
  
}


struct StudentInformation:Codable{
    var objectId:String?
    let uniqueKey:String?
    let firstName:String?
    let lastName:String?
    let mapString:String?
    let mediaURL:String?
    let latitude:Double?
    let longitude:Double?
    var createdAt: String?
    var updatedAt: String?
    
    init(
        uniqueKey:String?,
        firstName:String?,
        lastName:String?,
        mapString:String?,
        mediaURL:String?,
        latitude:Double?,
        longitude:Double?
        
        ) {
         self.uniqueKey = uniqueKey
         self.firstName = firstName
         self.lastName = lastName
         self.mapString = mapString
         self.mediaURL = mediaURL
         self.latitude = latitude
         self.longitude = longitude
        
    }

    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        latitude = try? values.decode(Double.self, forKey: .latitude)
        longitude = try? values.decode(Double.self, forKey: .longitude)
        objectId = try? values.decode(String.self, forKey: .objectId)
        uniqueKey = try? values.decode(String.self, forKey: .uniqueKey)
        firstName = try? values.decode(String.self, forKey: .firstName)
        lastName = try? values.decode(String.self, forKey: .lastName)
        mapString = try? values.decode(String.self, forKey: .mapString)
        mediaURL = try? values.decode(String.self, forKey: .mediaURL)
        createdAt =  try? values.decode(String.self, forKey: .createdAt)
        updatedAt = try? values.decode(String.self, forKey: .updatedAt)
       
    }
    
    enum CodingKeys : String, CodingKey {
        case objectId
        case  uniqueKey
        case  firstName
        case  lastName
        case  mapString
        case mediaURL
        case latitude
        case longitude
        case createdAt
        case updatedAt


    }
    
}




extension Date {
   static var  dateFormatter : DateFormatter {
        get{
          return   DateFormatter()
        }
    }
   static func fromISO(from string:String) -> Date?{
   return  dateFormatter.date(from: string)
    }
}
