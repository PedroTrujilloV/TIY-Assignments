//
//  BrickMaze.swift
//  LaberintoLabyrinth
//
//  Created by Pedro Trujillo on 11/22/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class BrickMaze: UIView
{
    
    var ID:Int = 0
    var boundsCenter: CGPoint
    var squareColor = UIColor.cyanColor()
    var borderColor = UIColor.blueColor()//squareColor //should be
    var digitColor = UIColor.blackColor()
    var digitFont: UIFont

    
    override init(frame: CGRect)
    {
        digitFont = UIFont()
        boundsCenter = CGPoint()
        super.init(frame: frame)
        let fontSize = 8.0 + frame.size.width/50.0
        digitFont = UIFont.systemFontOfSize(fontSize)
        boundsCenter = CGPoint(x: bounds.width/2.0, y: bounds.height/2.0)
        self.backgroundColor = UIColor.clearColor()
    }
    
    
    required init?(coder aDecoder: NSCoder)
    {
        digitFont = UIFont()
        boundsCenter = CGPoint()
        super.init(coder: aDecoder)
        let fontSize = 8.0 + frame.size.width/50.0
        digitFont = UIFont.systemFontOfSize(fontSize)
        boundsCenter = CGPoint(x: bounds.width/2.0, y: bounds.height/2.0)
        self.backgroundColor = UIColor.clearColor()
    }
    
    override func drawRect(rect: CGRect)
    {
        // ball body
        let cxt = UIGraphicsGetCurrentContext()
        CGContextAddRect(cxt, rect)
        CGContextSetFillColorWithColor(cxt, squareColor.CGColor)
        CGContextFillPath(cxt)
        
        // clock's border
        CGContextAddRect(cxt, CGRect(x: rect.origin.x + borderWidth/2, y: rect.origin.y + borderWidth/2, width: rect.size.width - borderWidth, height: rect.size.height - borderWidth))
        CGContextSetStrokeColorWithColor(cxt, borderColor.CGColor)
        CGContextSetLineWidth(cxt, borderWidth)
        CGContextStrokePath(cxt)
    }
    
    func setId(Id:Int)
    {
        if Id != 0
        {
            squareColor = UIColor.clearColor()
            borderColor = UIColor.clearColor()//squareColor //should be
        }
        
        ID = Id
    }


}
