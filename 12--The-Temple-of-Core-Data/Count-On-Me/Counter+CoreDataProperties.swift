//
//  Counter+CoreDataProperties.swift
//  Count-On-Me
//
//  Created by Pedro Trujillo on 10/20/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Counter {

    @NSManaged var count: Int16
    @NSManaged var title: String?

}
