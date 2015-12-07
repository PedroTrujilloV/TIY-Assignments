//
//  ViewController.swift
//  ModernMeal
//
//  Created by Pedro Trujillo on 12/4/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, NSURLSessionDelegate
{
    
    var request: NSMutableURLRequest!
    var baseUrl = ""//set the url of the site

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInTapped(sender: UIButton)
    {
        let fullURL = "\(baseUrl)/somethingInModernMeal"
        
        request = NSMutableURLRequest(URL: NSURL(string: fullURL)!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 120.0)

        let authorizationString =  "username:password"
        
        
        
//        NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
        
//        NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
//        [request setValue:authValue forHTTPHeaderField:@"Authorization"];
//        
//        //create the task
//        NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//        }];
        
//        if userCanSing()
//        {
//            PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passordTextField.text!, block:
//                {
//                    (user: PFUser?, error: NSError?) -> Void in
//                    
//                    
//                    if user != nil
//                    {
//                        print("login successful!")
//                        print(user?.description)
//                        
//                        //let MapViewSesion = segue.destinationViewController as! MapViewController
//                        //                            MapViewSesion
//                        self.alertMessageLabel.text = ""
//                        self.performSegueWithIdentifier("ShowMapViewControllerSegue", sender: self)
//                        
//                    }
//                    else
//                    {
//                        print("User no registered")
//                        self.alertMessageLabel.textColor = UIColor.redColor()
//                        
//                        self.alertMessageLabel.text = "Sorry, user isn't registered, please create an account."
//                        print("error: "+(error?.localizedDescription)!)
//                    }
//                    
//            })
//        }
    }
   

}

