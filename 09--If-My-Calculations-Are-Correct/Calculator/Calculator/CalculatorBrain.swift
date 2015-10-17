//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Pedro Trujillo on 10/15/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import Foundation

public typealias Op = (Double,Double) ->Double//http://stackoverflow.com/questions/28613686/swift-array-of-functions

class CalculatorBrain
{
    var buffer:Double = 0
    var bufferValuesArray = Array<Double>()
    var bufferOpDic = [String: Op]()
    var bufferCalculations:Array = Array<Double>()
    
    
    init()
    {
        appendOperation("+",op: (+))
        appendOperation("-",op: ({$0 - $1}))
        appendOperation("x",op: (*))
        appendOperation("/",op: ({$1 / $0}))
        appendOperation("%",op: ({self.bufferOpDic["x"]!($1,0.01)}) )
        appendOperation("+/-", op: ({self.bufferOpDic["x"]!($1,-1)}) )
        appendOperation("", op: ({self.bufferOpDic["x"]!(1,$1)}) )
        
        cleanAll()
    }

    
    
    func appendOperation(symbol:String, op:Op)
    {
        bufferOpDic[symbol] = op
    }
    
    func appendValue(value:String)
    {
        let valueD =  (value as NSString).doubleValue//conver string to Double
        bufferCalculations.append(valueD)
    }
    
    func appendBufferCalculations(operation:String)
    {
        bufferCalculations.append((bufferOpDic[operation]?(bufferCalculations[bufferCalculations.count-2], bufferCalculations[bufferCalculations.count-1]))!)
    }
    
    
    func calculateValue() -> Double
    {
        return bufferCalculations[bufferCalculations.count-1]
    }
    
    func removeLastCalculations()
    {
        bufferCalculations.removeLast()
    }
    
    func cleanAll()
    {
        bufferCalculations = []
        bufferCalculations.append(0)
    }
    
    
    


}