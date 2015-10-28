//
//  APIController.swift
//  GitHub Friends
//
//  Created by Pedro Trujillo on 10/27/15.
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
    
    func searchGitHubFor(searchTerm:String)
    {
        let gitHubSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: " ", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        if let escapedSearchTerm = gitHubSearchTerm.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())
        {
            
            
           // var name = "pedro"+"trujillo"
            //let urlRequestByFullName = "https://api.github.com/search/users?q="+escapedSearchTerm+"+in:fullname"
            //let url = NSURL(string: urlRequestByFullName)
            //let urlRequestByLogin = "https://api.github.com/search/users?q="+escapedSearchTerm+"+in:login"
            let urlRequestByUser =  "https://api.github.com/users/" + escapedSearchTerm
            let url = NSURL(string: urlRequestByUser)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url!, completionHandler: { data, response, error -> Void in
                print("completed Task")
                if error != nil
                {
                    print(error!.localizedDescription)
                    
                }
                else
                {
                    if let dictionary = self.parseJSON(data!)
                    {
                       //if let results:NSArray =  dictionary["items"] as? NSArray // for urlRequestByFullName or urlRequestByLogin limit data but many results
                        if let results:NSArray = [dictionary] //for urlRequestByUser complete user data
                        {
                            print("------------results: \(results)")
                            self.delegator.didReceiveAPIResults(results)
                        }
                        print("dictionary: \(dictionary)" )
                    }
                    print("urlRequestByUser: \(url)")
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