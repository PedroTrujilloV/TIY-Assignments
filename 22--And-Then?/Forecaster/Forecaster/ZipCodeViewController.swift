//
//  ZipCodeViewController.swift
//  Forecaster
//
//  Created by Ben Gohlke on 11/2/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import CoreLocation

class ZipCodeViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate
{
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    var delegate: ZipCodeViewControllerDelegate?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureLocationManager()
        currentLocationButton.enabled = false
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITextField delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if textField.text != ""
        {
            findLocationForZipCode(textField.text!)
        }
        return true
    }
    
    // MARK: - CLLocation related methods
    
    func configureLocationManager()
    {
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.Denied && CLLocationManager.authorizationStatus() != CLAuthorizationStatus.Restricted
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined
            {
                locationManager.requestWhenInUseAuthorization()
            }
            else
            {
                currentLocationButton.enabled = true
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse
        {
            currentLocationButton.enabled = true
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
                let cityName = placemark?[0].locality
                let zipCode = placemark?[0].postalCode
                self.locationTextField.text = zipCode!
                let lat = location?.coordinate.latitude
                let lng = location?.coordinate.longitude
                let aCity = City(name: cityName!, zip: zipCode!, lat: lat!, lng: lng!)
                self.delegate?.cityWasFound(aCity)
            }
        })
    }
    
    // MARK: - Action Handlers
    
    @IBAction func useLocationTapped(sender: UIButton)
    {
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func searchTapped(sender: UIButton)
    {
        if locationTextField.text != ""
        {
            findLocationForZipCode(locationTextField.text!)
        }
    }
    
    // MARK: - Misc.
    
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
                let lat = placemarks?[0].location?.coordinate.latitude
                let lng = placemarks?[0].location?.coordinate.longitude
                let aCity = City(name: cityName!, zip: zipCode, lat: lat!, lng: lng!)
                self.delegate?.cityWasFound(aCity)
            }
        })
    }
}