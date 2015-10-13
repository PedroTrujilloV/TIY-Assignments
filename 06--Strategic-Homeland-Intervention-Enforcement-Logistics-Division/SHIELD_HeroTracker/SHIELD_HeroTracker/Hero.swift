//
//  Hero.swift
//  SHIELD_HeroTracker
//
//  Created by Pedro Trujillo on 10/12/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import Foundation

class Hero
{
    var name:String
    var homeworld:String
    var powers: String
    var imagePath:String
    //var powers:Array<NSString>()
    
    
    init(heroDictionary:NSDictionary)
    {
        self.name = heroDictionary["name"] as! String
        self.homeworld = heroDictionary["homeworld"] as! String
        self.powers = heroDictionary["powers"] as! String
        self.imagePath = ""//heroDictionary["imagePath"] as! String
        
        //self.powers = (heroDictionary["powers"] as! NSString).split(",")
        
    }

    
}