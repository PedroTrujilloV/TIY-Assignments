//
//  HTTPController.swift
//  ModernMeal
//
//  Created by Pedro Trujillo on 12/11/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import Foundation
import UIKit

class HTTPController
{
    
    var request: NSMutableURLRequest!
    var baseUrl = "http://mmpro-test.herokuapp.com"//set the url of the site
    var token: Int?
    
    init(user:String, psw:String)
    {
        
        
    }
    
    func singIn()
    {
        //        let fullURL = "http://mmpro-test.herokuapp.com/login"//"\(baseUrl)/login"
        //
        //        request = NSMutableURLRequest(URL: NSURL(string: fullURL)!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 120.0)
        //
        //        let authorizationString =  "leslie.k.brown@gmail.com:awsedrf" // leslie.k.brown@gmail.com:awsedrf
        //
        //
        //        let authorizationData = authorizationString.dataUsingEncoding(NSUTF8StringEncoding)
        //
        //        let authorizationValue: NSString = "Basic \(authorizationData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue:0)))"
        //
        //
        //        request.addValue(authorizationValue as String, forHTTPHeaderField: "Authorization")
        
        
        let fullUrl = "\(baseUrl)/login"
        let request = NSMutableURLRequest(URL: NSURL(string: fullUrl)!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 60.0)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.HTTPMethod = "POST"
        let requestData = [" user": [ "email": "leslie.k.brown@gmail.com", "password": "awsedrf" ] ]//["email": "leslie.k.brown@gmail.com", "password":"awsedrf"] // here I modify the json dict in whit the new information
        
        
        do
        {
            let postData = try NSJSONSerialization.dataWithJSONObject(requestData, options: NSJSONWritingOptions.PrettyPrinted) // here is serialazed the dictionary to json before to send
            request.HTTPBody = postData // here is packed like a http request
            
        }
        catch let error as NSError
        {
            print("data couldn't be parsed: \(error)")
        }
        
        let session = NSURLSession.sharedSession()
        let authentificationTask: NSURLSessionDataTask = session.dataTaskWithRequest(request) // here I send the json file modified
            {
                data, response, error -> Void in
                if error == nil
                {
                    do
                    {
                        let postData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                        self.token = postData["authentication_token"] as? Int
                        print("--- token:")
                        print(self.token)
                        print("--- posData:")
                        print(postData)
                    }
                    catch let error as NSError
                    {
                        print("data couln't be parsed: \(error)")
                    }
                    
                }
        }
        authentificationTask.resume()
        
        print("signInTapped")
        
        
        
        //        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        //        let userPasswordString = "leslie.k.brown@gmail.com:awsedrf"
        //        let userPasswordData = userPasswordString.dataUsingEncoding(NSUTF8StringEncoding)
        //        let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue:0))
        //        let authString = "Basic \(base64EncodedCredential)"
        //        config.HTTPAdditionalHeaders = ["Authorization" : authString]
        //
        //
        //        let session = NSURLSession(configuration: config)
        //        var running = false
        //        let url = NSURL(string: "http://mmpro-test.herokuapp.com/login")
        //        let task = session.dataTaskWithURL(url!)
        //        {
        //            (let data, let response, let error) in
        //            if let httpResponse = response as? NSHTTPURLResponse
        //            {
        //                let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
        //                print("dataString")
        //                print(dataString)
        //            }
        //            running = false
        //        }
        //        
        //        running = true
        //        task.resume()
        //        
        //        while running {
        //            print("waiting...")
        //            sleep(1)
        //        }

    }
}