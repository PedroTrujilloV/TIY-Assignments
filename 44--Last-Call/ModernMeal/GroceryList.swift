//
//  GroceryList.swift
//  ModernMeal
//
//  Created by Pedro Trujillo on 12/14/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import Foundation
import CoreData

class GroceryList: NSManagedObject
{

//MARK - Atributes
    
    var id:Int!
    var updated_at:NSString!
    
    
    
    
//MARK - Getters
    
    func getGroceryListJSONAsNSDictionary() -> NSDictionary?
    {
        if let groceryListDict:NSDictionary = api.parseJSONStringToNSDictionary(self.groceryListJSON!)!
        {
                return groceryListDict
        }
        return nil
    }
    
    func get_grocery_list() -> NSDictionary?
    {
        if let groceryListDict:NSDictionary = getGroceryListJSONAsNSDictionary()
        {
            if let grocery_list:NSDictionary = groceryListDict["grocery_list"] as? NSDictionary
            {
                return grocery_list
            }
        }
        return nil
    }
    
    func get_created_at() -> NSString?
    {
        if let gLDic = get_grocery_list()
        {
            if let created_at:NSString = gLDic["created_at"] as? NSString
            {
                return created_at
            }
        }
        return nil
    }
    
    func get_updated_at() -> NSString?
    {
        if let gLDic = get_grocery_list()
        {
            if let updated_at_string:NSString = gLDic["updated_at"] as? NSString
            {
                return updated_at_string
            }
        }
        return nil
    }
    
    func get_id() -> Int?
    {
        if let gLDic = get_grocery_list()
        {
            if let id_int:Int =  Int(gLDic["id"] as! NSNumber)
            {
                return id_int
            }
        }
        return nil
    }
    
//MARK - Setters
    
    func setModelAtributes()
    {
        updated_at = get_updated_at()
        id = get_id()
    }
    
    
    
}
