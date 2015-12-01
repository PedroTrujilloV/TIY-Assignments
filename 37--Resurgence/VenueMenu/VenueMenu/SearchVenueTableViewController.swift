//
//  SearchVenueTableViewController.swift
//  VenueMenu
//
//  Created by Pedro Trujillo on 11/29/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

protocol APIControllerProtocol
{
    func didReceiveAPIResults(results:NSArray)
    
}
protocol PopoverViewControllerProtocol
{
    func cityWasChosen(lat:String,long:String, name:String)
}

class SearchVenueTableViewController: UITableViewController,APIControllerProtocol,UISearchBarDelegate, UISearchDisplayDelegate, UISearchResultsUpdating,PopoverViewControllerProtocol,UIPopoverPresentationControllerDelegate

{
    var venuesArray:Array<NSDictionary> = []
    var venuesIDsArray: Array<String> = []
    var selectedVenuesArray:Array<NSDictionary> = []
    
    var shouldShowSearchResults = false
    var searchController = UISearchController(searchResultsController: nil)
    
    var locationString:String = ""

    var api: APIController!
    
    var delegator: SearchTableViewProtocol!


    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Set up the prefered"
        self.performSegueWithIdentifier("PopoverAddCityViewControllerSegue", sender: self)


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
   
        
        api = APIController(delegate: self)
        //api.searchApiFoursquareForData("sushi",byCriteria: "ll",location: "28.5542151,-81.34544170000001")
        //api.searchApiFoursquareForData("sushi",byCriteria: "",location: "Orlando, Fl")
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true//false
        searchController.hidesNavigationBarDuringPresentation = false
        //searchController.searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 80)
        //searchController.searchBar.center.y = 200
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = " type venue!"
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        print(selectedVenuesArray)
        delegator.venueWasFound(selectedVenuesArray)
        venuesArray.removeAll()
        selectedVenuesArray.removeAll()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        //searchController.hidesNavigationBarDuringPresentation = true
        dismissViewControllerAnimated(true, completion: nil) // this destroy the modal view like the popover


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

        // Configure the cell...
        
        let venue:NSDictionary = venuesArray[indexPath.row]
        
        if !venuesIDsArray.contains( venue["id"] as! NSString as String)
        {
            cell.textLabel?.text = venue["name"] as! NSString as String
        }

        return cell
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let venue:NSDictionary = venuesArray[indexPath.row]
        
        if !venuesIDsArray.contains( venue["id"] as! NSString as String)
        {
            venuesIDsArray.append(venue["id"] as! NSString as String)
            selectedVenuesArray.append(venue)
        }

    }
    

   //MARK: Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "PopoverAddCityViewControllerSegue"
        {
            let destVC  = segue.destinationViewController as! PopoverAddCityViewController // 1
            destVC.popoverPresentationController?.delegate = self // 2
            destVC.delegator = self // 3 nescessary to get the value from the popover
            destVC.preferredContentSize = CGSizeMake(210.0, 70.0)
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    //MARK: Protocol function
    
    func didReceiveAPIResults(results:NSArray)
    {
        dispatch_async(dispatch_get_main_queue(),
        {
            
            self.venuesArray = results as! Array<NSDictionary>
            self.tableView.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    func cityWasChosen(lat:String,long:String, name:String)
    {
        print(" latitudde: " + lat)
        print(" longitude: " + long)
        
        locationString = lat+","+long
        
        title = name
        
        navigationController?.dismissViewControllerAnimated(true, completion: nil)// this thing hides the popover
        
    }
    
    //MARK: Search bar methods
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar)
    {
        //print("me empieza! usame! soy tuya!")
        shouldShowSearchResults = true
        //gitHubFriends.removeAll()
        tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        //print("no pares!!")
        shouldShowSearchResults = false
        venuesArray.removeAll()
        tableView.reloadData()
        //UIApplication.sharedApplication().networkActivityIndicatorVisible = false

        dismissViewControllerAnimated(true, completion: nil) // this destroy the modal view like the popover
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        if !shouldShowSearchResults
        {
            shouldShowSearchResults = true
            
           // api.searchApiFoursquareForData(searchBar.text!,byCriteria: "ll",location: "28.5542151,-81.34544170000001")
            tableView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        //print("me estas escribiendo")
        shouldShowSearchResults = false
        venuesArray.removeAll()
        tableView.reloadData()
        
    }
    
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar)
    {
        //print("no te demores quiero mas")
        shouldShowSearchResults = true
        venuesArray.removeAll()
        api.searchApiFoursquareForData(searchBar.text!,byCriteria: "ll",location: locationString)
        tableView.reloadData()
    }
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        //print("Hola papy estoy buscando")
        // Reload the tableview.
        tableView.reloadData()
        
    }
    
    
    //MARK: Action Handlers
 
   
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    


}
