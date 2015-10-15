//
//  TicketModel.swift
//  LotteryNumber
//
//  Created by Pedro Trujillo on 10/14/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import Foundation

class Ticket
{
    var ArrayNumbers = Array<Int>()
    var winningStatus: Bool!
    var dollarAmount:Int!
    
    init(arrayNumbers:Array<Int>, winningStatus:Bool, dollarAmount:Int )
    {
        self.ArrayNumbers = arrayNumbers
        self.winningStatus = winningStatus
        self.dollarAmount = dollarAmount
    }
    
    func getStringTicketNumbers() ->String
    {
        var stringNumber:String = ""
        
        for num in self.ArrayNumbers
        {
            stringNumber += "\(num) "
        }
        return stringNumber
    }
    
    
}

