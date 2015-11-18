//
//  ViewController.swift
//  DynamicsDemo
//
//  Source from Ray Wenderlich tutorial:
//  http://www.raywenderlich.com/76147/uikit-dynamics-tutorial-swift
//  Modified by Ben Gohlke on 11/17/15 to function properly on iOS 9 and Swift 2.0

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate
{
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!

    var collision: UICollisionBehavior!
    
    var firstContact = true
    
    var square: UIView!
    var snap: UISnapBehavior!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        let square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
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
        
//        collision.addItem(barrier)
        collision.addBoundaryWithIdentifier("barrier", forPath: UIBezierPath(rect: barrier.frame))
        
        collision.collisionDelegate = self
        
        let itemBehavior = UIDynamicItemBehavior(items: [square])
        itemBehavior.elasticity = 0.6
        animator.addBehavior(itemBehavior)
        
//        var updateCount = 0
//        collision.action = {
//            if updateCount % 3 == 0
//            {
//                let outline = UIView(frame: square.bounds)
//                outline.transform = square.transform
//                outline.center = square.center
//                
//                outline.alpha = 0.5
//                outline.backgroundColor = UIColor.clearColor()
//                outline.layer.borderColor = square.layer.presentationLayer()?.backgroundColor
//                outline.layer.borderWidth = 1.0
//                self.view.addSubview(outline)
//            }
//            
//            ++updateCount
//        }
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint) {
        print("Boundary contact occurred - \(identifier)")
        
        let collidingView = item as! UIView
        collidingView.backgroundColor = UIColor.yellowColor()
        UIView.animateWithDuration(0.3) {
            collidingView.backgroundColor = UIColor.grayColor()
        }
        
//        if firstContact
//        {
//            firstContact = false
//            
//            let square = UIView(frame: CGRect(x: 30, y: 0, width: 100, height: 100))
//            square.backgroundColor = UIColor.grayColor()
//            view.addSubview(square)
//            
//            collision.addItem(square)
//            gravity.addItem(square)
//            
//            let attach = UIAttachmentBehavior(item: collidingView, attachedToItem: square)
//            animator.addBehavior(attach)
//        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if snap != nil
        {
            animator.removeBehavior(snap)
        }
        
        let touch = touches.first! as UITouch
        snap = UISnapBehavior(item: square, snapToPoint: touch.locationInView(view))
        animator.addBehavior(snap)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

