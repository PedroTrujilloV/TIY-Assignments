//
//  playMode.swift
//  LaberintoLabyrinth
//
//  Created by Pedro Trujillo on 12/6/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import Foundation

class playMode
{
    var id:Int!
    var name:String!
    var mazeSize:Int!
    var numberOfBalls:Int!
    var mazeHightRows:Int!
    var idPlayer:String!
    var maxScoreTime:Int!
    
    init(dataDictionary:NSDictionary)
    {
        id = Int(dataDictionary["id"] as? String ?? "")
        name = dataDictionary["name"] as? String ?? ""
        mazeSize = Int(dataDictionary["mazeSize"] as? String ?? "")
        numberOfBalls = Int(dataDictionary["numberOfBalls"] as? String ?? "")
        mazeHightRows = Int(dataDictionary["mazeHightRows"] as? String ?? "")
        idPlayer = dataDictionary["idPlayer"] as? String ?? ""
        maxScoreTime = Int(dataDictionary["maxScoreTime"] as? String ?? "")
    }
}