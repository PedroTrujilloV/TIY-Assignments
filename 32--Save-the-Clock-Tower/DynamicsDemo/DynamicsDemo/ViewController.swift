//
//  ViewController.swift
//  DynamicsDemo
//
//  Created by Pedro Trujillo on 11/18/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate
{
    var animator: UIDynamicAnimator!
    var gravity:UIGravityBehavior!
    var collision:UICollisionBehavior!
    var firstContact = true
    var square: UIView!
    var snap: UISnapBehavior!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        square.backgroundColor = UIColor.grayColor()
        view.addSubview(square)
        
        animator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior(items: [square])
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [square])
        
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 130, height: 20))
        
        barrier.backgroundColor = UIColor.redColor()
        
        view.addSubview(barrier)
        
        //collision.addItem(barrier)
        
        collision.addBoundaryWithIdentifier("barrier", forPath: UIBezierPath(rect: barrier.frame))
        
        
        collision.collisionDelegate = self
        
        let itemBehavior = UIDynamicItemBehavior(items: [square])
        itemBehavior.elasticity = 0.6
        animator.addBehavior(itemBehavior)
        
        
        //debuger tracer!
//        var updateCount = 0
//        
//        collision.action =
//        {
//            if updateCount % 3 == 0
//            {
//                let outline = UIView(frame: square.bounds)
//                outline.transform = square.transform
//                outline.center = square.center
//                
//                outline.alpha = 0.5
//                outline.backgroundColor = UIColor.clearColor()
//                outline.layer.backgroundColor = square.layer.presentationLayer()?.backgroundColor
//                outline.layer.borderWidth = 1.0
//                self.view.addSubview(outline)
//            }
//            
//            ++updateCount
//        }
//        
        //we can modify density, friction, and many physix properties :D!!!
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint)
    {
        
        
        let collidingView = item as! UIView
        collidingView.backgroundColor = UIColor.yellowColor()
        UIView.animateWithDuration(0.3)
        {
            collidingView.backgroundColor = UIColor.grayColor()
        }
        
        
        //Attached trailing
        if firstContact
        {
            firstContact = false
            
            let square = UIView(frame: CGRect(x: 30, y: 0, width: 100, height: 100))
            square.backgroundColor = UIColor.grayColor()
            view.addSubview(square)
            
            collision.addItem(square)
            gravity.addItem(square)
            
            let attach = UIAttachmentBehavior(item: collidingView, attachedToItem: square)
            animator.addBehavior(attach)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if snap != nil
        {
            animator.removeBehavior(snap)
        }
        
        let touch = touches.first!
        
        snap = UISnapBehavior(item: square, snapToPoint: touch.locationInView(view))
        animator.addBehavior(snap)
        
        
    }
    
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

