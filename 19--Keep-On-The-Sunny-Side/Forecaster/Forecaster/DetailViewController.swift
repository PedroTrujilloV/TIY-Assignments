//
//  ViewController.swift
//  GitHub Friends
//
//  Created by Pedro Trujillo on 10/29/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation

class DetailViewController: UIViewController,CLLocationManagerDelegate
{
    var widthDevice = UIScreen.mainScreen().bounds.width
    var heightDevice = UIScreen.mainScreen().bounds.height
    
  //  var currentDevice: UIDevice = UIDevice.currentDevice()
    
    
    var superiorView:UIView!
    
    
    var userImageView:UIImageView!
    var imagePath = "gravatar.png"
    var userImage:UIImage!
    let WeatherLabelEmoji:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 100))
    let TemperatureLabel:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 100))
    let NameLabel:UILabel = UILabel(frame: CGRect(x:0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 100))
    let SummaryLabel:UILabel = UILabel(frame: CGRect(x: 0 , y: 0, width: UIScreen.mainScreen().bounds.width, height: 100))

    var mapView: MKMapView!//= MKMapView(frame: CGRect(x: 0 , y: 0, width: UIScreen.mainScreen().bounds.width, height: 200))
    var widthConstrain :NSLayoutConstraint!
    var heighConstrain: NSLayoutConstraint!
    
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()

    
    var cityData: CityData!
    var rigthAddButtonItem:UIBarButtonItem!

    override func viewDidLoad()
    {
        super.viewDidLoad()

    
        
        self.view.backgroundColor = UIColor.whiteColor()
        //
        title = "City"
        
        self.setSuperiorView()
        
       self.loadImage(cityData.WeatherWeek[0].icon)
        self.setTemperaturLabel(cityData.WeatherWeek[0].temperature)
        self.setNameLabel(cityData.name)
        self.setSummaryLabel(cityData.WeatherWeek[0].summary)
        self.setMap(cityData)
        
        rigthAddButtonItem = UIBarButtonItem(title: "Next days", style: UIBarButtonItemStyle.Plain, target: self, action: "addButtonActionTapped:")
        self.navigationItem.setRightBarButtonItems([rigthAddButtonItem], animated: true)
        
    }
    
    //http://stackoverflow.com/questions/25666269/ios8-swift-how-to-detect-orientation-change
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator)
    {
        updateConstraints()
        
    }
    func updateConstraints() //update
    {
        mapView.removeConstraint(widthConstrain)
        mapView.removeConstraint(heighConstrain)
        
        if UIDevice.currentDevice().orientation.isLandscape.boolValue
        {
           
            print("landscape")
            heighConstrain = NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: widthDevice)
            mapView.addConstraint(heighConstrain)
            
            widthConstrain = NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: widthDevice * 0.7)
            mapView.addConstraint(widthConstrain)
            
            
        }
        else
        {
            print("portraight")
            
            widthConstrain = NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: widthDevice)
            mapView.addConstraint(widthConstrain)
            
            
            heighConstrain = NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: widthDevice * 0.7)
            mapView.addConstraint(heighConstrain)
            
            
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSuperiorView()
    {
        
        var superiorXpos = view.center.x
        var superiorYpos = view.center.y
        
        if widthDevice > heightDevice
        {
            let temp = widthDevice
            widthDevice = heightDevice
            heightDevice = temp
            
            superiorXpos = view.center.y
            superiorYpos = view.center.x
        }
       
        superiorView = UIView(frame: CGRect(x: 0 , y: 0, width: widthDevice  , height: widthDevice ))
        //superiorView.backgroundColor = UIColor.blueColor()
        
        superiorView.center.x = superiorXpos
        //superiorView.center.y = UIScreen.mainScreen().bounds.height/2
        
        //http://stackoverflow.com/questions/26180822/swift-adding-constraints-programmatically
        superiorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(superiorView)
        
        
      
        
        let horizontalConstraint = NSLayoutConstraint(item: superiorView , attribute: NSLayoutAttribute.LeadingMargin, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.LeadingMargin, multiplier: 1, constant: -10)
        view.addConstraint(horizontalConstraint)
        
        /*let horizontalConstraint2 = NSLayoutConstraint(item: superiorView, attribute: NSLayoutAttribute.TrailingMargin, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.TrailingMargin, multiplier: 1, constant: 0)
        superiorView(horizontalConstraint2)*/
        
        let topMarginConstraint = NSLayoutConstraint(item: superiorView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 30)
        view.addConstraint(topMarginConstraint)
        
      
        //let verticalConstraint = NSLayoutConstraint(item: superiorView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        //view.addConstraint(verticalConstraint)
        
         let widthConstraint  = NSLayoutConstraint(item: superiorView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: widthDevice)
        superiorView.addConstraint(widthConstraint)
        // view.addConstraint(widthConstraint) // also works
        
        let heightConstraint = NSLayoutConstraint(item: superiorView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: widthDevice)
        superiorView.addConstraint(heightConstraint)
        
        let BottomMarginConstraint = NSLayoutConstraint(item: superiorView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.LessThanOrEqual, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -5)
        view.addConstraint(BottomMarginConstraint)
        
    }
 
    
    func setMap(city:CityData)
    {
        print(UIDevice.currentDevice().orientation)
        
        var superiorXpos = view.center.x
        var superiorYpos = heightDevice * 0.8
        
        if widthDevice > heightDevice
        {
            let temp = widthDevice
            widthDevice = heightDevice
            heightDevice = temp
            
            superiorXpos = UIScreen.mainScreen().bounds.width * 0.8
            superiorYpos = UIScreen.mainScreen().bounds.height/2//heightDevice * 0.8
        }
        
        mapView = MKMapView(frame: CGRect(x: 0 , y: 0, width: widthDevice, height: widthDevice * 0.8))
        
        mapView.center.x = superiorXpos //view.center.x//UIScreen.mainScreen().bounds.width * (2/3)
        mapView.center.y = superiorYpos// UIScreen.mainScreen().bounds.height * 0.8
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        
        let LocationCroords = CLLocationCoordinate2DMake( Double(city.latitude)!, Double(city.longitude)!)
        
        let weatherPlace = MKPointAnnotation()
        weatherPlace.coordinate = LocationCroords
        weatherPlace.title = city.name+", "+city.state
        weatherPlace.subtitle = city.WeatherWeek[0].temperature+"°F"
    
        let annotations = [weatherPlace]
        mapView.addAnnotations(annotations)
        
        mapView.showAnnotations(annotations, animated: true)
        mapView.camera.altitude *= 2
        
        //mapView.translatesAutoresizingMaskIntoConstraints = false
        
        //let horizontalConstraint = NSLayoutConstraint(item: mapView , attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        //view.addConstraint(horizontalConstraint)
        
        let horizontalConstraintRight = NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0)
        view.addConstraint(horizontalConstraintRight)
        
        //let topMarginConstraint = NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: superiorView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        //view.addConstraint(topMarginConstraint)
        
        
        //let verticalConstraint = NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        //view.addConstraint(verticalConstraint)
        
         widthConstrain = NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: widthDevice)
        mapView.addConstraint(widthConstrain)
        // view.addConstraint(widthConstraint) // also works
        
        heighConstrain = NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: widthDevice * 0.7)
         mapView.addConstraint(heighConstrain)
        
        updateConstraints()
        
        let BottomMarginConstraint = NSLayoutConstraint(item: mapView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        view.addConstraint(BottomMarginConstraint)
    }
    
    func setNameLabel(name:String = "0")
    {
        if name.characters.count < 8
        {
            NameLabel.font = UIFont(name: "AvenirNextCondensed-Bold", size: 50)//-Next-Condensed
        }
        else
        {
            NameLabel.font = UIFont(name: "AvenirNextCondensed-Bold", size: 30)//-Next-Condensed
        }
        NameLabel.text = name
        NameLabel.textAlignment = .Center
        NameLabel.textColor = UIColor.blackColor()
        
        NameLabel.center.x = superiorView.center.x
        NameLabel.center.y = superiorView.bounds.height * 0.2
        
        superiorView.addSubview(NameLabel)
    }
    
    func setTemperaturLabel(temperature:String = "0")
    {
        
        TemperatureLabel.text = temperature+"°F"
        
        // WeatherLabelEmoji.center.y = (imageView?.center.y)!
        TemperatureLabel.font = UIFont(name: "AvenirNextCondensed-Bold", size: 80)//-Next-Condensed
        TemperatureLabel.textAlignment = .Center
        TemperatureLabel.textColor = UIColor.blackColor()
        
        TemperatureLabel.center.x = superiorView.bounds.width * (3/4)
        TemperatureLabel.center.y = superiorView.bounds.height * 0.4
        
        superiorView.addSubview(TemperatureLabel)
    }
    
    
    
    
    func setSummaryLabel(summary:String = "0")
    {
        if summary.characters.count < 7
        {
            SummaryLabel.font = UIFont(name: "AvenirNextCondensed-Bold", size: 60)//-Next-Condensed
        }
        else
        {
            SummaryLabel.font = UIFont(name: "AvenirNextCondensed-Bold", size: 40)//-Next-Condensed
        }
        SummaryLabel.text = summary
        SummaryLabel.textAlignment = .Center
        SummaryLabel.textColor = UIColor.grayColor()
        
        SummaryLabel.center.x = superiorView.center.x
        SummaryLabel.center.y = superiorView.bounds.height * 0.6
        
        
        
        superiorView.addSubview(SummaryLabel)
    }
    
    func loadImage(wEmoji:String = "fog",var ImagePath:String = "gravatar.png")
    {
        if ImagePath == ""
        {ImagePath = self.imagePath}
        else
        {self.imagePath = ImagePath}
        
        
        if let url = NSURL(string: ImagePath)
        {
            if let data = NSData(contentsOfURL: url)
            {
                
                self.userImage = UIImage(data: data)
                self.userImageView = UIImageView(image: userImage!)
                self.userImageView!.contentMode = UIViewContentMode.ScaleAspectFit
                self.userImageView.frame = CGRect(x: 0, y: 0 , width: self.view.frame.size.width * 0.5 , height: self.view.frame.size.width * 0.5 )
                self.userImageView.center.x = superiorView.bounds.width * (1/5)
                self.userImageView.center.y = superiorView.bounds.height * 0.4
                
                superiorView.addSubview(userImageView)
            }
        }
        
        //var cosa = "⚡️🌙☀️⛅️☁️💧💦☔️💨❄️🔥🌌⛄️⚠️❗️🌁"
        let dictEmoji:Dictionary = [ "clear-day": "☀️","clear-night": "🌙", "rain":"☔️", "snow":"❄️", "sleet":"💦", "wind":"💨","fog":"🌁", "cloudy":"☁️", "partly-cloudy-day":"⛅️", "partly-cloudy-night":"🌌", "hail":"⛄️", "thunderstorm":"⚡️", "tornado":"⚠️"]
        
        WeatherLabelEmoji.text = dictEmoji[wEmoji]
        
        // WeatherLabelEmoji.center.y = (imageView?.center.y)!
        WeatherLabelEmoji.font = UIFont(name: "HelveticaNeue-Bold", size: 100)
        WeatherLabelEmoji.textAlignment = .Center
        WeatherLabelEmoji.textColor = UIColor.cyanColor()
        
        WeatherLabelEmoji.center.x = superiorView.bounds.width * (1/5)
        WeatherLabelEmoji.center.y = superiorView.bounds.height * 0.4

        
       superiorView.addSubview(WeatherLabelEmoji)
        
    }
    
    //MARK: - Handle Actions
    
    func addButtonActionTapped(sender: UIButton)
    {
        print("Hay que rico!")
        
        //MARK: this piece of code is fucking awesome !!!!
        let searchTableVC = NextSevenDaysTableViewController()
        //let navigationController = UINavigationController(rootViewController: searchTableVC)// THIS is fucking awesome!!!! this create a new navigation controller that  allows the modal view animation !!!!!!!!!!!!!
        
        searchTableVC.cityData = cityData
        
        //searchTableVC.delegator = self // 3 nescessary to get the value from the popover
        //        navigationController?.pushViewController(searchTableVC, animated: true)
        //presentViewController(searchTableVC, animated: true, completion: nil)// it shows like a modal view
        //presentViewController(navigationController, animated: true, completion: nil)
        navigationController?.pushViewController(searchTableVC, animated: true)
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
