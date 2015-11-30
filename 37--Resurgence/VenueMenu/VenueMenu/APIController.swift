//
//  APIController.swift
//  VenueMenu
//
//  Created by Pedro Trujillo on 11/29/15.
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
    
    func searchApiFoursquareForData(searchTerm:String = "", byCriteria:String = "", location:String)
    {
        let arrayTerm = location.characters.split(" ")
        
        

        print(">>>>>>>>>>>>>>>>>>arrayTerm: \(arrayTerm.count)")
        
        let foursquareSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        if let escapedSearchTerm = foursquareSearchTerm.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())
        {
            
            //let searchString = cityAndStateArray.joinWithSeparator(", ")
            
            
            let url:NSURL
            
            if byCriteria == "ll"
            {
                let urlRequestByLatAndLong = "https://api.foursquare.com/v2/venues/search?client_id=OA5RPW0Y4AHZ0EPBIMXRNOSJQGAM0IFCKY11KEBGWIUK4L2A&client_secret=WK3N22CGBLPEM3B5OKELM2JNI4ISXOGAIAAKLVLYZ0QVXP3D&v=20130815&ll="+location+"&query="+escapedSearchTerm
                url = NSURL(string: urlRequestByLatAndLong)!
                print("search by ll")
                
            }
            else
            {
                let locationWithoutSpaces = location.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
                
                
                
                let urlRequestByNamePlus = "https://api.foursquare.com/v2/venues/explore?client_id=OA5RPW0Y4AHZ0EPBIMXRNOSJQGAM0IFCKY11KEBGWIUK4L2A&client_secret=WK3N22CGBLPEM3B5OKELM2JNI4ISXOGAIAAKLVLYZ0QVXP3D&v=20130815&near="+locationWithoutSpaces+"&query="+escapedSearchTerm
                url = NSURL(string: urlRequestByNamePlus)!
                print("search by anything")
                
            }
            
            
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
                print("completed Task foursquare ")
                if error != nil
                {
                    print(error!.localizedDescription)
                    
                }
                else
                {
                    if let dictionary = self.parseJSON(data!)
                    {
                        
                            
                        if let response:NSDictionary = dictionary["response"] as? NSDictionary
                        {
                            
                            if byCriteria == "ll"
                            {
                                if let venues:NSArray = response["venues"] as? NSArray
                                {
                                    self.delegator.didReceiveAPIResults(venues)
                                   // print("------------NSArray venues: \(venues)")
                                    
                                }
                            }
                            else
                            {
                                if let groups:NSArray = response["groups"] as? NSArray
                                {
                                    var venuesArray:Array<NSDictionary> = []

                                    for group in groups
                                    {
                                        if let items:NSArray = group["items"] as? NSArray
                                        {
                                            
                                            for item in items
                                            {
                                                if let venue:NSDictionary = item["venue"] as? NSDictionary
                                                {
                                                    venuesArray.append(venue)
                                                    //print("------------NSDictionary venue: \(venue)")
                                                    
                                                }
                                            }
                                            

                                            //print("------------NSArray items: \(items)")
                                        }
                                    }
                                    //print("------------NSArray groups: \(groups)")
                                    
                                    self.delegator.didReceiveAPIResults(venuesArray)

                                }
                            }
                            //print("------------NSDictionary response: \(response)")
    
                        }
                        
                        //print("dictionary parseJSON: \(dictionary)" )
                    }
                    // print("urlRequestByUser: \(url)")
                }
            })
            task.resume()
        }
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