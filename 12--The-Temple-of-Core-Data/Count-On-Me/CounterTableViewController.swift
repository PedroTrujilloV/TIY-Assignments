//
//  CounterTableViewController.swift
//  Count-On-Me
//
//  Created by Pedro Trujillo on 10/20/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit
import CoreData


class CounterTableViewController: UITableViewController, UITextFieldDelegate
{
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var counters  = Array<Counter>()
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Counters"
        let fetchRequest = NSFetchRequest(entityName: "Counter")
        do
        {
            let fetchResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Counter]
            counters = fetchResults!
        }
        catch
        {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }

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

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return counters.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("CounterCell", forIndexPath: indexPath) as! CounterCell

        // Configure the cell...
        
        let aCounter = counters[indexPath.row]
        
        if aCounter.title == nil
        {
            cell.titleTextField.becomeFirstResponder()
        }
        else
        {
            cell.titleTextField.text = aCounter.title
        }
        cell.countLabel.text = "\(aCounter.count)"
        cell.countStepper.value = Double(aCounter.count)

        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {
            let aCounter = counters[indexPath.row]
            counters.removeAtIndex(indexPath.row)
            managedObjectContext.deleteObject(aCounter)
            saveContext()
            
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - UITextField Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        var rc = false
        
        if textField.text != ""
        {
            rc = true
            let contentView = textField.superview
            let cell = contentView?.superview as! CounterCell
            let indexPath = tableView.indexPathForCell(cell)
            let aCounter = counters[indexPath!.row]
            aCounter.title = textField.text
            textField.resignFirstResponder()
            saveContext()
            
        }
        return rc
    }
    
    //MARK: - Action Handlers
    @IBAction func stepperValueChanged(sender: UIStepper)
    {
        let contentView = sender.superview
        let cell = contentView?.superview as! CounterCell
        let indexPath = tableView.indexPathForCell(cell)
        let aCounter = counters[indexPath!.row]
        let countAsInt = Int16(sender.value)
        aCounter.count = countAsInt
        cell.countLabel.text = "\(countAsInt)"
        saveContext()
    }
    
    @IBAction func addCounter(sender: UIBarButtonItem)
    {
       let aCounter = NSEntityDescription.insertNewObjectForEntityForName("Counter", inManagedObjectContext: managedObjectContext) as! Counter
        
        counters.append(aCounter)
        tableView.reloadData()
    }
    
    //MARK: Private
    
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

}
