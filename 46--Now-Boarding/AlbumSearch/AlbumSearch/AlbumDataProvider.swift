//
//  AlbumDataProvider.swift
//  AlbumSearch
//
//  Created by Pedro Trujillo on 12/8/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation
import UIKit


class AlbumDataProvider: NSObject, AlbumDataProviderProtocol
{
    weak var tableView: UITableView!
    var albums = [Album]()
    var api: APIController!
    var imageCache = [String:UIImage]()
    
    
    override init()
    {
        super.init()
        api = APIController(delegate: self)
        api.searchItunesFor("Beatles")
    }



}




extension AlbumDataProvider: UITableViewDataSource
{
     func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return albums.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("AlbumCell", forIndexPath: indexPath)
        
        let album = albums[indexPath.row]
        cell.textLabel?.text = album.title
        
        return cell
    }
    
    // MARK: - API Controller Protocol
    
    func didReceiveAPIResults(results: NSArray)
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.albums = Album.albumsWithJSON(results)
            self.tableView.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }

}