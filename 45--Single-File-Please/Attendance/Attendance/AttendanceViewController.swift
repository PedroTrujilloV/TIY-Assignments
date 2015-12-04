//
//  ViewController.swift
//  Attendance
//
//  Created by Ben Gohlke on 11/30/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class AttendanceViewController: UIViewController, ESTBeaconManagerDelegate, NSURLSessionDelegate
{

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var gitHubUserTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var beaconInfoLabel: UILabel!
    
    let beaconManager = ESTBeaconManager()
    let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, major: 41906, minor: 7514, identifier: "Gemini classroom")
    let baseUrl = "http://tiybeacon.herokuapp.com"
    var session: NSURLSession!
    var token: Int?
    var signedIn = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        beaconManager.delegate = self
        beaconManager.requestAlwaysAuthorization()
        session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: nil)
        greetingLabel.text = ""
        beaconInfoLabel.text = ""
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        beaconManager.stopRangingBeaconsInRegion(beaconRegion)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion)
    {
        if beacons.count > 0
        {
            let nearestBeacon = beacons.first! as CLBeacon
            let distance: String
            switch nearestBeacon.proximity
            {
            case .Immediate:
                distance = "immediate (<1m)"
            case .Near:
                distance = "near (<3m)"
            case .Far:
                distance = "far (>3m)"
            case .Unknown:
                distance = "very weak signal"
            }
            beaconInfoLabel.text = "Beacon distance: " + distance
            if nearestBeacon.proximity == CLProximity.Immediate && !signedIn
            {
                let request = NSMutableURLRequest(URL: NSURL(string: baseUrl+"/attendances")! , cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 60.0)
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                request.HTTPMethod = "POST"
                let mapData = ["user_id": token!]
                do
                {
                    let postData = try NSJSONSerialization.dataWithJSONObject(mapData, options: NSJSONWritingOptions.PrettyPrinted)
                    request.HTTPBody = postData
                }
                catch let error as NSError
                {
                    print("data couldn't be parsed: \(error)")
                }
                let postDataTask = session.dataTaskWithRequest(request) {
                    data, response, error -> Void in
                    if error == nil
                    {
                        print("\(response)")
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateStyle = .NoStyle
                        dateFormatter.timeStyle = .ShortStyle
                        let dateString = dateFormatter.stringFromDate(NSDate())
                        self.greetingLabel.text = "You are present for Fall iOS at \(dateString)."
                        self.signedIn = true
                    }
                }
                postDataTask.resume()
            }
        }
    }
    
    @IBAction func registerUser(sender: UIButton)
    {
        nameTextField.resignFirstResponder()
        gitHubUserTextField.resignFirstResponder()
        
        nameTextField.enabled = false
        gitHubUserTextField.enabled = false
        registerButton.enabled = false
        resetButton.enabled = true
        
        if token == nil
        {
            let fullUrl = "\(baseUrl)/users"
            let request = NSMutableURLRequest(URL: NSURL(string: fullUrl)!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 60.0)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.HTTPMethod = "POST"
            let mapData = ["name": "Ben", "github": "jcgohlke"]
            do
            {
                let postData = try NSJSONSerialization.dataWithJSONObject(mapData, options: NSJSONWritingOptions.PrettyPrinted)
                request.HTTPBody = postData
            }
            catch let error as NSError
            {
                print("data couldn't be parsed: \(error)")
            }
            let postDataTask = session.dataTaskWithRequest(request) {
                data, response, error -> Void in
                if error == nil
                {
                    print("\(data)")
                    do
                    {
                        let postData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                        self.token = postData["user_id"] as? Int
                    }
                    catch let error as NSError
                    {
                        print("data couldn't be parsed: \(error)")
                    }
                    //self.nameTextField.enabled = false
                    //self.gitHubUserTextField.enabled = false
                    //self.registerButton.enabled = false
                    self.beaconManager.startRangingBeaconsInRegion(self.beaconRegion)
                }
            }
            postDataTask.resume()
        }
        else
        {
            beaconManager.startRangingBeaconsInRegion(beaconRegion)
        }
    }
    
    @IBAction func resetBeaconRanging(sender: UIButton)
    {
        nameTextField.enabled = true
        gitHubUserTextField.enabled = true
        registerButton.enabled = true
        resetButton.enabled = false
        beaconInfoLabel.text = ""
        greetingLabel.text = ""
        
        beaconManager.stopRangingBeaconsInRegion(beaconRegion)
    }
}