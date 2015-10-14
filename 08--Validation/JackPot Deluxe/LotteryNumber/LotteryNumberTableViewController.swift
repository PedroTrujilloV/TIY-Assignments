//
//  LotteryNumberTableViewController.swift
//  LotteryNumber
//
//  Created by Pedro Trujillo on 10/13/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit


class LotteryNumberTableViewController: UITableViewController
{
   //@IBOutlet var addNumber:UIButton!
    
    var arrayNumber = Array<Array<Int>>()

    override func viewDidLoad()
    {
        title = "Lotery Numbers"
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
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
        return arrayNumber.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellNumber", forIndexPath: indexPath)

        // Configure the cell...

        let NumberCell = arrayNumber[indexPath.row]
        cell.textLabel?.text = String(NumberCell)
       // cell.detailTextLabel?.text = String(indexPath.row+1)//indexPath.row as! String
        cell.detailTextLabel?.text = "$ \(0)"
        return cell
    }
    


    @IBAction func refreshNumbersTable(sender: UIBarButtonItem)
    {
        cleanTable()
    }
    
    @IBAction func AddRandomNumber(sender: UIBarButtonItem)
    {
        var tempArray = Array<Int>()
        while tempArray.count < 6
        {
            tempArray.append(generateRandomNumber())
        }
        let newIndexPath = NSIndexPath(forRow: arrayNumber.count, inSection: 0)
        arrayNumber.append(tempArray)
        tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Top)
    }
    
    func generateRandomNumber() ->Int
    {
        let randomNumber = arc4random_uniform(53)//http://stackoverflow.com/questions/24119714/swift-random-number
        
        return Int(randomNumber)
    }
    
    func cleanTable()
    {
        while arrayNumber.count > 0
        {
            let newIndexPath = NSIndexPath(forRow: arrayNumber.count-1, inSection: 0)
            arrayNumber.removeFirst()
            tableView.deleteRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
   /* override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert
        {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }*/


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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
