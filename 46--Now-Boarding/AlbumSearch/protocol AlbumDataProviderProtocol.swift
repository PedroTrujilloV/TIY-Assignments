//
//  protocol AlbumDataProviderProtocol.swift
//  AlbumSearch
//
//  Created by Pedro Trujillo on 12/8/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation
import UIKit


protocol AlbumDataProviderProtocol: UITableViewDataSource, APIControllerProtocol
{
    var albums:[Album] {get}
    var api: APIController! {get}
   // var imageCache: [String:UIImage]{get}
    weak var tableView: UITableView! {get set}
}