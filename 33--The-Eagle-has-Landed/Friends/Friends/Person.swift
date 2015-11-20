//
//  Person.swift
//  Friends
//
//  Created by Pedro Trujillo on 11/19/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import Foundation
import RealmSwift

class Person: Object // to work with Realm
{
    dynamic var name = ""
    dynamic var friendCount = 0
    
    let friends = List<Person>()//class of Realm to manage relationships one - one, one many ...
}