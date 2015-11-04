//
//  ViewController.swift
//  DudeWhereIsMyCar
//
//  Created by Pedro Trujillo on 11/3/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//



import UIKit
import MapKit
import CoreLocation

//NSCoding contrains
let kCitiesArrayKey = "CitiesArray"

protocol PopoverViewControllerProtocol
{
    func cityWasChosen(city:City)
}

class MapViewController: UIViewController,MKMapViewDelegate, UIPopoverPresentationControllerDelegate,PopoverViewControllerProtocol
{
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var anotationsArray = Array<MKPointAnnotation>()
    var CitiesArray = Array<City>()
    
    var source : MKMapItem!
    var destination: MKMapItem!
    var drivingDistance:CLLocationDistance!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mapView.delegate = self
        
        
        //        createcityAnnotation("Orlando, Fl")
        //        createcityAnnotation("Miami, Fl")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createcityAnnotation(city:City)
    {
        
        appendAnnotation(city)
        //self.mapView.addAnnotations(self.anotationsArray)
        self.showMapAnnotations()
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
        
        let directionRequest = MKDirectionsRequest()
        
        directionRequest.transportType = MKDirectionsTransportType.Walking
        
        directionRequest.source = source
        directionRequest.destination = destination
        
        let directions = MKDirections(request: directionRequest)
        
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
            self.anotationsArray[self.anotationsArray.count - 2].subtitle = "Distance to \(self.anotationsArray[self.anotationsArray.count - 1].title!): "+String(format: "%.1f", (self.drivingDistance)! * 0.00062137)+" miles🚶🏻"
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
        else
        {
            self.mapView.showAnnotations(anotationsArray, animated: true)
        }
    }
    
    //MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ShowPopoverAddCityViewControllerSegue"
        {
            let destVC  = segue.destinationViewController as! PopoverAddCityViewController // 1
            destVC.popoverPresentationController?.delegate = self // 2
            destVC.delegator = self // 3 nescessary to get the value from the popover
            destVC.preferredContentSize = CGSizeMake(200.0, 65.0)
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    //MARK: -Protocol function
    
    func cityWasChosen(city:City)
    {
        print("City Was Chosen: "+city.name)
        print(" latitudde: " + city.latitude.description)
        print(" longitude: " + city.longitude.description)
        
        CitiesArray.append(city)
        createcityAnnotation(city)
        navigationController?.dismissViewControllerAnimated(true, completion: nil)// this thing hides the popover
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    //MARK: Store var functions
    
    
    func loadAnnotationsData()
    {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(kCitiesArrayKey) as? NSData
        {
            if let savedAnnotations = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [City]
            {
                CitiesArray = savedAnnotations
                savedCitiesToMapAnnotations()
                self.showMapAnnotations()
            }
        }
    }
    
    func savedCitiesToMapAnnotations()
    {
        for city in CitiesArray
        {
            print("Stored: "+city.name)
            appendAnnotation(city)
            
        }
        
    }
    
    func appendAnnotation(city:City)
    {
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = city.latitude
        annotation.coordinate.longitude = city.longitude
        annotation.title = city.name+", "+city.state
        annotation.subtitle = "Destination 🚗🏁"//"init point"
        self.anotationsArray.append(annotation)
        self.mapView.addAnnotations(self.anotationsArray)
        
       // self.showMapAnnotations()
    }
    
    func saveAnnotationsData()
    {
        let cityData = NSKeyedArchiver.archivedDataWithRootObject(CitiesArray)
        NSUserDefaults.standardUserDefaults().setObject(cityData, forKey: kCitiesArrayKey)
    }
    
}

