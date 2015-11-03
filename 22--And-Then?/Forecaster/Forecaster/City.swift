//
//  City.swift
//  Forecaster
//
//  Created by Ben Gohlke on 11/2/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

// NSCoding Constants
let kNameKey = "name"
let kZipCodeKey = "zipCode"
let kLatitudeKey = "latitude"
let kLongitudeKey = "longitude"

class City: NSObject, NSCoding
{
    let name: String
    let zipCode: String
    let latitude: Double
    let longitude: Double
    
    init(name: String, zip: String, lat: Double, lng: Double)
    {
        self.name = name
        self.zipCode = zip
        latitude = lat
        longitude = lng
    }
    
    // MARK: - NSCoding
    
    required convenience init?(coder aDecoder: NSCoder)
    {
        guard let name = aDecoder.decodeObjectForKey(kNameKey) as? String,
            let zipCode = aDecoder.decodeObjectForKey(kZipCodeKey) as? String
            else { return nil }
        
        self.init(name: name, zip: zipCode, lat: aDecoder.decodeDoubleForKey(kLatitudeKey), lng: aDecoder.decodeDoubleForKey(kLongitudeKey))
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(self.name, forKey: kNameKey)
        aCoder.encodeObject(self.zipCode, forKey: kZipCodeKey)
        aCoder.encodeDouble(self.latitude, forKey: kLatitudeKey)
        aCoder.encodeDouble(self.longitude, forKey: kLongitudeKey)
    }
}