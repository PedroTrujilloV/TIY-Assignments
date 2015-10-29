//
//  SearchTableViewController.swift
//  GitHub Friends
//
//  Created by Pedro Trujillo on 10/28/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController,APIControllerProtocol, UISearchBarDelegate, UISearchDisplayDelegate, UISearchResultsUpdating
{
    
    var gitHubFriends = Array<GitHubFriend>()
    var apiSearch: APIController!
    var delegator:SearchTableViewProtocol!
    var cancelSearch = true
    var filteredTableData = [String]()
    var shouldShowSearchResults = false
    var searchController = UISearchController()


    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        apiSearch = APIController(delegate: self)
        //apiSearch.searchGitHubFor("jcgohlke")
        //apiSearch.searchGitHubFor("Ben Gohlke")
        //apiSearch.searchGitHubFor("Leslie Brown")
        
        
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        
        //self.navigationItem.setRightBarButtonItems([rigthAddButtonItem], animated: true)
        
        self.tableView.registerClass(GitHubFriendCell.self, forCellReuseIdentifier: "GitHubFriendCell")
        
        self.searchController = ({ //http://www.ioscreator.com/tutorials/add-search-table-view-tutorial-ios8-swift
            let controller = UISearchController(searchResultsController: nil)
           controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        // Reload the table
        self.tableView.reloadData()
    }
    
    //MARK: Search bar methods
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        gitHubFriends.removeAll()
        shouldShowSearchResults = false
        tableView.reloadData()
        //dismissViewControllerAnimated(true, completion: nil) // this destroy the modal view like the popover
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            //gitHubFriends.removeAll()
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
       
        //gitHubFriends.removeAll()
        //tableView.reloadData()
        
    }

    
//    func searchBarResultsListButtonClicked(searchBar: UISearchBar) {
//        shouldShowSearchResults = false
//        tableView.reloadData()
//    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        
        // Filter the data array and get only those countries that match the search text.
        apiSearch.searchGitHubFor(searchString!)
        
        print("Hola papy estoy buscando")
        // Reload the tableview.
        tableView.reloadData()
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
        
        return gitHubFriends.count
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("GitHubFriendCell", forIndexPath: indexPath) as! GitHubFriendCell
//        if shouldShowSearchResults
//        {
            let friend = gitHubFriends[indexPath.row]
            
            print("friend: "+friend.name)
            cell.textLabel!.text = friend.name != "" ? friend.name: "User: "+friend.login
            cell.loadImage(friend.thumbnailImageURL)
            //cell.detailTextLabel?.text = "Penpenuche"
//        }
        return cell
    }
    
  
    
    //MARK: - API Controller Protocl
    
    func didReceiveAPIResults(results:NSArray)
    {
        print("didReceiveAPIResults got: \(results)")
        dispatch_async(dispatch_get_main_queue(), {
            
            self.gitHubFriends = GitHubFriend.friendsWithJSON(results)
            self.tableView.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        delegator?.friendWasFound(gitHubFriends[indexPath.row].login)
       
        
        
        print("From didSelectRowAtIndexPath SearchTableView Protocol: "+gitHubFriends[indexPath.row].login)
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

}
