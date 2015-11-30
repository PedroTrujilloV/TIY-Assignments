//
//  PopoverAddCityViewController.swift
//  VenueMenu
//
//  Created by Pedro Trujillo on 11/30/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit
import CoreLocation

class PopoverAddCityViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate
{
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var currentUserLocationButton: UIButton!
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    var delegator:PopoverViewControllerProtocol?
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        currentUserLocationButton.enabled = false
        configureLocationManager()
        
        locationTextField.text = ""
        locationTextField.becomeFirstResponder()
        
        
        
        //delegator?.operatorWasChosen(selectedOperation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: - UITextField Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        
        var rc = false
        
        if textField.text != ""
        {
            rc = true
            findLocationForZipCode(textField.text!)
            locationTextField.resignFirstResponder()
            
        }
        
        return rc
    }
    
    func configureLocationManager()
    {
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.Restricted
        {
            if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.Denied
            {
                locationManager.delegate = self
                
                locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined
                {
                    locationManager.requestAlwaysAuthorization()
                }
                else
                {
                    currentUserLocationButton.enabled = true
                }
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse
        {
            currentUserLocationButton.enabled = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print(error.localizedDescription)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        geocoder.reverseGeocodeLocation(location!, completionHandler: {(placemark: [CLPlacemark]?, error: NSError?) -> Void in
            
            if error != nil
            {
                print(error?.localizedDescription)
            }
            else
            {
                self.locationManager.stopUpdatingLocation()
//                let cityName = placemark?[0].locality
//                let zipCode = placemark?[0].postalCode
                self.locationTextField.text = placemark?[0].locality
                let lat = location!.coordinate.latitude
                let lng = location!.coordinate.longitude
//                let stateName = placemark?[0].administrativeArea
                self.delegator!.cityWasChosen(lat.description, long: lng.description)
            }
        })
        
        
    }
    
    //MARK: Action Handlers
    
    @IBAction func userCurrentLocationWasTapped(sender: UIButton)
    {
        locationManager.startUpdatingLocation()
        locationTextField.resignFirstResponder()
    }
    
    func findLocationForZipCode(zipCode: String)
    {
        geocoder.geocodeAddressString(zipCode, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            
            if error != nil
            {
                print(error?.localizedDescription)
            }
            else
            {
                let cityName = placemarks?[0].locality
                let lat = placemarks![0].location?.coordinate.latitude
                let lng = placemarks![0].location?.coordinate.longitude
                let stateName = placemarks?[0].administrativeArea
                self.delegator!.cityWasChosen(lat!.description, long: lng!.description)
            }
        })
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
