//
//  GameScene.swift
//  SKInvaders
//
//  Created by Ben Gohlke on 11/23/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
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
    
    let motionManager: CMMotionManager = CMMotionManager()
    
    var contentCreated = false
    var invaderMovementDirection: InvaderMovementDirection = .Right
    var timeOfLastMove: CFTimeInterval = 0.0
    let timePerMove: CFTimeInterval = 1.0
    
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
        if !contentCreated
        {
            createContent()
            contentCreated = true
        }
    }
    
    func createContent()
    {
//        let invader = SKSpriteNode(imageNamed: "InvaderA_00.png")
//        invader.position = CGPoint(x: size.width/2, y: size.height/2)
//        addChild(invader)
        
        backgroundColor = SKColor.blackColor()
        physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        setupInvaders()
        setupShip()
        setupHud()
    }
    
    func makeInvaderOfType(invaderType: InvaderType) -> (SKNode)
    {
        var invaderColor: SKColor
        
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
        let baseOrigin = CGPoint(x: size.width / 3, y: 180)
        
        for var row = 1; row <= kInvaderRowCount; row++
        {
            var invaderType: InvaderType
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
            print("invader position y: \(invaderPositionY)")
            var invaderPosition = CGPoint(x: baseOrigin.x, y: invaderPositionY)
            
            for var col = 1; col<=kInvaderColCount; col++
            {
                let invader = makeInvaderOfType(invaderType)
                invader.position = invaderPosition
                addChild(invader)
                
                invaderPosition = CGPoint(x: invaderPosition.x + kInvaderSize.width + kInvaderGridSpacing.width, y: invaderPositionY)
            }
        }
    }
    
    func setupShip()
    {
        let ship = makeShip()
        
        ship.position = CGPoint(x: size.width / 2.0, y: kShipSize.height / 2.0)
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
        let scoreLabel = SKLabelNode(fontNamed: "Courier")
        scoreLabel.name = kScoreHudName
        scoreLabel.fontSize = 25
        
        scoreLabel.fontColor = SKColor.greenColor()
        scoreLabel.text = String(format: "Score %04u", 0)
        
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height - (40 + scoreLabel.frame.size.height / 2))
        addChild(scoreLabel)
        
        let healthLabel = SKLabelNode(fontNamed: "Courier")
        healthLabel.name = kHealthHudName
        healthLabel.fontSize = 25
        healthLabel.fontColor = SKColor.redColor()
        healthLabel.text = String(format: "Health: %.1f%%", shipHealth * 100.0)
        healthLabel.position = CGPoint(x: size.width / 2, y: size.height - (80 + healthLabel.frame.size.height / 2))
        
        addChild(healthLabel)
    }
    
    func moveInvadersForUpdate(currentTime: CFTimeInterval)
    {
        if currentTime - timeOfLastMove < timePerMove
        {
            return
        }
        
        determineInvaderMovementDirection()
        
        enumerateChildNodesWithName(kInvaderName) {
            node, stop in
            switch self.invaderMovementDirection
            {
                case .Right:
                    node.position = CGPoint(x: node.position.x + 10, y: node.position.y)
                case .Left:
                    node.position = CGPoint(x: node.position.x - 10, y: node.position.y)
                case .DownThenLeft, .DownThenRight:
                    node.position = CGPoint(x: node.position.x, y:node.position.y - 10)
                case .None:
                    break
            }
            self.timeOfLastMove = currentTime
        }
    }
    
    func determineInvaderMovementDirection()
    {
        var proposedMovementDirection: InvaderMovementDirection = invaderMovementDirection
        
        enumerateChildNodesWithName(kInvaderName) {
            node, stop in
            switch self.invaderMovementDirection
            {
                case .Right:
                    if (CGRectGetMaxX(node.frame) >= node.scene!.size.width - 1.0)
                    {
                        proposedMovementDirection = .DownThenLeft
                        stop.memory = true
                    }
                case .Left:
                    if (CGRectGetMinX(node.frame) <= 1.0)
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
    
    func processUserMotionForUpdate(currentTime: CFTimeInterval)
    {
        let ship = childNodeWithName(kShipName) as! SKSpriteNode
        
        if let data = motionManager.accelerometerData
        {
            if (fabs(data.acceleration.x) > 0.2)
            {
                ship.physicsBody!.applyForce(CGVectorMake(40.0 * CGFloat(data.acceleration.x), 0))
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
       /* Called when a touch begins */
    }
   
    override func update(currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
        moveInvadersForUpdate(currentTime)
        processUserMotionForUpdate(currentTime)
    }
}
