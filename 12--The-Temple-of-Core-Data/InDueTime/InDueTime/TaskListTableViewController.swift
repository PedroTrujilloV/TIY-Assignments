//
//  TaskListTableViewController.swift
//  InDueTime
//
//  Created by Pedro Trujillo on 10/20/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController, UITextFieldDelegate
{
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var taskList = Array<Task>()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Task List!"

        
        
        let fetchRequest = NSFetchRequest (entityName: "Task")
        
        do
        {
            let fetchRequestResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Task]
            taskList = fetchRequestResults!
        }
        
        catch
        {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
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
        return taskList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell", forIndexPath: indexPath) as! TaskCell

        // Configure the cell...
        
       let aTask = taskList[indexPath.row]
        
        if aTask.titleTask == nil
        {
            cell.titleTaskLabel.becomeFirstResponder()
            cell.statusTaskSwitch.on =  false
            
//            cell.titleTaskLabel.text = " New Task"
//            cell.statusTaskSwitch.on = true // false
//            cell.dueDateTaskLabel.text = "-----" //"due time: 12/05/2015 >"
//            cell.indexTaskLabel.text = "\(indexPath.row)"
        }
        else
        {
             cell.titleTaskLabel.text = aTask.titleTask
            cell.statusTaskSwitch.on =  aTask.statusTask
        }
        
        
        //cell.dueDateTaskLabel.text = "-----" //"due time: 12/05/2015 >"
        cell.indexTaskLabel.text = "\(indexPath.row + 1)"

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {
            let aTask = taskList[indexPath.row]
            taskList.removeAtIndex(indexPath.row)
            managedObjectContext.deleteObject(aTask)
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
            
            let parentContentView = textField.superview
            let cell = parentContentView?.superview as! TaskCell
            let indexPath = tableView.indexPathForCell(cell)
            let aTask = taskList[indexPath!.row]
            aTask.titleTask = textField.text
            textField.resignFirstResponder()
            saveContext()
            
        }
        return rc
    }
    
    //MARK: Actions Handlers
    @IBAction func changeStatus(sender: UISwitch)
    {
        let parentContentView = sender.superview
        let cell = parentContentView?.superview as! TaskCell
        let indexPath = tableView.indexPathForCell(cell)
        let aTask = taskList[indexPath!.row]
        aTask.statusTask = !aTask.statusTask
        saveContext()
    }
    
    @IBAction func addTask(sender: UIBarButtonItem)
    {
        let newTask = NSEntityDescription.insertNewObjectForEntityForName("Task", inManagedObjectContext: managedObjectContext) as! Task
        
        taskList.append(newTask)
        tableView.reloadData()
    }
    
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
