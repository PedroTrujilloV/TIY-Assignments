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
    
    
    @IBOutlet var mapView: MKMapView!
    
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
        //loadAnnotationsData()
        
        
    }
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        if PFUser.currentUser() == nil
        {
            print("no currren user logged")
            performSegueWithIdentifier("unwindShowMapViewControllerSegue", sender: self)
            
            
        }
        else
        {
            loadAnnotationsData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
//            print("Driving Distance from \(self.anotationsArray[self.anotationsArray.count-1].title!) is: "+String(format: "%.2f", (response?.routes.first?.distance)! * 0.00062137)+" miles")
            self.drivingDistance = response?.routes.first?.distance
            if error == nil
            {
                
                
                routes = (response?.routes)!
                for route in routes
                {
                    self.mapView.addOverlay((route as! MKRoute).polyline, level: MKOverlayLevel.AboveRoads)
                }
                self.anotationsArray[self.anotationsArray.count - 2].subtitle = "Distance to \(self.anotationsArray[self.anotationsArray.count - 1].title!): "+String(format: "%.1f", (self.drivingDistance)! * 0.00062137)+" miles🚶🏻"
            }
            else
            {
                print("error: "+(error?.localizedDescription)!)
                self.anotationsArray[self.anotationsArray.count - 2].subtitle = "There is no way to go walking..."
            }
            
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
             mapView.camera.altitude *= 2.2
            mapView.showAnnotations(anotationsArray, animated: true)
            //mapView.camera.altitude *= 2
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
        appendAnnotation(city)
        //self.mapView.addAnnotations(self.anotationsArray)
        self.showMapAnnotations()
        navigationController?.dismissViewControllerAnimated(true, completion: nil)// this thing hides the popover
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    //MARK: Store var functions
    
    
    func loadAnnotationsData()
    {
//        if let data = NSUserDefaults.standardUserDefaults().objectForKey(kCitiesArrayKey) as? NSData
//        {
//            if let savedAnnotations = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [City]
//            {
//                CitiesArray = savedAnnotations
//                savedCitiesToMapAnnotations()
//                self.showMapAnnotations()
//                mapView.camera.altitude *= 2
//            }
//        }
        
        let query = PFQuery(className: "cityAnnotationsArray")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.getFirstObjectInBackgroundWithBlock
            {
                (cityAnnotationsArray: PFObject?, error: NSError?) -> Void in
                
                if error != nil
                {
                    print("IT WAS NOT POSIBLE LOAD VALUES FROM DATABASE, PARSE ERROR:")
                    print(error?.localizedDescription)
                }
                else if let cityAnnotationsArray = cityAnnotationsArray
                {
                    
                  self.CitiesArray.removeAll()//be sure that the principal array of city annotations is clean to append the stored cities
                    
                    let savedAnnotations = cityAnnotationsArray["cities_array"] as! NSArray
                    
                    for savedAnnotation in savedAnnotations
                    {
                        if let annotation:NSDictionary = savedAnnotation as? NSDictionary
                        {
                            
                            self.CitiesArray.append(City(name: annotation["name"] as! String,
                                                        zip: annotation["zipCode"] as! String,
                                                        lat: (annotation["lat"]?.doubleValue)!,
                                                        lng: (annotation["lon"]?.doubleValue)!,
                                                        state: annotation["state"] as! String))
                        }
                    }
                    self.savedCitiesToMapAnnotations()
                    self.showMapAnnotations()
                    self.mapView.camera.altitude *= 2
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
        //annotation.coordinate.latitude = city.latitude
        //annotation.coordinate.longitude = city.longitude
        annotation.coordinate = CLLocationCoordinate2DMake(city.latitude, city.longitude)
        annotation.title = city.name+", "+city.state
        annotation.subtitle = "Destination 🚗🏁"//"init point"
        self.anotationsArray.append(annotation)
        print(" test annotations: "+annotation.coordinate.longitude.description)
        mapView.addAnnotations(anotationsArray)// here the error
        

       // self.showMapAnnotations()
    }
    
    func saveAnnotationsData()
    {
        //        let cityData = NSKeyedArchiver.archivedDataWithRootObject(CitiesArray)
        //        NSUserDefaults.standardUserDefaults().setObject(cityData, forKey: kCitiesArrayKey)
        
        
        
        var arrayCitiesPFObject = Array<NSDictionary>()
        
        for city in CitiesArray
        {
            arrayCitiesPFObject.append(["name":city.name, "zipCode":city.zipCode, "lat":city.latitude, "lon":city.longitude, "state":city.state])
            
        }
        
        
        
        let query = PFQuery(className: "cityAnnotationsArray") /// there is one array per user
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)  ////  so here prepare the condicion to search for that array by user
        query.getFirstObjectInBackgroundWithBlock // and here we ask for that unique value per user.
        {
            (cityAnnotationsArray: PFObject?, error: NSError?) -> Void in
            
            if error != nil
            {
                print("IT DIDN,T FIND ANY VALUE IN THE DATABASE TO UPDATE AFTER, PARSE ERROR:")
                print(error?.localizedDescription)
                let cityAnnotationsArrayNEW = PFObject(className: "cityAnnotationsArray")
                
                        cityAnnotationsArrayNEW["username"] = PFUser.currentUser()?.username
                        cityAnnotationsArrayNEW["cities_array"] = arrayCitiesPFObject
                        
                        print("SO..")
                        
                        cityAnnotationsArrayNEW.saveInBackgroundWithBlock
                            {
                                (success: Bool, error: NSError?) -> Void in
                                if success
                                {
                                    print("YAY A  > NEW! < ARRAY WAS SAVED!!!")
                                }
                                else
                                {
                                    print("IT COULDN'T SAVE ANY NEW VALUE IN THE DATABASE")
                                    print(error?.localizedDescription)
                                }
                            }
                    

            }
            else if let cityAnnotationsArray = cityAnnotationsArray
            {
                cityAnnotationsArray["username"] = PFUser.currentUser()?.username
                cityAnnotationsArray["cities_array"] = arrayCitiesPFObject
                
                
                
                cityAnnotationsArray.saveInBackgroundWithBlock
                    {
                        (success: Bool, error: NSError?) -> Void in
                        if success
                        {
                            print("YAY THE ARRAY WAS UPDATED!!!")
                        }
                        else
                        {
                            print("IT COULDN'T UPDATE ANY VALUE IN THE DATABASE")
                            print(error?.localizedDescription)
                        }
                }
            }
            
        }
    }
    
    //MARK: Action Handles
    @IBAction func saveDataButton(sender: UIBarButtonItem)
    {
        saveAnnotationsData()
    }
    
    
    
}

