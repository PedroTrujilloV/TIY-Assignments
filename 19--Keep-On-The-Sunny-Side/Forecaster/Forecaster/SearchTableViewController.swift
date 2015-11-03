//
//  SearchTableViewController.swift
//  GitHub Friends
//
//  Created by Pedro Trujillo on 10/28/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, APIControllerProtocol, UISearchBarDelegate, UISearchDisplayDelegate, UISearchResultsUpdating
{
    
    var cities = Array<CityData>()
    var apiSearch: APIController!
    var delegator:SearchTableViewProtocol!
    var cancelSearch = true
    var filteredTableData = [String]()
    var shouldShowSearchResults = false
    var searchController = UISearchController(searchResultsController: nil)


    override func viewDidLoad()
    {
        super.viewDidLoad()
        //definesPresentationContext = true
        //edgesForExtendedLayout = .None
        
        title = "Add City"
        apiSearch = APIController(delegate: self)
        //apiSearch.searchGitHubFor("Leslie Brown")
        
        
        self.tableView.registerClass(CityCell.self, forCellReuseIdentifier: "CityCell")

        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        //searchController.searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 80)
        //searchController.searchBar.center.y = 200
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = " zip code, Name, etc.."
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar

        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        cities.removeAll()
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil) // this destroy the modal view like the popover
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        if !shouldShowSearchResults {
            //print("ahi! me tocaste el boton de buscar")
            //gitHubFriends.removeAll()
            shouldShowSearchResults = true
            
            apiSearch.searchApiGoogleForData( searchBar.text!)
            tableView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        //print("me estas escribiendo")
        shouldShowSearchResults = false
        cities.removeAll()
        tableView.reloadData()
        
    }
    
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar)
    {
        //print("no te demores quiero mas")
        shouldShowSearchResults = true
        cities.removeAll()
        apiSearch.searchApiGoogleForData(searchBar.text!)
        tableView.reloadData()
    }
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
            //print("Hola papy estoy buscando")
            // Reload the tableview.
            tableView.reloadData()

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

            let city = cities[indexPath.row]
            
            //print("city: "+city.name)
            cell.textLabel!.text = city.name+", "+city.state+", "+city.country
            //cell.loadImage(friend.thumbnailImageURL)
            cell.detailTextLabel?.text = "Penpenuche"
     
        
        return cell
    }
    
    
  
    
    //MARK: - API Controller Protocl
    
    func didReceiveAPIResults(results:NSArray)
    {
        ////print("didReceiveAPIResults got: \(results)")
        dispatch_async(dispatch_get_main_queue(), {
            
            self.cities = CityData.CitiesDataWithJSON(results)
            self.tableView.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
   
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
      
        
        //apiSearch.searchApiDarkSkyForecastForData(cities[indexPath.row].latitude,longitude: cities[indexPath.row].longitude)
        
       
        delegator?.cityWasFound(cities[indexPath.row])
       
        ////print("From didSelectRowAtIndexPath SearchTableView Protocol: "+cities[indexPath.row].name)
        
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

    
    // MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
