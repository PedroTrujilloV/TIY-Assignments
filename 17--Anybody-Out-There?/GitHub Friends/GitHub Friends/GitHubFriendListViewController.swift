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
protocol SearchViewProtocol
{
    func friendWasFound(friend:String)
}

class GitHubFriendListViewController: UITableViewController, APIControllerProtocol,SearchViewProtocol
{
    var rigthAddButtonItem:UIBarButtonItem!
    var gitHubFriends = Array<GitHubFriend>()
    var api: APIController!
    var friendForSearch = ""

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        api = APIController(delegate: self)
        //api.searchGitHubFor("jcgohlke")
        //api.searchGitHubFor("Ben Gohlke")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        rigthAddButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addButtonActionTapped:")
         self.navigationItem.setRightBarButtonItems([rigthAddButtonItem], animated: true)
        
        self.tableView.registerClass(GitHubFriendCell.self, forCellReuseIdentifier: "GitHubFriendCell")
        
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
        
        let friend = gitHubFriends[indexPath.row]
        
        print("friend: "+friend.name)
        cell.textLabel!.text = friend.name
        cell.loadImage(friend.thumbnailImageURL)
        //cell.detailTextLabel?.text = "Penpenuche"
        return cell
        
    }
    
    //MARK: - Handle Actions
    
    func addButtonActionTapped(sender: UIButton)
    {
        print("Hay que rico!")
        let searchFriendVC = SearchViewController()
        
        navigationController?.pushViewController(searchFriendVC, animated: true)
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
    //MARK: - Search View Controller Protocl
    func friendWasFound(friend:String)
    {
    }


}

