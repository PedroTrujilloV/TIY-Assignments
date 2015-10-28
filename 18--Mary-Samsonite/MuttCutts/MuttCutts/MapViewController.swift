//
//  ViewController.swift
//  MuttCutts
//
//  Created by Pedro Trujillo on 10/28/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController
{

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString("Laleland, Fl", completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?)-> Void in
            if let placemark = placemarks?[0]
            {
                let annotation = MKPointAnnotation()
                annotation.coordinate = (placemark.location?.coordinate)!
                annotation.title = "Lakeland, FL"
                self.mapView.addAnnotation(annotation)
            }
        
        })
        
        let geocoder2 = CLGeocoder()
        geocoder2.geocodeAddressString("Miami, Fl", completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?)-> Void in
            if let placemark = placemarks?[0]
            {
                let annotation = MKPointAnnotation()
                annotation.coordinate = (placemark.location?.coordinate)!
                annotation.title = "Miami, FL"
                self.mapView.addAnnotation(annotation)
            }
            
        })
        
        // Do any additional setup after loading the view, typically from a nib.
        let tiyOrlando = CLLocationCoordinate2DMake(28.540923, -81.38216)
        
        let tiyOrlandoAnnotation = MKPointAnnotation()
        tiyOrlandoAnnotation.coordinate = tiyOrlando
        tiyOrlandoAnnotation.title = "The Iron Yard"
        tiyOrlandoAnnotation.subtitle = "Orlando"
        
        
        let tiyTampa = CLLocationCoordinate2DMake(27.770068, -82.63642)
        
        let tiyTampaAnnotation = MKPointAnnotation()
        tiyTampaAnnotation.coordinate = tiyTampa
        tiyTampaAnnotation.title = "The Iron Yard"
        tiyTampaAnnotation.subtitle = "Tampa"
        
        
        let annotations = [tiyOrlandoAnnotation,tiyTampaAnnotation]
        mapView.addAnnotations(annotations)
        
        mapView.showAnnotations(annotations, animated: true)
        mapView.camera.altitude *= 2
        
        //let viewRegion = MKCoordinateRegionMakeWithDistance(tiyOrlando, 2000, 2000)
        //mapView.setRegion(viewRegion, animated: true)
        
        
        let orlandoLocation = CLLocation(coordinate: tiyOrlando, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, timestamp: NSDate())
        let tampaLocation = CLLocation(coordinate: tiyTampa, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, timestamp: NSDate())
        
        let lineOfSightDistance = orlandoLocation.distanceFromLocation(tampaLocation)
        
        print("Distance between \(tiyOrlandoAnnotation.subtitle!) and \(tiyTampaAnnotation.subtitle!): "+String(format: "%.2f", lineOfSightDistance * 0.00062137)+" miles")
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

