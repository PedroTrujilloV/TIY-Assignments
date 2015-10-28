//
//  ViewController.swift
//  MuttCuttsHitsTheRoad
//
//  Created by Pedro Trujillo on 10/28/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController,MKMapViewDelegate
{

    @IBOutlet weak var mapView: MKMapView!
    var anotationsArray = Array<MKPointAnnotation>()
    
    
    var source : MKMapItem!
    var destination: MKMapItem!
    var drivingDistance:CLLocationDistance!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mapView.delegate = self
        
        
        createcityAnnotation("Orlando, Fl")
        createcityAnnotation("Miami, Fl")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createcityAnnotation(city:String)
    {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city)
            { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                if let placemark = placemarks?[0]
                {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = (placemark.location?.coordinate)!
                    annotation.title = city
                    annotation.subtitle = "Destination 🏁"//"init point"
                    self.anotationsArray.append(annotation)
                    self.mapView.addAnnotations(self.anotationsArray)
                    self.showMapAnnotations()
                    print("city: "+city)
                    //self.mapView.addAnnotation(annotation)
                }
        }
    }
    
    func calculateLineOfSightDistance()
    {
       // if anotationsArray.count > 1
        //{
            let cityALocation = CLLocation(coordinate: anotationsArray[anotationsArray.count-2].coordinate, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, timestamp: NSDate())
            let cityBLocation = CLLocation(coordinate: anotationsArray[anotationsArray.count-1].coordinate, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, timestamp: NSDate())
            
            let lineOfSightDistance = cityALocation.distanceFromLocation(cityBLocation)
            
          //  anotationsArray[anotationsArray.count-1].subtitle = "Distance from \(anotationsArray[anotationsArray.count-2].title!): "+String(format: "%.1f", lineOfSightDistance * 0.00062137)+" miles" ///to print only distance no driving
            print("Distance from \(anotationsArray[anotationsArray.count-1].title!) is: "+String(format: "%.2f", lineOfSightDistance * 0.00062137)+" miles")
//        }
    }
    
    func calculateDrivingDistance()
    {
        source = MKMapItem(placemark: MKPlacemark(coordinate: anotationsArray[anotationsArray.count-2].coordinate, addressDictionary: nil))
        destination = MKMapItem(placemark: MKPlacemark(coordinate: anotationsArray[anotationsArray.count-1].coordinate, addressDictionary: nil))
        
        var directionRequest = MKDirectionsRequest()
        
        directionRequest.transportType = MKDirectionsTransportType.Automobile
        
        directionRequest.source = source
        directionRequest.destination = destination
        
        var directions = MKDirections(request: directionRequest)
        
        var routes = []
        
        directions.calculateDirectionsWithCompletionHandler { ( response: MKDirectionsResponse?, error: NSError?) -> Void in
            
            print("error: \(error)")
            //print(response?.routes.first?.distance)
            print("Driving Distance from \(self.anotationsArray[self.anotationsArray.count-1].title!) is: "+String(format: "%.2f", (response?.routes.first?.distance)! * 0.00062137)+" miles")
            self.drivingDistance = response?.routes.first?.distance
            if error == nil
            {
                

                routes = (response?.routes)!
                for route in routes
                {
                    self.mapView.addOverlay((route as! MKRoute).polyline, level: MKOverlayLevel.AboveRoads)
                }
                
            }
             self.anotationsArray[self.anotationsArray.count - 2].subtitle = "Distance to \(self.anotationsArray[self.anotationsArray.count - 1].title!): "+String(format: "%.1f", (self.drivingDistance)! * 0.00062137)+" miles🚗"
        }
        
       
       
        
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer
    {
      
            let polylineRender = MKPolylineRenderer(overlay: overlay)
            polylineRender.strokeColor = UIColor.magentaColor()
            polylineRender.lineWidth = 4.0
            return polylineRender
    
    
    }
    
    func showMapAnnotations()
    {
        if anotationsArray.count > 1
        {
            calculateLineOfSightDistance()
            mapView.camera.altitude *= 2
            mapView.showAnnotations(anotationsArray, animated: true)
            calculateDrivingDistance()
            
            
        }
    }

}

