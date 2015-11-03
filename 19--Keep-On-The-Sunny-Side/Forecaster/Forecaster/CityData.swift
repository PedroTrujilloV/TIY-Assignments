//
//  CityData.swift
//  Forecaster
//
//  Created by Pedro Trujillo on 10/31/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//


import Foundation

let kNameKey = "name"
let kZipCodeKey = "zipCode"
let KLatitudeKey = "latitude"
let KLongitudeKey = "longitude"
let kCountryKey = "country"
let kStateKey = "state"

//struct CityData // NSObject, NSCoding
class CityData: NSObject, NSCoding
{
    let name: String
    let postalCode: String
    let latitude: String
    let longitude: String
    let state:String
    let country:String
    var WeatherWeek = Array<WeatherDay>()
    
    init(name:String, postalCode:String, latitude:String , longitude: String, state: String, country:String)
    {
        
        self.name = name
        self.postalCode = postalCode
        self.latitude = latitude
        self.longitude = longitude
        self.state = state
        self.country = country
        
    }
    
    static func setCityWeather(results: NSArray) ->[WeatherDay]
    {
        //print("results setCityWeather \(results)")
        
        var WeatherWeekly = [WeatherDay]()
        
        if results.count > 0
        {
            
            for result in results
            {
                
                let currently:NSDictionary = result["currently"] as! NSDictionary
              
                
                
                let summary:String = currently["summary"] as? String ?? ""
                
                let icon:String = currently["icon"] as? String ?? ""
                
                let doubleTemperature = (currently["temperature"] as! NSNumber).doubleValue
                
                let temperature =  String(format: "%.0f", doubleTemperature)
                
                let doubleTime = (currently["time"] as! NSNumber).doubleValue
                
                let time =  String(format: "%.0f", doubleTime)
                
                
                WeatherWeekly.append(WeatherDay(summary: summary, icon: icon, temperature: temperature, time:time))
                
                let daily:NSDictionary = result["daily"] as! NSDictionary
                
                
                let data:NSArray = daily["data"] as! NSArray
                
                for value in data
                {
                    
                    //print("Fetching Weather JSON!!")
                    
                    
                    let summary:String = value["summary"] as? String ?? ""
                    
                    let icon:String = value["icon"] as? String ?? ""
                    
                    let doubleTemperature = (value["apparentTemperatureMax"] as! NSNumber).doubleValue

                    let temperature =  String(format: "%.0f", doubleTemperature)
                    
                    let doubleTime = (value["time"] as! NSNumber).doubleValue
                    
                    let time =  String(format: "%.0f", doubleTime)
                    
                    WeatherWeekly.append(WeatherDay(summary: summary, icon: icon, temperature: temperature, time:time))
                }
                
            }
        }
        return  WeatherWeekly
    }
    
    static func CitiesDataWithJSON(results: NSArray) ->[CityData]
    {
        //print("CitiesDataWithJSON")
        var CitiesData = [CityData]()
        
        if results.count > 0
        {
            for result in results
            {
                //print("Fetching Cities Data JSON!!")
                
                var cityZip:String = ""
                var cityState:String = ""
                var cityName:String = ""
                var cityCountry:String = ""
                
                let address_components:NSArray = result["address_components"] as! NSArray
                
                for component in address_components
                {
                    if let typesComponent:NSArray = component["types"] as? NSArray
                    {
                        if typesComponent.containsObject("postal_code")
                        {
                          cityZip = component["long_name"] as? String ?? ""
                        }
                    }
                }
                
                for component in address_components
                {
                    if let typesComponent:NSArray = component["types"] as? NSArray
                    {
                        if typesComponent.containsObject("administrative_area_level_1")
                        {
                            cityState = component["short_name"] as? String ?? ""
                            let cityStateName = component["long_name"] as? String ?? ""
                        }
                    }
                }
                
                for component in address_components
                {
                    if let typesComponent:NSArray = component["types"] as? NSArray
                    {
                        if typesComponent.containsObject("locality")
                        {
                            cityName = component["long_name"] as? String ?? ""
                        }
                    }
                }
                
                for component in address_components
                {
                    if let typesComponent:NSArray = component["types"] as? NSArray
                    {
                        if typesComponent.containsObject("country")
                        {
                            cityCountry = component["long_name"] as? String ?? ""
                        }
                    }
                }
                
                
                //let fromatedAddress = result["formatted_address"] as? String ?? ""
                
                //let fromatedAddressNoComa = fromatedAddress.stringByReplacingOccurrencesOfString(",", withString: " ", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
                
//                let arrayFormated =  fromatedAddressNoComa.characters.split(",")
                
               // let fromatedAddressArray = fromatedAddressNoComa.characters.split(" ")
                
                //let cityName = String(fromatedAddressArray[0]) ?? ""
                
                //let cityCountry = String(fromatedAddressArray[fromatedAddressArray.count-1]) ?? ""
               //////////from here erase//////////
//                var cityState = ""
//                var cityZip = ""
//                
//                if fromatedAddressArray.count > 2
//                {
//                    let arrayFormated = fromatedAddressArray[1].split(" ")
//                    
//                    
//                    if arrayFormated.count == 2
//                    {
//                        cityZip = String(arrayFormated[1]) ?? ""
//                        cityState = String(arrayFormated[0]) ?? ""
//                        
//                    }
//                    else
//                    {
//                        cityState = String(arrayFormated[0]) ?? ""
//                    }
//                }
               /////////////
                
                
                
                let geometryDic:NSDictionary = result["geometry"] as! NSDictionary
                
               // //print("+++++++++++++++++++++++ geometry: \(geometryDic)")
                
                let locationDic:NSDictionary = geometryDic["location"] as! NSDictionary
                
                ////print("+++++++++++++++++++++++ location: \(locationDic)")
                
                let LatDoub = (locationDic["lat"] as! NSNumber).doubleValue

                let cityLat =  String(format: "%f", LatDoub) // Esta hijueputa conversion es nescesaria para poder obtener esos valores del puto google map api JSON
                
                ////print("+++++++++++++++++++++++ latitude : "+(cityLat as String))
                
                let LonDoub = (locationDic["lng"] as! NSNumber).doubleValue
                
                let cityLon =  String(format: "%f", LonDoub) // Esta hijueputa conversion es nescesaria para poder obtener esos valores del puto google map api JSON
                
               // //print("+++++++++++++++++++++++ longitude : "+(cityLon as String))
//
                
                
                CitiesData.append(CityData(name:cityName, postalCode:cityZip, latitude:cityLat as String , longitude: cityLon as String , state: cityState, country: cityCountry ))
                
            }
        }
        
        return CitiesData
    }
    
    required convenience init?(coder aDecoder:NSCoder)
    {
        guard let name = aDecoder.decodeObjectForKey(kNameKey) as? String,
        let zipCode = aDecoder.decodeObjectForKey(kZipCodeKey) as? String
        else
        { return nil}
        
        self.init(name:name, postalCode:zipCode, latitude: (aDecoder.decodeObjectForKey(KLatitudeKey) as? String)!, longitude: (aDecoder.decodeObjectForKey(KLongitudeKey) as? String)!, state: (aDecoder.decodeObjectForKey(kStateKey) as? String)!, country: (aDecoder.decodeObjectForKey(kCountryKey) as? String)!)
        
    }
    
    func encodeWithCoder(aCoder:NSCoder)
    {
        aCoder.encodeObject(self.name, forKey: kNameKey)
        aCoder.encodeObject(self.postalCode, forKey: kZipCodeKey)
        aCoder.encodeObject(self.latitude, forKey: KLatitudeKey)
        aCoder.encodeObject(self.longitude, forKey: KLongitudeKey)
        aCoder.encodeObject(self.country, forKey: kCountryKey)
        aCoder.encodeObject(self.state, forKey: kStateKey)
    }
    
    
    
}