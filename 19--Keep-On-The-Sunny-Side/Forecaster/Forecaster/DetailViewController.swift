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

class DetailViewController: UIViewController
{
    var userImageView:UIImageView!
    var imagePath = "gravatar.png"
    var userImage:UIImage!
    let WeatherLabelEmoji:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 100))
    let TemperatureLabel:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 100))
    let NameLabel:UILabel = UILabel(frame: CGRect(x:0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 100))
    let SummaryLabel:UILabel = UILabel(frame: CGRect(x: 0 , y: 0, width: UIScreen.mainScreen().bounds.width, height: 100))
    
    var mapView: MKMapView = MKMapView(frame: CGRect(x: 0 , y: 0, width: UIScreen.mainScreen().bounds.width, height: 200))
    ///let map: MKMapItem = MKMapItem(
    
    var cityData: CityData!
    var rigthAddButtonItem:UIBarButtonItem!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        //
        title = cityData.name
       self.loadImage(cityData.WeatherWeek[0].icon)
        self.setTemperaturLabel(cityData.WeatherWeek[0].temperature)
        self.setNameLabel(cityData.name)
        self.setSummaryLabel(cityData.WeatherWeek[0].summary)
        self.setMap(cityData)
        
        rigthAddButtonItem = UIBarButtonItem(title: "Next days", style: UIBarButtonItemStyle.Plain, target: self, action: "addButtonActionTapped:")
        self.navigationItem.setRightBarButtonItems([rigthAddButtonItem], animated: true)
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
    func setMap(city:CityData)
    {
        mapView.center.x = view.center.x//UIScreen.mainScreen().bounds.width * (2/3)
        mapView.center.y = UIScreen.mainScreen().bounds.height * 0.8
        
        view.addSubview(mapView)
        
        let LocationCroords = CLLocationCoordinate2DMake( Double(city.latitude)!, Double(city.longitude)!)
        
        let weatherPlace = MKPointAnnotation()
        weatherPlace.coordinate = LocationCroords
        weatherPlace.title = city.name
        weatherPlace.subtitle = city.WeatherWeek[0].temperature+"°F"
    
        let annotations = [weatherPlace]
        mapView.addAnnotations(annotations)
        
        mapView.showAnnotations(annotations, animated: true)
        mapView.camera.altitude *= 2
    }
    
    func setTemperaturLabel(temperature:String = "0")
    {
        
        TemperatureLabel.text = temperature+"°F"
        
        // WeatherLabelEmoji.center.y = (imageView?.center.y)!
        TemperatureLabel.font = UIFont(name: "AvenirNextCondensed-Bold", size: 80)//-Next-Condensed
        TemperatureLabel.textAlignment = .Center
        TemperatureLabel.textColor = UIColor.blackColor()
        
        TemperatureLabel.center.x = UIScreen.mainScreen().bounds.width * (2/3)
        TemperatureLabel.center.y = UIScreen.mainScreen().bounds.height * 0.3
        
        view.addSubview(TemperatureLabel)
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
        
        NameLabel.center.x = view.center.x
        NameLabel.center.y = UIScreen.mainScreen().bounds.height * 0.18
        
        view.addSubview(NameLabel)
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
        
        SummaryLabel.center.x = view.center.x
        SummaryLabel.center.y = UIScreen.mainScreen().bounds.height * 0.45
        
        
        
        view.addSubview(SummaryLabel)
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
                self.userImageView.center.x = UIScreen.mainScreen().bounds.width * (1/4)
                self.userImageView.center.y = UIScreen.mainScreen().bounds.height * 0.3
                
                view.addSubview(userImageView)
            }
        }
        
        //var cosa = "⚡️🌙☀️⛅️☁️💧💦☔️💨❄️🔥🌌⛄️⚠️❗️🌁"
        let dictEmoji:Dictionary = [ "clear-day": "☀️","clear-night": "🌙", "rain":"☔️", "snow":"❄️", "sleet":"💦", "wind":"💨","fog":"🌁", "cloudy":"☁️", "partly-cloudy-day":"⛅️", "partly-cloudy-night":"🌌", "hail":"⛄️", "thunderstorm":"⚡️", "tornado":"⚠️"]
        
        WeatherLabelEmoji.text = dictEmoji[wEmoji]
        
        // WeatherLabelEmoji.center.y = (imageView?.center.y)!
        WeatherLabelEmoji.font = UIFont(name: "HelveticaNeue-Bold", size: 100)
        WeatherLabelEmoji.textAlignment = .Center
        WeatherLabelEmoji.textColor = UIColor.cyanColor()
        
        WeatherLabelEmoji.center.x = UIScreen.mainScreen().bounds.width * (1/4)
        WeatherLabelEmoji.center.y = UIScreen.mainScreen().bounds.height * 0.3

        
       view.addSubview(WeatherLabelEmoji)
        
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
