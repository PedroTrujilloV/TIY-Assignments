//
//  GameScene.swift
//  SkyInvaders - Pedro
//
//  Created by Pedro Trujillo on 11/23/15.
//  Copyright (c) 2015 Pedro Trujillo. All rights reserved.
//

import SpriteKit
import CoreMotion


class GameScene: SKScene
{
    enum InvaderType
    {
        case A
        case B
        case C
    }
    
    enum InvaderMovementDirection
    {
        case Right
        case Left
        case DownThenRight
        case DownThenLeft
        case None
    }
    
    
    enum BulletType
    {
        case ShipFired
        case InvaderFired
        
    }
    
    let motionManager: CMMotionManager = CMMotionManager()
    var tapQueue:Array<Int> = []
    
    var contactQueue:Array<SKPhysicsContact> = []
    
    
    
    
    var contentCreated = false
    var invaderMovementDirection:InvaderMovementDirection = .Right
    
    var timeOfLastMove: CFTimeInterval = 0.0
    let timePerMove: CFTimeInterval = 1.0
    
    let kShipFiredBulletName = "shipFiredBullet"
    let kInvaderFiredBulletName = "invaderFiredBullet"
    let kBulletSize = CGSize(width: 4.0, height: 3.0) ///bulet size
    
    let kInvaderSize = CGSize(width: 24, height: 16)
    let kInvaderGridSpacing = CGSize(width: 12, height: 12)
    let kInvaderRowCount = 6
    let kInvaderColCount = 6
    let kInvaderName = "invader"
    
    let kShipSize = CGSize(width: 30, height: 16)
    let kShipName = "ship"
    
    let kScoreHudName = "scoreHud"
    let kHealthHudName = "healthHud"
    
    var score: Int = 0
    var shipHealth: Float = 1.0
    
    override func didMoveToView(view: SKView)
    {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!";
//        myLabel.fontSize = 45;
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        if !contentCreated
        {
            createContent()
            contentCreated = true
            motionManager.startAccelerometerUpdates()
        }
        
        self.addChild(myLabel)
    }
    
    func createContent()
    {
//        let invader = SKSpriteNode(imageNamed: "InvaderA_00.png")
//        invader.position = CGPoint(x: size.width/2, y: size.height/2)
//        addChild(invader)
        backgroundColor = SKColor.blackColor()
        
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)

        setupInvaders()
        setUpShip()
        setupHud()
    }
    
    
    func makeInvaderOfType(invaderType:InvaderType) ->(SKNode)
    {
        var invaderColor:SKColor
        switch(invaderType)
        {
            case .A:
                invaderColor = SKColor.redColor()
            case .B:
                invaderColor = SKColor.greenColor()
            case .C:
                invaderColor = SKColor.blueColor()
        }
        
        let invader = SKSpriteNode(color: invaderColor, size: kInvaderSize)
        
        invader.name = kInvaderName
        
        return invader
    }
    
    func setupInvaders()
    {
        let baseOrigin = CGPoint(x: size.width/3 , y: 180)
        
        for var row = 1; row <= kInvaderRowCount; row++
        {
            var invaderType:InvaderType
            
            if row % 3 == 0
            {
                invaderType = .A
            }
            else if row % 3 == 1
            {
                invaderType = .B
            }
            else
            {
                invaderType = .C
            }
            
            
            let invaderPositionY = CGFloat(row) * (kInvaderSize.height * 2) + baseOrigin.y
            var invaderPisition = CGPoint(x: baseOrigin.x, y: invaderPositionY)
            
            for var col = 1; col <= kInvaderColCount; col++
            {
                let invader = makeInvaderOfType(invaderType)
                invader.position = invaderPisition
                
                addChild(invader)
                
                invaderPisition = CGPoint(x: invaderPisition.x + kInvaderSize.width + kInvaderGridSpacing.width, y: invaderPositionY)
            }
            
        }
    }
    
    func setUpShip()
    {
        let ship = makeShip()
        
        ship.position = CGPoint(x: size.width/2.0, y: kShipSize.height/2.0)
        addChild(ship)
    }
    
    func makeShip() -> SKNode
    {
        let ship = SKSpriteNode(color: SKColor.greenColor(), size: kShipSize)
        ship.name = kShipName
        
        ship.physicsBody = SKPhysicsBody(rectangleOfSize: ship.frame.size)
        ship.physicsBody!.dynamic = true
        ship.physicsBody!.affectedByGravity = false
        ship.physicsBody!.mass = 0.02
        
        
        return ship
    }
    
    func setupHud()
    {
        let scoredLabel = SKLabelNode(fontNamed: "Courier")
        scoredLabel.name = kScoreHudName
        scoredLabel.fontSize = 25
        
        scoredLabel.fontColor = SKColor.greenColor()
        scoredLabel.text = String(format: "Score %04u", 0)
        
        scoredLabel.position = CGPoint(x: frame.size.width/2, y: size.height - (40 + scoredLabel.frame.size.height/2))
        addChild(scoredLabel)
        
        let healthLabel = SKLabelNode(fontNamed: "Courier")
        healthLabel.name = kHealthHudName
        healthLabel.fontSize = 25
        
        healthLabel.fontColor = SKColor.redColor()
        healthLabel.text = String(format: "Health: %.1f%%", shipHealth * 100.0)
        
        healthLabel.position = CGPoint(x: frame.size.width/2, y: size.height - (80 + healthLabel.frame.size.height/2))
        addChild(healthLabel)
    }
    
    func makeBulletIfType(bulletType:BulletType)->SKNode
    {
        var bullet:SKNode
        
        switch bulletType
        {
        case .ShipFired:
            bullet = SKSpriteNode(color: SKColor.greenColor(), size: kBulletSize)
            bullet.name = kShipFiredBulletName
        case .InvaderFired:
            bullet = SKSpriteNode(color: SKColor.magentaColor(), size: kBulletSize)
            bullet.name = kInvaderFiredBulletName
        }
        
        return bullet
    }
    
    func firedBullet(bullet:SKNode, toDestination destination:CGPoint, withDuration duration:CFTimeInterval, andSoundFileName soundName: String)
    {
        let bulletAction = SKAction.sequence([SKAction.moveTo(destination, duration: duration),SKAction.waitForDuration(3.0/60.0),SKAction.removeFromParent()])
        let soundAction = SKAction.playSoundFileNamed(soundName, waitForCompletion: true)
        bullet.runAction(SKAction.group([bulletAction,soundAction]))
        addChild(bullet)
    }
    
    func fireShipBullets()
    {
        let existingBullet = childNodeWithName(kShipFiredBulletName)
        
        if existingBullet == nil
        {
            if let ship = childNodeWithName(kShipName)
            {
                let bullet = makeBulletIfType(.ShipFired)
                bullet.position = CGPoint(x: ship.position.x, y: ship.position.y + ship.frame.size.height - bullet.frame.size.height/2)
                let bulletDestination = CGPoint(x: ship.position.x, y: frame.size.height + bullet.frame.size.height/2)
                
                firedBullet(bullet, toDestination: bulletDestination, withDuration: 0.5, andSoundFileName: "fart-01.wav")//"ShipBullet.wav")//
            }
        }
    }
    
    func moveInvadersForUpdate(currentTime:CFTimeInterval)
    {
        if currentTime - timeOfLastMove < timePerMove
        {
            return
        }
        
        determineInvaderMovementDirection()
        
        enumerateChildNodesWithName(kInvaderName)
        {
            node, stop in
            switch self.invaderMovementDirection
            {
            case .Right:
                node.position = CGPoint(x: node.position.x + 10, y: node.position.y)
            case .Left:
                node.position = CGPoint(x: node.position.x - 10, y: node.position.y)
            case    .DownThenLeft, .DownThenRight:
                node.position = CGPoint(x: node.position.x, y: node.position.y - 10)
            case .None:
                break
            }
            
            self.timeOfLastMove = currentTime
        }
    }
    
    func determineInvaderMovementDirection()
    {
        var proposedMovementDirection: InvaderMovementDirection = invaderMovementDirection
        enumerateChildNodesWithName(kInvaderName)
        {
            node, stop in
            
            //stop.memory = true

            switch self.invaderMovementDirection
            {
            case .Right:
                if CGRectGetMaxX(node.frame) >= node.scene!.size.width - 1.0
                {
                    proposedMovementDirection = .DownThenLeft
                    stop.memory = true
                }
            case .Left:
                if CGRectGetMaxX(node.frame) <= 1.0
                {
                    proposedMovementDirection = .DownThenRight
                    stop.memory = true
                    
                }
            case .DownThenLeft:
                proposedMovementDirection = .Left
                stop.memory = true
            case .DownThenRight:
                proposedMovementDirection = .Right
                stop.memory = true
            case .None:
                break
            }
        }
        
        
        invaderMovementDirection = proposedMovementDirection
    }
    
    
    func processuserMotionForUpdate(currentTime:CFTimeInterval)
    {
        let ship = childNodeWithName(kShipName) as! SKSpriteNode
        
        if let data = motionManager.accelerometerData
        {
            if (fabs(data.acceleration.x) > 0.2)
            {
                print("move the ship")
                
                ship.physicsBody!.applyForce(CGVectorMake(40.0 * CGFloat(data.acceleration.x), 0))
                
            }
        }
    }
    
    func processUserTapsForUpdates(currentTimet:CFTimeInterval)
    {
        for tapCount in tapQueue
        {
            if tapCount == 1
            {
                fireShipBullets()
            }
            tapQueue.removeAtIndex(0)
        }
        
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        let touche = touches.first! as UITouch
        
        if touche.tapCount == 1
        {
            tapQueue.append(1)
            
        }
    }
   
    override func update(currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
        moveInvadersForUpdate(currentTime)
        processuserMotionForUpdate(currentTime)
        processUserTapsForUpdates(currentTime)

    }
}
