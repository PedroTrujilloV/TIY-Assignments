//
//  ViewController.swift
//  GitHub Friends
//
//  Created by Pedro Trujillo on 10/27/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

let KCitiesKey = "cities"

protocol APIControllerProtocol
{
    func didReceiveAPIResults(results:NSArray)
    
}
protocol SearchTableViewProtocol
{
    func cityWasFound(city:CityData)
}

class ForecasterListViewController: UITableViewController, APIControllerProtocol,SearchTableViewProtocol
{
    var rigthAddButtonItem:UIBarButtonItem!
    var cities = Array<CityData>()
    var citiesRegistered = Array<String>()
    var tempCity : CityData!
    var api: APIController!
    var friendForSearch = ""

    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        title = "Forecaster ⛅️"
        // Do any additional setup after loading the view, typically from a nib.
        api = APIController(delegate: self)
        //api.searchApiGoogleForData("12345", byCriteria: "zip")
        //api.searchApiDarkSkyForecastForData("28.5542151", longitude: "-81.34544170000001")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        rigthAddButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addButtonActionTapped:")
         self.navigationItem.setRightBarButtonItems([rigthAddButtonItem], animated: true)
        
        self.tableView.registerClass(CityCell.self, forCellReuseIdentifier: "CityCell")
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return cities.count
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 80.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("CityCell", forIndexPath: indexPath) as! CityCell
        
        let city = cities[indexPath.row]
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        print("friend: "+city.name)
        cell.setNameLabel(city.name)
        //cell.textLabel!.text = city.name//+", "+city.state+" "+city.WeatherWeek[0].summary
        print(city.WeatherWeek[0].summary)
        cell.loadImage(city.WeatherWeek[0].icon)
        cell.setTemperaturLabel(city.WeatherWeek[0].temperature)
        cell.setSummaryLabel(city.WeatherWeek[0].summary)
        //cell.editing = true
        //cell.detailTextLabel?.text = "Penpenuche"
        return cell
    }
    
    
    
//    
//    // Override to support conditional editing of the table view.
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//    // Return false if you do not want the specified item to be editable.
//    return true
//    }
//    
//    
//    
//    // Override to support editing the table view.
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//    if editingStyle == .Delete {
//    // Delete the row from the data source
//    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//    } else if editingStyle == .Insert {
//    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let datailsVC:DetailViewController = DetailViewController()
        datailsVC.cityData = cities[indexPath.row]
        //presentViewController(datailsVC, animated: true, completion: nil)// it shows like a modal view
        navigationController?.pushViewController(datailsVC, animated: true)
    }
    
    //MARK: - Handle Actions
    
    func addButtonActionTapped(sender: UIButton)
    {
        print("Hay que rico!")

        //MARK: this piece of code is fucking awesome !!!!
        let searchTableVC = SearchTableViewController()
        let navigationController = UINavigationController(rootViewController: searchTableVC)// THIS is fucking awesome!!!! this create a new navigation controller that  allows the modal view animation !!!!!!!!!!!!!
        
        searchTableVC.delegator = self // 3 nescessary to get the value from the popover
//        navigationController?.pushViewController(searchTableVC, animated: true)
        //presentViewController(searchTableVC, animated: true, completion: nil)// it shows like a modal view
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
    //MARK: - API Controller Protocl
    
    func didReceiveAPIResults(results:NSArray)
    {
        //
        
        dispatch_async(dispatch_get_main_queue(),
            {
                
                //self.cities[self.cities.count-1].WeatherWeek =  CityData.setCityWeather(results)
                //print("didReceiveAPIResults got: \(results)")
                
                self.tempCity.WeatherWeek = CityData.setCityWeather(results)
                self.cities.append(self.tempCity)

            // WE NEED CREATE HERE AN INSERTION WIHT ALL DATA FROM DARK SKY + DATA FROM GOOGLE'
            self.tableView.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    
    //MARK: - Search View Controller Protocl
    func cityWasFound(city:CityData)
    {
        if !citiesRegistered.contains(city.name+", "+city.state)
        {
            citiesRegistered.append(city.name+", "+city.state)
            
            //self.cities.append(city)
            
            tempCity = city
            
            api.searchApiDarkSkyForecastForData(city.latitude,longitude: city.longitude)
            
            tableView.reloadData()
            //print("Friend was found!!!!!!!: "+city.name)
             dismissViewControllerAnimated(true, completion: nil) // this destroy the modal view like the popover
            
        }
        
    }
    
    //MARK: Save and Load data in phone
    
    func loadCityData()
    {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(KCitiesKey) as? NSData
        {
            if let savedCities = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [CityData]
            {
                cities = savedCities
                tableView.reloadData()
            }
        }
    }
    
    func saveCityData()
    {
        let cityData
         = NSKeyedArchiver.archivedDataWithRootObject(cities)
        NSUserDefaults.standardUserDefaults().setObject(cityData, forKey: KCitiesKey)
    }
    


}

