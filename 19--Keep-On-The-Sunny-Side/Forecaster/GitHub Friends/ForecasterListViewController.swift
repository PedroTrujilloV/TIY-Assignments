//
//  ViewController.swift
//  GitHub Friends
//
//  Created by Pedro Trujillo on 10/27/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

protocol APIControllerProtocol
{
    func didReceiveAPIResults(results:NSArray)
}
protocol SearchTableViewProtocol
{
    func cityWasFound(city:String)
}

class ForecasterListViewController: UITableViewController, APIControllerProtocol,SearchTableViewProtocol
{
    var rigthAddButtonItem:UIBarButtonItem!
    var cities = Array<CityData>()
    var citiesRegistered = Array<String>()
    var api: APIController!
    var friendForSearch = ""

    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        title = "Forecaster ⛅️"
        // Do any additional setup after loading the view, typically from a nib.
        api = APIController(delegate: self)
        //api.searchGitHubFor("jcgohlke")
        //api.searchGitHubFor("Ben Gohlke")
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
        return 50.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("CityCell", forIndexPath: indexPath) as! CityCell
        
        let friend = cities[indexPath.row]
        
        print("friend: "+friend.name)
        cell.textLabel!.text = friend.name
        cell.loadImage(friend.thumbnailImageURL)
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
        print("didReceiveAPIResults got: \(results)")
        
        dispatch_async(dispatch_get_main_queue(), {

            //self.gitHubFriends = GitHubFriend.CitiesDataWithJSON(results)
            self.cities.append( CityData.aCityDataWithJSON(results))
            self.tableView.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    //MARK: - Search View Controller Protocl
    func cityWasFound(cicty:String)
    {
        if !citiesRegistered.contains(cicty)
        {
            citiesRegistered.append(cicty)
            api.searchApiForData(cicty, byCriteria: "user")
            tableView.reloadData()
            print("Friend was found!!!!!!!: "+cicty)
             dismissViewControllerAnimated(true, completion: nil) // this destroy the modal view like the popover
            
        }
        
    }


}

