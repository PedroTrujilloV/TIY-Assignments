//
//  TasksTableViewController.swift
//  ModernMeal
//
//  Created by Pedro Trujillo on 12/4/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit
import CoreData

protocol APIControllerProtocol
{
    func didReceiveAPIResults(results:NSArray)
    
}
protocol ItemsListControllerProtocol
{
    func didChangeItemsList(results:NSArray)
}

class TasksTableViewController: UITableViewController, APIControllerProtocol, ItemsListControllerProtocol
{
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext // create context manager for coredata
    var api: APIController!

    
    var groceryListsArray: Array<GroceryList> = [] // initialize the main array list
    var groceryListsIDsArray: Array<String> = [] // initialize the id arrays
    
    var groceryListSelected:GroceryList!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        api = APIController(delegate: self)        //create instance of API controller with self
        loadContext() // CoreData, load context information

        //tableView.registerClass(TaskTableViewCell.self, forCellReuseIdentifier: "TaskTableViewCell") //register cell


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        //  return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //  return the number of rows
        return groceryListsArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("TaskTableViewCell", forIndexPath: indexPath) as! TaskTableViewCell

        // Configure the cell...
        
        let aGroceryList:GroceryList = groceryListsArray[indexPath.row] as GroceryList
        
        let groceryList:NSDictionary = api.parseJSONStringToNSDictionary(aGroceryList.groceryListJSON!)!
        
        print(groceryList)
        
        
        if let grocery_list:NSDictionary = groceryList["grocery_list"] as? NSDictionary
        {
            
            cell.textLabel?.text = grocery_list["name"] as! NSString as String
            cell.detailTextLabel?.text = grocery_list["name"] as! NSString as String
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        groceryListSelected = groceryListsArray[indexPath.row] as GroceryList
        self.performSegueWithIdentifier("ShowTabBarControllerSegue", sender: self) //call the segue to navigate at tabBarController

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
        if segue.identifier == "ShowTabBarControllerSegue"
        {
            let tabBarViewController = segue.destinationViewController as! UITabBarController
           // let nav = tabBarViewController.viewControllers![0] as! UINavigationController
           // let destinationViewController = nav.topViewController as! GroceryListTableViewController
            let destinationViewController = tabBarViewController.viewControllers![0] as! GroceryListTableViewController
            
            if let groceryList:NSDictionary = api.parseJSONStringToNSDictionary(groceryListSelected.groceryListJSON!)
            {
                print(groceryList)
                if let grocery_list_items:Array = groceryList["grocery_list_items"] as! NSArray as? Array<NSDictionary>
                {
                    if let grocery_list:NSDictionary = groceryList["grocery_list"] as! NSDictionary
                    {
                        if let grocery_list_Id:Array = grocery_list["grocery_list_item_ids"] as! NSArray as? Array<NSNumber>
                        {
                            if let category_orderString:String = grocery_list["category_order"] as! NSString as String
                            {
                                if let category_order:Array = category_orderString.componentsSeparatedByString(",")
                                {
                                    //Set all values of the next Items tableViewController
                                    destinationViewController.delegator = self
                                    destinationViewController.groceryList = groceryListSelected
                                    destinationViewController.grocery_list_item_ids = grocery_list_Id
                                    destinationViewController.grocery_list_items = grocery_list_items
                                    destinationViewController.category_order = category_order
                                }
                                
                            }
                            
                        }
                    }
                    
                }
            }
        }
    }
    
    
    //MARK: Protocol functions
    
    func didReceiveAPIResults(results:NSArray)
    {
        dispatch_async(dispatch_get_main_queue(),
            {
                
                //self.venuesArray = results as! Array<NSDictionary>
                self.tableView.reloadData()
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    func didChangeItemsList(results:NSArray)
    {
        print("results:")
        print(results)
    }
    
    //MARK: - Tempora Test Grocery List JSON file:
    
    @IBAction func temporalTestFile() //erase this after get the real information from server
    {
        do
        {
            let testFilePath = NSBundle.mainBundle().pathForResource("groceryList", ofType: "json")
            if let testDataFromFile = NSData(contentsOfFile: testFilePath!)
            {
                let groceryListsDict = try NSJSONSerialization.JSONObjectWithData(testDataFromFile, options: []) as! NSDictionary
                
                if let groceryListJSON:NSDictionary = groceryListsDict
                {
                    if let dictionaryString = api.parseJSONNSDictionaryToString(groceryListJSON) as? String
                    {
                        if let grocery_list:NSDictionary = groceryListJSON["grocery_list"] as? NSDictionary
                        {
                            let newGroceryList = NSEntityDescription.insertNewObjectForEntityForName("GroceryList", inManagedObjectContext: managedObjectContext) as! GroceryList
                            
                            if let newID:Int = Int(grocery_list["id"] as! NSNumber) //To store id in array Ids
                            {
                                groceryListsIDsArray.append("\(newID)")
                                newGroceryList.groceryListJSON = dictionaryString
                                groceryListsArray.append(newGroceryList)
                                saveContext()
                            }
                           
                        }
                    }
                }
            }
            
        }
        catch let error as NSError
        {
            print("Error loading file groceryList.json error information: \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    //MARK: - CoreData
    
    //MARK: Load context
    func loadContext()
    {
        let fetchRequest = NSFetchRequest (entityName: "GroceryList")        //fethc the list of task from core data
        
        
        do
        {
            let fetchRequestResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? Array<GroceryList> //conver the result from coredata in array
            groceryListsArray = fetchRequestResults! // To make equal the array coredata to array<gl>
           // print(groceryListsArray)
            for groceryLists in groceryListsArray
            {
                let newGroceryList:GroceryList = groceryLists as GroceryList
                
                let groceryListDict:NSDictionary = api.parseJSONStringToNSDictionary(newGroceryList.groceryListJSON!)! // conver the string from coredata in groceryLists[n] to a dictionary
                if let grocery_list:NSDictionary = groceryListDict["grocery_list"] as? NSDictionary
                {
                    if let newID:Int = Int(grocery_list["id"] as! NSNumber) // store locally the IDs of each gl to use after
                    {
                        groceryListsIDsArray.append("\(newID)")
                    }
                }
                // print(newVenue.infoDict)
            }
            
            //print(groceryListsIDsArray)
        }
            
        catch
        {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
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
    
    



}
