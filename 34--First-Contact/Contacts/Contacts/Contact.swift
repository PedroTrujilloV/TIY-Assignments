//
//  Contact.swift
//  Contacts
//
//  Created by Pedro Trujillo on 11/22/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import Foundation
import RealmSwift

class Contact:Object 
{
    dynamic var name = ""
    dynamic var phone = ""
    dynamic var birthdaty = ""
    dynamic var email = ""
    dynamic var friendCount = 0
    dynamic var familyConunt = 0

    let friends = List<Contact>()
    let family = List<Contact>()
    
    
}
