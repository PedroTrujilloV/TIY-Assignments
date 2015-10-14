//
//  Agents.swift
//  NOCList
//
//  Created by Pedro Trujillo on 10/12/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import Foundation

class Agent
{
    var realName:String
    var coverNAme:String
    var accessLevel:Int
    
    init(dictionary: NSDictionary)
    {
        self.realName = dictionary["realName"] as! String
        self.coverNAme = dictionary["coverName"] as! String
        self.accessLevel = dictionary["accessLevel"] as! Int
    }
}
