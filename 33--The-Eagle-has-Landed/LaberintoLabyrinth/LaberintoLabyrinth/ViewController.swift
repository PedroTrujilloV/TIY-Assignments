//
//  ViewController.swift
//  LaberintoLabyrinth
//
//  Created by Pedro Trujillo on 11/18/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController//, UICollisionBehaviorDelegate
{
    //phyx
    var animator:UIDynamicAnimator!
    var gravity:UIGravityBehavior!
    var collision:UICollisionBehavior!
    var motionManager:CMMotionManager!
    
    //objects
    var ball:BallUIView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //setProperties()
        
        
        var list = [Int]()

        
        var newTree:BinaryTree = BinaryTree(rootVal:  5)
        list.append(5)
        print("root insert: \(5)")

        
        var ran = 0
        
        for x in 1...10
        {
            repeat
            {
                
                ran = Int(arc4random_uniform(10))
                if list.count == 10
                {break}
            }
            while list.contains(ran)
            
            
            list.append(ran)
            
            newTree.sortedInsert(ran, newNode: newTree.root)
            
        }
        //print("leftnode of root \(newTree.root.leftNode?.rightNode?.value)")
        newTree.BFSearch(newTree.root)
    }
  /*
    func setProperties()
    {
        //objects
        ball = BallUIView(frame: CGRectMake(100.0, 200.0, 50.0, 50.0))
        view.addSubview(ball)
        
        //phyx
        animator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior(items: [ball])
        animator.addBehavior(gravity)
        
        
        collision = UICollisionBehavior(items: [ball])
        collision.translatesReferenceBoundsIntoBoundary = true // add stage frame to colisions area
        animator?.addBehavior(collision)
        
        //Motion Device
        motionManager = CMMotionManager()
        //motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: gravityUpdated)
        
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.currentQueue()!)
            { (motion:CMDeviceMotion?, error:NSError?) -> Void in
                print("Test")

            if (error != nil)
            {
                let grav: CMAcceleration = (motion?.gravity)!;
                
                let x = CGFloat(grav.x)
                let y = CGFloat(grav.y)
                
                var p = CGPointMake(x,y)
                
                // Have to correct for orientation.
                let orientation = UIApplication.sharedApplication().statusBarOrientation;
                
                if orientation == UIInterfaceOrientation.LandscapeLeft {
                    let t = p.x
                    p.x = 0 - p.y
                    p.y = t
                } else if orientation == UIInterfaceOrientation.LandscapeRight {
                    let t = p.x
                    p.x = p.y
                    p.y = 0 - t
                } else if orientation == UIInterfaceOrientation.PortraitUpsideDown {
                    p.x *= -1
                    p.y *= -1
                }
                
                let v = CGVectorMake(p.x, 0 - p.y);
                self.gravity.gravityDirection = v;
            }
            else
            {
                print("Motion device  (gravity) error: ",error?.localizedDescription)
            }
        }
        

    }
    

    //screen
    override func shouldAutorotate() -> Bool //reference [1]
    {
        return true
    }
    
    func gravityUpdated(motion:CMDeviceMotion?, error:NSError?)
    {
        print("Test")
        
        if (error != nil)
        {
            let grav: CMAcceleration = (motion?.gravity)!;
            
            let x = CGFloat(grav.x)
            let y = CGFloat(grav.y)
            
            var p = CGPointMake(x,y)
            
            // Have to correct for orientation.
            let orientation = UIApplication.sharedApplication().statusBarOrientation;
            
            if orientation == UIInterfaceOrientation.LandscapeLeft {
                let t = p.x
                p.x = 0 - p.y
                p.y = t
            } else if orientation == UIInterfaceOrientation.LandscapeRight {
                let t = p.x
                p.x = p.y
                p.y = 0 - t
            } else if orientation == UIInterfaceOrientation.PortraitUpsideDown {
                p.x *= -1
                p.y *= -1
            }
            
            let v = CGVectorMake(p.x, 0 - p.y);
            gravity.gravityDirection = v;
        }
        else
        {
            print("Motion device  (gravity) error: ",error?.localizedDescription)
        }
    }
    
    func render()
    {
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

*/
}

//reference [1] http://stackoverflow.com/questions/25651969/setting-device-orientation-in-swift-ios