//
//  TaskListTableViewController.swift
//  InDueTime
//
//  Created by Pedro Trujillo on 10/20/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//
//
//Homework - Time's Up
//
//Return to In Due Time and add CoreData or Realm for persistence of the todo items. Also add local notifications on the date/time the todo item is due. When the user taps on the notification, open the app and flash the background of the cell that corresponds to the notification.
//extension Task {
//@NSManaged var statusTask: Bool
//@NSManaged var titleTask: String?
//@NSManaged var dueDateTask: String?


import UIKit
import CoreData


@objc protocol TimeCircuitsDelegate
{
    func dateWasPicked(datePickerDateString:String)
}



class TaskListTableViewController: UITableViewController, UITextFieldDelegate, TimeCircuitsDelegate
{
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var taskList = Array<Task>()
    
    var temporalDate = ""
    var buttonSelectedIndexPath:NSIndexPath!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Task List!"

        
        
        let fetchRequest = NSFetchRequest (entityName: "Task")
        
        do
        {
            let fetchRequestResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Task]
            taskList = fetchRequestResults!
            //tempList = taskList
            var x = 0
            while  x < taskList.count
            {
                if taskList[x].statusTask == false
                {
                    taskList.removeAtIndex(x)
                  x = 0
                }
                x++
            }
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
        
        cell.titleTaskLabel.text = ""
        //cell.statusTaskSwitch.on =  false
        //cell.setDueDateButton.setTitle("set due time: " + "MM/dd/YY" + " >", forState: UIControlState.Normal)

        // Configure the cell...
        
       let aTask = taskList[indexPath.row]
        
        if aTask.titleTask == nil || aTask.titleTask == ""
        {
            cell.statusTaskSwitch.enabled = false
            cell.setDueDateButton.enabled = false
            cell.statusTaskSwitch.on =  false
            cell.titleTaskLabel.becomeFirstResponder()
        }
        else
        {
            cell.statusTaskSwitch.enabled = true
            cell.setDueDateButton.enabled = true
            cell.titleTaskLabel.text = aTask.titleTask
            cell.statusTaskSwitch.on =  aTask.statusTask
                ///tableView.editing = true editing style!!!!
        }
        
        if aTask.dueDateTask == nil || aTask.dueDateTask == "MM/dd/YY"
        {
            aTask.dueDateTask = "MM/dd/YY"
            cell.setDueDateButton.setTitle("set due time: " + aTask.dueDateTask! + " >", forState: UIControlState.Normal)
        }
        else
        {
            cell.setDueDateButton.setTitle("due time: " + aTask.dueDateTask! + " >", forState: UIControlState.Normal)
            
        }
        

        
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
//        if taskList[indexPath.row].statusTask == false
//        {
        
        if editingStyle == .Delete
        {
            let aTask = taskList[indexPath.row]
            taskList.removeAtIndex(indexPath.row)
            managedObjectContext.deleteObject(aTask)
            saveContext()
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
        
        tableView.reloadData()
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
        tableView.reloadData()
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
        

//            ///tableView.editing = true editing style!!!!
//            cell.editing = true
//            cell.editingStyle
//            //tableView.delete(cell)

            saveContext()

    }
    
    @IBAction func addTask(sender: UIBarButtonItem)
    {
        let newTask = NSEntityDescription.insertNewObjectForEntityForName("Task", inManagedObjectContext: managedObjectContext) as! Task
        
        taskList.append(newTask)
        tableView.reloadData()
    }
    
    @IBAction func setDueDate(sender: UIButton)
    {
        let parentContentView = sender.superview
        let cell = parentContentView?.superview as! TaskCell
        
        let indexPath = tableView.indexPathForCell(cell)
        
        buttonSelectedIndexPath = indexPath // store the indexPath in a temporal variable to know after in which button set the due date
        
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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ShowTimeCircuitsSegue"
        {
            let datePickerVC = segue.destinationViewController as! TimeCircuitsViewController
            datePickerVC.delegate = self
        }
    }
    
    //MARK: - Notifications
    
    func sendNotifications(dateString:String)
    {
        let dateFromater = NSDateFormatter()
        dateFromater.dateFormat = "MMM dd, yyyy"
        let date = dateFromater.dateFromString(dateString)
        
        let localNotification = UILocalNotification()
        localNotification.fireDate = date
        print(localNotification.fireDate)
        
        localNotification.timeZone = NSTimeZone.localTimeZone()
        localNotification.alertTitle = "Hey! Remember "+taskList[buttonSelectedIndexPath.row].titleTask!
        localNotification.alertBody = "Due time for this is \(dateString)"
        localNotification.soundName = UILocalNotificationDefaultSoundName
        
        let uuid = NSUUID()
        let userInfo = ["objectUUID":uuid.UUIDString]
        localNotification.userInfo = userInfo
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
    }
    

    //MARK: - Delegate from table picker view
    
    func dateWasPicked(datePickerDateString:String)
    {
        print("Outa..")
        print(datePickerDateString)
        
       
        taskList[buttonSelectedIndexPath.row].dueDateTask = datePickerDateString
        sendNotifications(datePickerDateString)
        saveContext()
        tableView.reloadData()
      
    }

}
