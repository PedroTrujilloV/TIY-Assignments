//
//  ClockView.swift
//  ClockTower
//
//  Created by Pedro Trujillo on 11/17/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

let borderWidth: CGFloat = 2
let borderAlpha: CGFloat = 1.0
let digitOffset: CGFloat = 10.0//remember changer

//@IBDesignable
class ClockView: UIView
{
    
    var animantionTimer: CADisplayLink?
    
    var timezone:NSTimeZone?
    {
        didSet
        {
            animantionTimer = CADisplayLink(target: self, selector: "timerFired:")
            animantionTimer!.frameInterval = 8
            animantionTimer!.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        }
    }
    
    var time:NSDate?
    var seconds: Int = 0
    var minutes: Int = 0
    var hours: Int = 0
    
    
    var boundsCenter: CGPoint
    var clockBgColor = UIColor.blackColor()
    var borderColor = UIColor.whiteColor()
    var digitColor = UIColor.whiteColor()
    
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
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        //clock face
        let cxt = UIGraphicsGetCurrentContext()
        CGContextAddEllipseInRect(cxt, rect)
        CGContextSetFillColorWithColor(cxt, clockBgColor.CGColor)
        CGContextFillPath(cxt)
        
        //clock's center
        var radius: CGFloat = 6.0
        let center2 = CGRect(x: boundsCenter.x - radius, y: boundsCenter.y - radius, width: radius * 2, height: radius * 2)
        CGContextAddEllipseInRect(cxt, center2)
        
        CGContextSetFillColorWithColor(cxt, digitColor.CGColor)
        CGContextFillPath(cxt)
        
        
        //clock's boder
        CGContextAddEllipseInRect(cxt, CGRect(x: rect.origin.x + borderWidth/2, y: rect.origin.y + borderWidth/2 , width: rect.size.width - borderWidth , height: rect.size.height - borderWidth)) //border width to height?
        CGContextSetStrokeColorWithColor(cxt, borderColor.CGColor)
        CGContextSetLineWidth(cxt, radius)
        
        //numerals
        
        let center = CGPoint(x: rect.size.width/2.0 , y: rect.size.height/2.0)
        let markingDistanceFromCenter = rect.size.width / 2.0 - digitFont.lineHeight / 4.0 - 15 + digitOffset
        let offset = 4
        
        for i in 0..<12
        {
            let hourString: String
            if i + 1 < 10
            {
                hourString = " \(i+1)"// the little space
            }
            else
            {
                hourString = "\(i+1)"
            }
            
            let labelX = center.x + (markingDistanceFromCenter - digitFont.lineHeight / 2.0) * CGFloat(cos((M_PI / 180) * Double(i + offset) * 30 + M_PI))
            
            let labelY = center.y - 1 * (markingDistanceFromCenter - digitFont.lineHeight / 2.0) * CGFloat(sin((M_PI / 180) * Double(i + offset) * 30))
            
            hourString.drawInRect(CGRect(x: labelX - digitFont.lineHeight / 2.0, y: labelY - digitFont.lineHeight / 2.0, width: digitFont.lineHeight, height: digitFont.lineHeight), withAttributes: [NSForegroundColorAttributeName: digitColor, NSFontAttributeName: digitFont])        }
        
       
        
        //hour hand
        let hourHandPos = minutesHadPosition()
        CGContextSetStrokeColorWithColor(cxt, digitColor.CGColor)
        CGContextBeginPath(cxt)
        CGContextMoveToPoint(cxt, boundsCenter.x, boundsCenter.y)
        CGContextSetLineWidth(cxt, 3.5)
        CGContextAddLineToPoint(cxt, hourHandPos.x, hourHandPos.y)
        CGContextStrokePath(cxt)
        
        
        //minutes hand
        let minHandPos = minutesHadPosition()
        CGContextSetStrokeColorWithColor(cxt, UIColor.grayColor().CGColor)
        CGContextBeginPath(cxt)
        CGContextMoveToPoint(cxt, boundsCenter.x, boundsCenter.y)
        CGContextSetLineWidth(cxt, 2.0)
        CGContextAddLineToPoint(cxt, minHandPos.x, minHandPos.y)
        CGContextStrokePath(cxt)


        
        
        //second hand
        let secHandPos = secondsHadPosition()
        CGContextSetStrokeColorWithColor(cxt, UIColor.redColor().CGColor)
        CGContextBeginPath(cxt)
        CGContextMoveToPoint(cxt, boundsCenter.x, boundsCenter.y)
        CGContextSetLineWidth(cxt, 1.0)
        CGContextAddLineToPoint(cxt, secHandPos.x, secHandPos.y)
        CGContextStrokePath(cxt)
        
        //second hand center
        
        radius = 3.0
        let center3 = CGRect(x: boundsCenter.x - radius, y: boundsCenter.y - radius, width: radius * 2, height: radius * 2)
        CGContextAddEllipseInRect(cxt, center3)
        CGContextSetFillColorWithColor(cxt, UIColor.redColor().CGColor)
        CGContextFillPath(cxt)
        
        

        
        
    }
    
    func secondsHadPosition() ->CGPoint
    {
        let secondsAsRadians = Float(Double(seconds) / 60.0 * 2.0 * M_PI - M_PI_2)
        let handRadius = CGFloat(frame.size.width / 2.5)
        return CGPoint(x: handRadius * CGFloat(cosf(secondsAsRadians)) + boundsCenter.x, y: handRadius * CGFloat(sinf(secondsAsRadians)) + boundsCenter.y)
        
    }
    
    func minutesHadPosition() ->CGPoint
    {
        let minutesAsRadians = Float(Double(minutes) / 60.0 * 2.0 * M_PI - M_PI_2)
        let handRadius = CGFloat(frame.size.width / 3.0)
        return CGPoint(x: handRadius * CGFloat(cosf(minutesAsRadians)) + boundsCenter.x, y: handRadius * CGFloat(sinf(minutesAsRadians)) + boundsCenter.y)
        
    }
    
    func hoursHadPosition() ->CGPoint
    {
        let hoursAsRadians = Float(Double(hours) / 60.0 * 2.0 * M_PI - M_PI_2)
        let handRadius = CGFloat(frame.size.width / 3.7)
        return CGPoint(x: handRadius * CGFloat(cosf(hoursAsRadians)) + boundsCenter.x, y: handRadius * CGFloat(sinf(hoursAsRadians)) + boundsCenter.y)
        
    }
    
    func timerFired(sender:AnyObject)
    {
        time = NSDate()
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        calendar?.timeZone = timezone!
        let timeComponents = calendar?.components([.Hour,.Minute,.Second], fromDate: time!)
        
        hours = (timeComponents?.hour)!
        minutes = (timeComponents?.minute)!
        seconds = (timeComponents?.second)!
        
        
        
        setNeedsDisplay() // reload the rectangle
    }

  


}
