//
//  SiteModel.swift
//  TheGrailDiary
//
//  Created by Pedro Trujillo on 10/19/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import Foundation

class SiteModel
{
    var name:String
    var country:String
    var descriptions: String
    var photo:String
    
    init(siteDictionary:NSDictionary)
    {
                self.name = siteDictionary["name"] as! String
                self.country = siteDictionary["country"] as! String
                self.descriptions = siteDictionary["descriptions"] as! String
                self.photo = siteDictionary["photo"] as! String
    }
    
    func getName()-> String
    {
        return self.name
    }
    func getCountry()-> String
    {
        return self.country
    }
    func getDescriptions()-> String
    {
        return self.descriptions
    }
    func getPhotoPath()-> String
    {
        return self.photo
    }
    
}