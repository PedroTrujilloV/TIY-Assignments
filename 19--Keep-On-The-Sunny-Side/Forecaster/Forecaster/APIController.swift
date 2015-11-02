//
//  APIController2.swift
//  Forecaster
//
//  Created by Pedro Trujillo on 10/30/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import Foundation

class APIController
{
    var delegator: APIControllerProtocol
    
    init(delegate:APIControllerProtocol)
    {
        self.delegator = delegate
    }
    
    func searchApiGoogleForData(searchTerm:String, var byCriteria:String = "")
    {
        let arrayTerm = searchTerm.characters.split(" ")
        
        if arrayTerm.count == 1
        {
            let alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
            for char in searchTerm.characters
            {
                if alphabet.characters.contains(char)
                {
                    byCriteria = ""
                    break
                }
                else
                {
                    byCriteria = "zip"
                }
            }
        }
        
        print(">>>>>>>>>>>>>>>>>>arrayTerm: \(arrayTerm.count)")
        let gitHubSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: " ", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        if let escapedSearchTerm = gitHubSearchTerm.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())
        {
            
            //let searchString = cityAndStateArray.joinWithSeparator(", ")
            
            
            let url:NSURL
            
            if byCriteria == "zip"
            {
                let urlRequestByPostalCode = "https://maps.googleapis.com/maps/api/geocode/json?components=postal_code:"+escapedSearchTerm+"&sensor=false"
                url = NSURL(string: urlRequestByPostalCode)!
                print("search by zip")
            }
            else
            {
                let urlRequestByNamePlus = "https://maps.googleapis.com/maps/api/geocode/json?components=locality:"+escapedSearchTerm+"&sensor=false"
                url = NSURL(string: urlRequestByNamePlus)!
                print("search by anything")
           
            }
            
            
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
                print("completed Task Google ")
                if error != nil
                {
                    print(error!.localizedDescription)
                    
                }
                else
                {
                    if let dictionary = self.parseJSON(data!)
                    {
                        let status = dictionary["status"] as! String
                        
                        if status == "OK"
                        {
                            
                            if let results:NSArray = dictionary["results"] as? NSArray
                            {
                                
                                //print("------------Array results: \(results)")
                                self.delegator.didReceiveAPIResults(results)
                                
                            }
                        }

//print("dictionary: \(dictionary)" )
                    }
                    // print("urlRequestByUser: \(url)")
                }
            })
            task.resume()
        }
    }
    
    
    
    
    
    func searchApiDarkSkyForecastForData(latitude:String, longitude:String )
    {
        
        
        print(">>>>  search Api Dark Sky Forecast For Data latitude and longitude <<<<< latitude"+latitude+" longitude: "+longitude)
        
     
            let urlRequest = "https://api.forecast.io/forecast/fe4146e551909b128077fea41731cbd2/"+latitude+","+longitude
            let url = NSURL(string: urlRequest)!

            let session = NSURLSession.sharedSession()
        
            let task = session.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
                print("completed Task Dark Sky")
                if error != nil
                {
                    print(error!.localizedDescription)
                    
                }
                else
                {
                    
                    if let dictionary = self.parseJSON(data!)
                    {
                        if let results:NSArray = [dictionary]
                        {
                        
                            self.delegator.didReceiveAPIResults(results)
                            //print("=======   dictionary: \(dictionary)" )
                            
                        }
                    }
                }
            })
            task.resume()
        
    }

    
    func parseJSON(data:NSData) -> NSDictionary?
    {
        do
        {
            let dictionary: NSDictionary! = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
            return dictionary
        }
        catch let error as NSError
        {
            print(error)
            return nil
        }
        
    }
}