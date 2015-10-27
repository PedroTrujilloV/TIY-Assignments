//
//  ViewController.swift
//  AlbumSearch
//
//  Created by Pedro Trujillo on 10/27/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

protocol APIControllerProtocol
{
    func didReceiveAPIResults(results:NSArray)
}


class AlbumListTableViewController: UITableViewController, APIControllerProtocol
{
    var albums = Array<Album>()
    var api: APIController!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        api = APIController(delegate: self)
        api.searchItunesFor("Beatles")
        tableView.registerClass(UITableViewCell.self, forHeaderFooterViewReuseIdentifier: "AlbumCell")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
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
        return albums.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("AlbumCell", forIndexPath: indexPath)
        
        let album = albums[indexPath.row]
        cell.textLabel?.text = album.title
        return cell
    }
    
    //MARK: API Controller Protocol
    
    func didReceiveAPIResults(results:NSArray)
    {
        albums = Album.albumsWithJSON(results)
        tableView.reloadData()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }


}

