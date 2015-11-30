//
//  ViewController.swift
//  VenuesMenuQuadrat
//
//  Created by Pedro Trujillo on 11/26/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit
import CoreLocation

import QuadratTouch

typealias JSONParameters = [String: AnyObject]

class ViewController: UIViewController, CLLocationManagerDelegate, SessionAuthorizationDelegate
{
    var session : Session!
    var locationManager : CLLocationManager!
    var venueItems : [[String: AnyObject]]?

    override func viewDidLoad()
    {
        super.viewDidLoad()

        session = Session.sharedSession()
        session.logger = ConsoleLogger()
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        if status == .NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == CLAuthorizationStatus.AuthorizedWhenInUse
            || status == CLAuthorizationStatus.AuthorizedAlways {
                locationManager.startUpdatingLocation()
        } else {
            showNoPermissionsAlert()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
//        var parameters = [Parameter.query:"Burgers"]
//        parameters += self.location.parameters()
//        let searchTask = session.venues.search(parameters) {
//            (result) -> Void in
//            if let response = result.response {
//                self.venues = response["venues"] as [JSONParameters]?
//                self.tableView.reloadData()
//            }
//        }
//        searchTask.start()
        print("asdsad")
        exploreVenues()
        print("after")
    }
    
    func exploreVenues()
    {
        guard let location = self.locationManager.location else
        {
            return
        }
        var parameters = [Parameter.query:"Burgers"]
        parameters += location.parameters()
        //let parameters = location.parameters()
        let task = self.session.venues.explore(parameters)
            {
            (result) -> Void in
            if self.venueItems != nil
            {
                return
            }
            if !NSThread.isMainThread()
            {
                fatalError("!!!")
            }
            
            if result.response != nil
            {
                if let groups = result.response!["groups"] as? [[String: AnyObject]]
                {
                    var venues = [[String: AnyObject]]()
                    for group in groups
                    {
                        if let items = group["items"] as? [[String: AnyObject]]
                        {
                            venues += items
                        }
                    }
                    
                    self.venueItems = venues
                    
                    print(self.venueItems)/////
                }
                //self.tableView.reloadData()
            } else if result.error != nil && !result.isCancelled() {
                self.showErrorAlert(result.error!)
            }
        }
        task.start()
    }
    func showNoPermissionsAlert() {
        let alertController = UIAlertController(title: "No permission",
            message: "In order to work, app needs your location", preferredStyle: .Alert)
        let openSettings = UIAlertAction(title: "Open settings", style: .Default, handler: {
            (action) -> Void in
            let URL = NSURL(string: UIApplicationOpenSettingsURLString)
            UIApplication.sharedApplication().openURL(URL!)
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        alertController.addAction(openSettings)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showErrorAlert(error: NSError) {
        let alertController = UIAlertController(title: "Error",
            message:error.localizedDescription, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: {
            (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .Denied || status == .Restricted {
            showNoPermissionsAlert()
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        // Process error.
        // kCLErrorDomain. Not localized.
        showErrorAlert(error)
    }
    
    func locationManager(manager: CLLocationManager,
        didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
            if venueItems == nil {
                exploreVenues()
            }
            //resultsTableViewController.location = newLocation
            locationManager.stopUpdatingLocation()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    

}
extension CLLocation
{
    func parameters() -> Parameters {
        let ll      = "\(self.coordinate.latitude),\(self.coordinate.longitude)"
        let llAcc   = "\(self.horizontalAccuracy)"
        let alt     = "\(self.altitude)"
        let altAcc  = "\(self.verticalAccuracy)"
        let parameters = [
            Parameter.ll:ll,
            Parameter.llAcc:llAcc,
            Parameter.alt:alt,
            Parameter.altAcc:altAcc
        ]
        return parameters
    }
}

