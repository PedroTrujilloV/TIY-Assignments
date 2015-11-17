//
//  root_main_GlobalTimeTableViewController.swift
//  GlobalTime
//
//  Created by Pedro Trujillo on 11/17/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit
let DEFAULT_CLOCK_SIZE:CGFloat = 100.0

protocol SearchTimeZoneProtocol
{
    func timeZoneWasChosen(timeZone:String)//timeZone:timezone)
}

class root_main_GlobalTimeTableViewController: UITableViewController,SearchTimeZoneProtocol
{
    var timeZonesNamesArray:Array<String>!



    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Global Time"
        timeZonesNamesArray = []
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         //self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addButtonActionTapped:")
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier:"UITableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return timeZonesNamesArray.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return DEFAULT_CLOCK_SIZE+10
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)

        // Configure the cell...
        
        let newClockView = ClockView(frame: CGRect(x: 10.0, y: 10.0, width: DEFAULT_CLOCK_SIZE, height: DEFAULT_CLOCK_SIZE))
        newClockView.timezone = NSTimeZone(name: timeZonesNamesArray[indexPath.row])
        
        cell.imageView?.image = UIImage(named: "gravatar.png")
        
        cell.addSubview(newClockView) //newClockView
        cell.textLabel?.text = timeZonesNamesArray[indexPath.row]
        
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func timeZoneWasChosen(timeZone:String)//timeZone:timezone)
    {
        print(timeZone)
        
        timeZonesNamesArray.append(timeZone)
        
        tableView.reloadData()
        
        
    }
    
//MARK: Action Handlers
    
    func addButtonActionTapped(sender:UIButton)
    {
        print("Hay que rico me clicaste el addButtonActionTapped")
        
        let newGTSearchTVC = SearchGTTableViewController()
        
        let searchNavigationController = UINavigationController(rootViewController: newGTSearchTVC)
        
        newGTSearchTVC.delegator = self
        
        presentViewController(searchNavigationController, animated: true, completion: nil)
        
        
    }

}

//reference [1] :http://stackoverflow.com/questions/25476139/how-do-i-make-an-uiimage-view-with-rounded-corners-cgrect-swift
//        let imageView = UIImageView(frame: CGRectMake(0, 0, 100, 100))
//        imageView.backgroundColor = UIColor.redColor()
//        imageView.layer.cornerRadius = 8.0
//        imageView.clipsToBounds = true

