//
//  Item.swift
//  ModernMeal
//
//  Created by Pedro Trujillo on 12/14/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import Foundation

class Item
{
    var id:Int!
    var grocery_list_id:Int!
    var category: String!
    var text: String!
    var recipe_id:String!
    var recipe_name:String!
    var shopped:Bool!
    var item_name:String!
    
    
    init(ItemDict:NSDictionary)
    {
        id = Int(ItemDict["id"] as! NSNumber)
        grocery_list_id = Int(ItemDict["grocery_list_id"] as! NSNumber)
        category = ItemDict["category"] as! NSString as String
        text = ItemDict["text"] as! NSString as String
        
//        recipe_id = nil
//        if let recipeId:Int = Int(ItemDict["recipe_id"] as! NSNumber)
//        {
           recipe_id  = ItemDict["recipe_id"] as? String ?? ""
//        }
        
        
        
        recipe_name = ItemDict["recipe_name"] as! NSString as String
        shopped = ItemDict["shopped"] as! Bool
        item_name = ItemDict["item_name"] as! NSString as String
        
    }
    
    func getTotalNumberOfCharacters() -> Int
    {
        return Int(text.characters.count + recipe_name.characters.count)
    }
    
    func getTotalNumberOfLinesTexTLabel() -> Int
    {
        
        return Int(Int(text.characters.count)/30)
    }
    
    func getTotalNumberOfLinesDetailLabel() -> Int
    {
        return Int(Int(recipe_name.characters.count)/30)
    }
    
    

}