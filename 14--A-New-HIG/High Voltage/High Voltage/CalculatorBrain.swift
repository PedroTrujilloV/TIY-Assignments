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
//        appendOperation("+",op: (+))
//        appendOperation("-",op: ({$0 - $1}))
//        appendOperation("x",op: (*))
//        appendOperation("/",op: ({$0 / $1}))
//        appendOperation("%",op: ({self.bufferOpDic["x"]!($1,0.01)}) )
//        appendOperation("+/-", op: ({self.bufferOpDic["x"]!($1,-1)}) )
//        appendOperation("", op: ({self.bufferOpDic["x"]!(1,$1)}) )
        
        
        
        //electronic Operations 
        //.............L1 ?! L2 = L3
        appendOperation("VAO",op: ({$0 / $1}))
        appendOperation("VWO",op: ({ pow($0, 2) / $1}))
        appendOperation("WAO",op: ({ $0 / pow($1, 2)}))
        
        appendOperation("AVO",op: ({$1 / $0}))
        appendOperation("WVO",op: ({ pow($1, 2) / $0}))
        appendOperation("AWO",op: ({ $1 / pow($0, 2)}))
        
        
        appendOperation("VOA",op: ({$0 / $1}))
        appendOperation("WVA",op: ({$0 / $1}))
        appendOperation("WOA",op: ({ sqrt( $0 / $1) }))
        
        appendOperation("OVA",op: ({$1 / $0}))
        appendOperation("VWA",op: ({$1 / $0}))
        appendOperation("OWA",op: ({ sqrt( $1 / $0) }))
        
        
        appendOperation("AOV",op: (*))
        appendOperation("WAV",op: ({$0 / $1}))
        appendOperation("WOV",op: ({ sqrt( $0 * $1) }))
        
        appendOperation("OAV",op: (*))
        appendOperation("AWV",op: ({$1 / $0}))
        appendOperation("OWV",op: ({ sqrt( $1 * $0) }))
        
        
        appendOperation("VAW",op: (*))
        appendOperation("VOW",op: ({ pow($0, 2) / $1}))
        appendOperation("AOW",op: ({ pow($0, 2) * $1}))
        
        appendOperation("AVW",op: (*))
        appendOperation("OVW",op: ({ pow($1, 2) / $0}))
        appendOperation("OAW",op: ({ pow($1, 2) * $0}))
        
        
        
        cleanAll()
    }

    
    
    func appendOperation(symbol:String, op:Op)
    {
        bufferOpDic[symbol] = op
    }
    
    func appendValue(value:String)
    {
        let valueD =  (value as NSString).doubleValue//conver string to Double
        
        
        bufferValuesArray.append(valueD)
        bufferCalculations.append(valueD)
        
        print("appendValue:")
        print(bufferValuesArray)
    }
    
    func appendBufferCalculations(operation:String)
    {
        print("appendBufferCalculations:")
        print(operation)
        
        bufferCalculations.append((bufferOpDic[operation]?(bufferValuesArray[bufferValuesArray.count-2], bufferValuesArray[bufferValuesArray.count-1]))!)
      
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
        bufferValuesArray = []
        //bufferCalculations.append(0)
    }
    
    
    


}