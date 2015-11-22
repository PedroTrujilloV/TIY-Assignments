//
//  Person.swift
//  Friends
//
//  Created by Ben Gohlke on 11/19/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import RealmSwift

class Person: Object
{
    dynamic var name = ""
    dynamic var friendCount = 0
    let friends = List<Person>()
}