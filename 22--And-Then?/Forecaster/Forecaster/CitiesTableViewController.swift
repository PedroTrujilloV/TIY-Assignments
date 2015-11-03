//
//  CitiesTableViewController.swift
//  Forecaster
//
//  Created by Ben Gohlke on 11/2/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

// NSCoding Constants
let kCitiesKey = "cities"

protocol ZipCodeViewControllerDelegate
{
    func cityWasFound(aCity: City)
//    func weatherWasFoundForCity(aCity: City)
}

class CitiesTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate, ZipCodeViewControllerDelegate
{

    var cities: [City]?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
//        loadCityData()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return cities?.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("CityCell", forIndexPath: indexPath) as! CityCell

        let city = cities![indexPath.row]
        cell.cityNameLabel.text = city.name
        cell.summaryLabel.text = "Clear"
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert
        {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ZipCodePopoverSegue"
        {
            let destVC = segue.destinationViewController as? ZipCodeViewController
            destVC?.delegate = self
            destVC?.popoverPresentationController?.delegate = self
            destVC?.preferredContentSize = CGSizeMake(CGFloat(200.0), CGFloat(120.0))
        }
    }
    
    // MARK: - UIPopoverPresentation delegate
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .None
    }
    
    // MARK: - ZipCodeViewController delegate
    
    func cityWasFound(aCity: City)
    {
        dismissViewControllerAnimated(true, completion: nil)
        if cities == nil
        {
            cities = [City]()
        }
        cities?.append(aCity)
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: cities!.count - 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    // MARK: - Misc.
    
    func loadCityData()
    {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(kCitiesKey) as? NSData
        {
            if let savedCities = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [City]
            {
                cities = savedCities
                tableView.reloadData()
            }
        }
    }
    
    func saveCityData()
    {
        let cityData = NSKeyedArchiver.archivedDataWithRootObject(cities!)
        NSUserDefaults.standardUserDefaults().setObject(cityData, forKey: kCitiesKey)
    }
}
