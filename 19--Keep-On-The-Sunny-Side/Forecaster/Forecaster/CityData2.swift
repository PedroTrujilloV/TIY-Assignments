//
//  CityData2.swift
//  Forecaster
//
//  Created by Pedro Trujillo on 10/31/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//


import Foundation

struct CityData2
{
    let name: String
    let postalCode: String
    let latitude: String
    let longitude: String
    let state:String
    let country:String!
    
    
    
    init(name:String, postalCode:String, latitude:String , longitude: String, state: String, country:String)
    {
        
        self.name = name
        self.postalCode = postalCode
        self.latitude = latitude
        self.longitude = longitude
        self.state = state
        self.country = country
        
    }
    
    static func CitiesDataWithJSON(results: NSArray) ->[CityData2]
    {
        var CitiesData = [CityData2]()
        
        if results.count > 0
        {
            for result in results
            {
                print("hola! fetch fetch!!!!!!!!")
                
                
                let fromatedAddress = result["formatted_address"] as? String ?? ""
                
                let fromatedAddressNoComa = fromatedAddress.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
                
                let arrayFormated =  fromatedAddressNoComa.characters.split(" ")
                
                let cityName = "\(arrayFormated[0])"
                
                let cityZip = "\(arrayFormated[2])"
                
                let geometryDic = result["geometry"] as! NSDictionary
                
                let locationDic = geometryDic["location"] as! NSDictionary
                
                let cityLat = locationDic["lat"] as? String ?? ""
                let cityLon = locationDic["lng"] as? String ?? ""
                
                let cityState = "\(arrayFormated[1])"
                
                let cityCountry = "\(arrayFormated[3])"
                
                CitiesData.append(CityData2(name:cityName, postalCode:cityZip, latitude:cityLat , longitude: cityLon, state: cityState, country: cityCountry))
                
            }
        }
        
        return CitiesData
    }
    
}