//
//  City.swift
//  DudeWhereIsMyCar
//
//  Created by Pedro Trujillo on 11/3/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//


import Foundation
//import CoreLocation // remove all coments if you want store localy with NScoding

// NSCoding Constants
//let kNameKey = "name"
//let kZipCodeKey = "zipCode"
//let kLatitudeKey = "latitude"
//let kLongitudeKey = "longitude"
//let kStateKey = "state"

class City//: NSObject, NSCoding
{
    let name: String
    let zipCode: String
    let latitude: Double
    let longitude: Double
    let state: String
    var subtitle = ""
    
     init(name: String, zip: String, lat: Double, lng: Double, state: String)
    {
        self.name = name
        self.zipCode = zip
        latitude = lat
        longitude = lng
        self.state = state
        
    }
   /*
    // MARK: - NSCoding
    
    required convenience init?(coder aDecoder: NSCoder)
    {
        guard let name = aDecoder.decodeObjectForKey(kNameKey) as? String,
            let zipCode = aDecoder.decodeObjectForKey(kZipCodeKey) as? String
            else { return nil }
        
        self.init(name: name, zip: zipCode, lat: aDecoder.decodeDoubleForKey(kLatitudeKey), lng: aDecoder.decodeDoubleForKey(kLongitudeKey), state: aDecoder.decodeObjectForKey(kStateKey) as? String ?? "" )
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(self.name, forKey: kNameKey)
        aCoder.encodeObject(self.zipCode, forKey: kZipCodeKey)
        aCoder.encodeDouble(self.latitude, forKey: kLatitudeKey)
        aCoder.encodeDouble(self.longitude, forKey: kLongitudeKey)
        aCoder.encodeObject(self.state , forKey: kStateKey)
    }
    */
}