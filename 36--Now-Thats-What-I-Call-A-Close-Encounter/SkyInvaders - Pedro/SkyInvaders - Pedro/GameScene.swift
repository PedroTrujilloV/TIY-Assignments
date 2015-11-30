//
//  GameScene.swift
//  SkyInvaders - Pedro
//
//  Created by Pedro Trujillo on 11/23/15.
//  Copyright (c) 2015 Pedro Trujillo. All rights reserved.
//

import SpriteKit
import CoreMotion


class GameScene: SKScene, SKPhysicsContactDelegate
{
    
    let kInvaderCategory: UInt32 = 0x1 << 0
    let kShipFireBulletCategory: UInt32 = 0x1 << 1
    let kShipCategory: UInt32 = 0x1 << 2
    let kSceneEdgeCategory: UInt32 = 0x1 << 3
    let kInvaderFireBulletCategory: UInt32 = 0x1 << 4
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
            userInteractionEnabled = true
            physicsWorld.contactDelegate = self
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
        physicsBody!.categoryBitMask = kSceneEdgeCategory

        setupInvaders()
        setUpShip()
        setupHud()
    }
    
    
//    func makeInvaderOfType(invaderType:InvaderType) ->(SKNode)
//    {
//        var invaderColor:SKColor
//        switch(invaderType)
//        {
//            case .A:
//                invaderColor = SKColor.redColor()
//            case .B:
//                invaderColor = SKColor.greenColor()
//            case .C:
//                invaderColor = SKColor.blueColor()
//        }
//        
//        let invader = SKSpriteNode(color: invaderColor, size: kInvaderSize)
//        
//        invader.name = kInvaderName
//        
//        invader.physicsBody = SKPhysicsBody(rectangleOfSize: invader.frame.size)
//        invader.physicsBody!.dynamic = false
//        invader.physicsBody!.categoryBitMask = kInvaderCategory
//        invader.physicsBody!.contactTestBitMask = 0x0
//        invader.physicsBody!.collisionBitMask = 0x0
//        
//        
//        return invader
//    }
    func makeInvaderOfType(invaderType:InvaderType) ->SKNode
    {
        let invaderTextures = loadInvadersTexturesOfType(invaderType)
        let invader = SKSpriteNode(texture: invaderTextures[0])
        invader.name = kInvaderName
        
        
        
        invader.runAction(SKAction.repeatActionForever(SKAction.animateWithNormalTextures(invaderTextures, timePerFrame: timePerMove)))
        
        invader.physicsBody = SKPhysicsBody(rectangleOfSize: invader.frame.size)
        invader.physicsBody!.dynamic = false
        invader.physicsBody!.categoryBitMask = kInvaderCategory
        invader.physicsBody!.contactTestBitMask = 0x0
        invader.physicsBody!.collisionBitMask = 0x0
        
        return invader
    }

    
    func loadInvadersTexturesOfType(invaderType:InvaderType) -> Array<SKTexture>
    {
        var prefix: String
        
        switch invaderType
        {
        case .A:
            prefix = "InvaderA"
        case .B:
            prefix = "InvaderB"
        case .C:
            prefix = "InvaderC"
        }
        
        return [SKTexture(imageNamed: String(format: "%@_00.png", prefix)),SKTexture(imageNamed: String(format: "%@_01.png", prefix))]
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
        //let ship = SKSpriteNode(color: SKColor.greenColor(), size: kShipSize)
        let ship = SKSpriteNode(imageNamed: "ship.png")
        ship.name = kShipName
        
        ship.physicsBody = SKPhysicsBody(rectangleOfSize: ship.frame.size)
        ship.physicsBody!.dynamic = true
        ship.physicsBody!.affectedByGravity = false
        ship.physicsBody!.mass = 0.02
        ship.physicsBody!.categoryBitMask = kShipCategory
        ship.physicsBody!.contactTestBitMask = 0x0
        ship.physicsBody!.collisionBitMask = kSceneEdgeCategory
        
        
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
            bullet.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.frame.size)
            bullet.physicsBody!.dynamic = true
            bullet.physicsBody!.affectedByGravity = false
            bullet.physicsBody!.contactTestBitMask = kShipCategory
            bullet.physicsBody!.contactTestBitMask = kInvaderCategory
            bullet.physicsBody!.collisionBitMask = 0x0
            
        case .InvaderFired:
            bullet = SKSpriteNode(color: SKColor.magentaColor(), size: kBulletSize)
            bullet.name = kInvaderFiredBulletName
            
            bullet.name = kShipFiredBulletName
            bullet.physicsBody = SKPhysicsBody(rectangleOfSize: bullet.frame.size)
            bullet.physicsBody!.dynamic = true
            bullet.physicsBody!.affectedByGravity = false
            bullet.physicsBody!.contactTestBitMask = kInvaderFireBulletCategory
            bullet.physicsBody!.contactTestBitMask = kShipCategory
            bullet.physicsBody!.collisionBitMask = 0x0
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
    
    func processContactsForUpdate(currentTime:CFTimeInterval)
    {
        for contact in  contactQueue
        {
            handleContact(contact)
            if let index = (contactQueue as NSArray).indexOfObject(contact) as Int?
            {
                contactQueue.removeAtIndex(index)
                
            }
        }
    }
    
    func fireInvaderBulletsForUpdate(currentTime:CFTimeInterval)
    {
        let existingBullet = childNodeWithName(kInvaderFiredBulletName)
        
        if existingBullet == nil
        {
            var allInvaders = Array<SKNode>()
            
            enumerateChildNodesWithName(kInvaderName)
            {
                node, stop in
                allInvaders.append(node)
            }
            
            if allInvaders.count > 0
            {
                let allInvadersIndex = Int(arc4random_uniform(UInt32(allInvaders.count)))
                
                let invader = allInvaders[allInvadersIndex]
                
                let bullet = makeBulletIfType(.InvaderFired)
                
                bullet.position = CGPoint(x: invader.position.x, y: invader.position.y - invader.frame.size.height/2 + bullet.frame.height/2)
                let bulletDestination = CGPoint(x: invader.position.x, y: -(bullet.frame.size.height/2))
                
                firedBullet(bullet, toDestination: bulletDestination, withDuration: 1.0, andSoundFileName: "InvaderBullet.wav")
            }

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
    
    func didBeginContact(contact: SKPhysicsContact)
    {
        if contact as SKPhysicsContact? != nil
        {
            contactQueue.append(contact)
        }
    }
    
    func handleContact(contact:SKPhysicsContact)
    {
        if contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil
        {
            return
        }
        let nodeNames = [contact.bodyA.node!.name!, contact.bodyB.node!.name!]
        
        if (nodeNames as NSArray).containsObject(kShipName) && (nodeNames as NSArray).containsObject(kInvaderFiredBulletName)
        {
            self.runAction(SKAction.playSoundFileNamed("ShipHit.wav", waitForCompletion: false))
            contact.bodyA.node!.removeFromParent()
            contact.bodyA.node!.removeFromParent()
        }
        else  if (nodeNames as NSArray).containsObject(kInvaderName) && (nodeNames as NSArray).containsObject(kShipFiredBulletName)
        {
            self.runAction(SKAction.playSoundFileNamed("InvaderHit.wav", waitForCompletion: false))
            contact.bodyA.node!.removeFromParent()
            contact.bodyA.node!.removeFromParent()
        }

    }
   
    override func update(currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
        moveInvadersForUpdate(currentTime)
        processuserMotionForUpdate(currentTime)
        processUserTapsForUpdates(currentTime)
        fireInvaderBulletsForUpdate(currentTime)
        processContactsForUpdate(currentTime)

    }
}
