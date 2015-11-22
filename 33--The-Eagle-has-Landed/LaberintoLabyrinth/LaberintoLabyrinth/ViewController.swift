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
    var numberOfBalls: Int = 3
    var ballsArray:Array<BallUIView> = []
    
    //objects phyx properties
    var ballsElasticity: CGFloat = 0.8
    var ballsDensity:CGFloat = 1.0
    var ballsFriction:CGFloat = 0.01


    override func viewDidLoad()
    {
        super.viewDidLoad()

        
        
        setProperties(numberOfBalls)
        
        
        
        //this is for test in simulator
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated:", name: UIDeviceOrientationDidChangeNotification, object: UIDevice.currentDevice())
        
        //createGrid()//uncoment
        
    }
    func rotated(note: NSNotification)
    {
        let device: UIDevice = note.object as! UIDevice
        switch(device.orientation)
        {
        case UIDeviceOrientation.Portrait:
            print("Portrait ")
            let v = CGVectorMake(0.0 , 1.0);
            self.gravity.gravityDirection = v
            break
        case UIDeviceOrientation.PortraitUpsideDown:
            print("Portrait Upside Down ")
            let v = CGVectorMake(0.0 , -1.0);
            self.gravity.gravityDirection = v
            break
        case UIDeviceOrientation.LandscapeLeft:
            print("Landscape Left ")
            let v = CGVectorMake(-1.0 , 0.0);
            self.gravity.gravityDirection = v
            break
        case UIDeviceOrientation.LandscapeRight:
            print("Landscape Right ")
            let v = CGVectorMake(1.0 , 0.0);
            self.gravity.gravityDirection = v
            break
        case UIDeviceOrientation.Unknown:
            print("Unknown ")
            break
        default:
            break
        }
        

        
        print("dir X: \(self.gravity.gravityDirection.dx)")
        print("dir Y: \(self.gravity.gravityDirection.dy)")
        
    }
    
    func createGrid()
    {
        var list = [Int]()
        let size = 20
        let rootValue = 7//Int(arc4random_uniform(UInt32(size)))//Int(size/5)// it can chagne to set the sie of the maze just spliting the size, it decide where begin the root
        let newTree:BinaryTree = BinaryTree(rootVal:  rootValue)
        
        
        var ran = rootValue
        list.append(ran)
        print("root insert: \(rootValue)")
        
        for x in 1..<size
        {
            list.append(ran)
            
            repeat
            {
                
                ran = Int(arc4random_uniform(UInt32(size)))
            }
            while list.contains(ran)
      
            newTree.sortedInsert(ran, newNode: newTree.root)

        }
        print("\n tree level \(newTree.height)")

        newTree.BFSearchMatix(newTree.root,size: size)
    }
    
    
  
    func setProperties(numberOfBalls:Int)
    {
        //objects
        for nb in 0..<(numberOfBalls)
        {
            let aBall:BallUIView = BallUIView(frame: CGRectMake(100.0, 200.0, 50.0, 50.0))
            aBall.ID = nb
            aBall.ballBgColor = UIColor.orangeColor()
            aBall.layer.cornerRadius = aBall.bounds.size.width/2
            aBall.layer.masksToBounds = true
            ballsArray.append(aBall)
            view.addSubview(aBall)
        }
        
        //phyx
        animator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior(items: ballsArray)
        
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: ballsArray)
        collision.translatesReferenceBoundsIntoBoundary = true // add stage frame to colisions area
        animator?.addBehavior(collision)
        
        
        //phyx properties for items
        let ballElasticity = UIDynamicItemBehavior(items: ballsArray)
        ballElasticity.elasticity = ballsElasticity
        animator.addBehavior(ballElasticity)
        
        let ballDensity = UIDynamicItemBehavior(items: ballsArray)
        ballDensity.density = ballsDensity
        animator.addBehavior(ballDensity)
        
        let ballFriction = UIDynamicItemBehavior(items: ballsArray)
        ballFriction.friction = ballsFriction
        animator.addBehavior(ballFriction)
        
        
        //Motion Device//reference [2]
        motionManager = CMMotionManager()
        //motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: gravityUpdated)
    }
    


    func gravityUpdated(motion:CMDeviceMotion?, error:NSError?)
    {
        print("Test")
        
//        if (error != nil)
//        {
//          
//            
//        }
//        else
//        {
//            print("Motion device  (gravity) error: ",error?.localizedDescription)
//        }
//        
        
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
        
        print("dir X: \(self.gravity.gravityDirection.dx)")
        print("dir Y: \(self.gravity.gravityDirection.dy)")
    }
    
    func render()
    {
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//reference [1] http://stackoverflow.com/questions/25651969/setting-device-orientation-in-swift-ios
//reference [2] https://www.bignerdranch.com/blog/uidynamics-in-swift/