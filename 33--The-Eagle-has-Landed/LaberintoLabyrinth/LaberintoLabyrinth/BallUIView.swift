//
//  BallUIView.swift
//  LaberintoLabyrinth
//
//  Created by Pedro Trujillo on 11/18/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit


let borderWidth: CGFloat = 2
let borderAlpha: CGFloat = 1.0
let graduationOffset: CGFloat = 10
let radius: CGFloat = 5.0
let digitOffset: CGFloat = 10

class BallUIView: UIView
{
    var ID:Int = 0
    var boundsCenter: CGPoint
    var ballBgColor = UIColor.orangeColor()
    var borderColor = UIColor.redColor()
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
        CGContextAddEllipseInRect(cxt, rect)
        CGContextSetFillColorWithColor(cxt, ballBgColor.CGColor)
        CGContextFillPath(cxt)
        
        // clock's border
        CGContextAddEllipseInRect(cxt, CGRect(x: rect.origin.x + borderWidth/2, y: rect.origin.y + borderWidth/2, width: rect.size.width - borderWidth, height: rect.size.height - borderWidth))
        CGContextSetStrokeColorWithColor(cxt, borderColor.CGColor)
        CGContextSetLineWidth(cxt, borderWidth)
        CGContextStrokePath(cxt)
        
        

        
        drawLineGuide()///this is a test line to check rotation
    }
    
    func drawLineGuide()
    {
        let cxt = UIGraphicsGetCurrentContext()

        let lineGuide = CGPoint(x: bounds.width, y: bounds.height/2.0)
        CGContextSetStrokeColorWithColor(cxt, UIColor.blackColor().CGColor)
        CGContextBeginPath(cxt)
        CGContextMoveToPoint(cxt, boundsCenter.x, boundsCenter.y)
        CGContextSetLineWidth(cxt, 1.0)
        CGContextAddLineToPoint(cxt, lineGuide.x, lineGuide.y)
        CGContextStrokePath(cxt)
    }


}
