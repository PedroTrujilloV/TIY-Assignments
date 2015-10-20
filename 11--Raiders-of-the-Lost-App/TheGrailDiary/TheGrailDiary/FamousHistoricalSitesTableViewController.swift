//
//  FamousHistoricalSitesTableViewController.swift
//  TheGrailDiary
//
//  Created by Pedro Trujillo on 10/19/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class FamousHistoricalSitesTableViewController: UITableViewController
{
    var filePath = "sites"
    var formatFile = "json"
    var sitesArray = Array<SiteModel>()
    var siteData: NSArray!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        loadSites()
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
        return siteData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("SiteTableViewCell", forIndexPath: indexPath) as! SiteTableViewCell
        
        // Configure the cell...
        
        
//        let aSite = siteData[indexPath.row] as! NSDictionary
//        cell.name!.text = aSite["name"] as! String
//        cell.country!.text = aSite["country"] as! String
//        cell.photo.image = UIImage(named: aSite["photo"] as! String)
        
        let aSite = sitesArray[indexPath.row]
        cell.setLabelsValues(aSite)
        
        return cell
    }
    
    
    
  

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Load Json File:
    func loadSites()
    {
        do
        {
            let siteFilePath = NSBundle.mainBundle().pathForResource(filePath, ofType: formatFile)
            let siteDataFromFile = NSData(contentsOfFile: siteFilePath!)
            siteData = try NSJSONSerialization.JSONObjectWithData(siteDataFromFile!, options:[]) as! NSArray

            for site in siteData
            {
   
                let newSite = SiteModel(siteDictionary: site as! NSDictionary)

                sitesArray.append(newSite)
            }
            
            sitesArray.sortInPlace({$0.name > $1.name})

            
        }
        catch let error as NSError
        {
            print("Error loading file \(filePath).\(formatFile) error information: \(error)")
        }
    }

}
