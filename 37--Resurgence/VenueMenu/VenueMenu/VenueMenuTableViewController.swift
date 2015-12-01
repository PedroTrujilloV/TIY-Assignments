//
//  VenueMenuTableViewController.swift
//  VenueMenu
//
//  Created by Pedro Trujillo on 11/29/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit
import CoreData

protocol SearchTableViewProtocol
{
    func venueWasFound(venues:NSArray)
}


class VenueMenuTableViewController: UITableViewController, SearchTableViewProtocol
{
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    var venuesArray:Array<Venue> = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        let fetchRequest = NSFetchRequest (entityName: "Venue")
        
        do
        {
            let fetchRequestResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? Array<Venue>
            venuesArray = fetchRequestResults!
            print(venuesArray)
            //for venue in venuesArray
            //{
                //let newVenue:Venue = venue as Venue
                //print(newVenue.infoDict)
            //}
        }
            
        catch
        {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return venuesArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        let aVenue:Venue = venuesArray[indexPath.row] as Venue

        let venue:NSDictionary = parseJSONStringToNSDictionary(aVenue.infoDict!)!
        
        //print(venue)
        cell.textLabel?.text = venue["name"] as! NSString as String

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        if segue.identifier == "ShowSearchVenueTableViewControllerSegue"
        {
            let datePickerVC = segue.destinationViewController as! SearchVenueTableViewController
            datePickerVC.delegator = self
        }
    }

    
    //MARK: Protocol functions 

    
    func venueWasFound(venues:NSArray)
    {
        print("======= venue.infoDict: ")
        let newVenue = NSEntityDescription.insertNewObjectForEntityForName("Venue", inManagedObjectContext: managedObjectContext) as! Venue
        let infoVenue = venues[0] as! NSDictionary
        
        
        if let dictionaryString = parseJSONNSDictionaryToString(infoVenue) as? String
        {

            newVenue.infoDict = dictionaryString//infoVenue.description //reference [1]
        
            //print(newVenue.infoDict)
            venuesArray.append(newVenue)
        
        
            saveContext()
        }
        tableView.reloadData()
        //print(venuesArray[venuesArray.count-2].infoDict)

    }

    
    // MARK: Action Handlers
    
    @IBAction func SearchAddVenueButtonTappedAction(sender: UIBarButtonItem)
    {
        print("Hay que rico!")
    }
    
    
    //MARK: Save context
    func saveContext()
    {
        do
        {
            try managedObjectContext.save()
        }
        catch
        {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
    func parseJSONStringToNSDictionary(stringCoreData:String) -> NSDictionary? //reference [2]
    {
        if let data = stringCoreData.dataUsingEncoding(NSUTF8StringEncoding)
        {
            do
            {
               
                let dictionary: NSDictionary! = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
                return dictionary
            }
            catch let error as NSError
            {
                print(error)
                return nil
            }
        }
        else
        {
            return nil
        }
    }
    
    func parseJSONNSDictionaryToString(dict:NSDictionary) -> NSString?
    {
        
        do
        {
            
           let data = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
            
            if let json = NSString(data: data, encoding: NSUTF8StringEncoding)
            {
                return json
            }
            
            return nil
        }
        catch let error as NSError
        {
            print(error)
            return nil
        }
    }
    
    
    

}

///https://api.foursquare.com/v2/venues/search?client_id=OA5RPW0Y4AHZ0EPBIMXRNOSJQGAM0IFCKY11KEBGWIUK4L2A&client_secret=WK3N22CGBLPEM3B5OKELM2JNI4ISXOGAIAAKLVLYZ0QVXP3D&v=20130815&ll=40.7,-74&query=sushi
//reference [1] http://stackoverflow.com/questions/26372198/convert-swift-dictionary-to-string
//reference [2] http://stackoverflow.com/questions/29221586/swift-how-to-convert-string-to-dictionary
//https://api.foursquare.com/v2/venues/40a55d80f964a52020f31ee3
