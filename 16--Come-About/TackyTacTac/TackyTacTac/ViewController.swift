//
//  ViewController.swift
//  TackyTacTac
//
//  Created by Pedro Trujillo on 10/26/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var grid = [[0,0,0],[0,0,0],[0,0,0]]
    
    var isPlayer1Turn = true
  
    
    var player1Score = 0
    var player2Score = 0
    var stalemateScore = 0
    
    var temeColor = Colors()
    

    
    var turns = 0
    
    let gameStatusLabel = UILabel(frame: CGRect(x: 0, y: 80, width: UIScreen.mainScreen().bounds.width, height: 50))

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = temeColor.backGround
        printMessage()
//        
//        gameStatusLabel.text = "Player 1 score: \(player1Score)    Player 2 score: \(player2Score)  \n  No winners: \(stalemateScore)  Player 1 Trun"
        gameStatusLabel.textAlignment = .Center
        gameStatusLabel.numberOfLines = 3 //http://stackoverflow.com/questions/24134905/how-do-i-set-adaptive-multiline-uilabel-text-in-a-swift-ios-project
        
        gameStatusLabel.center.x = view.center.x
        gameStatusLabel.center.y = UIScreen.mainScreen().bounds.height / 7
        
        view.addSubview(gameStatusLabel)
        createGameGrid()
        
    }
    
    func createGameGrid()
    {
        let screenHight = Int(UIScreen.mainScreen().bounds.height)
        
        let screenWidth = Int(UIScreen.mainScreen().bounds.width)
        
        let buttonHW = 100
        let buttonSpacing = 4
        
        let gridHW = (buttonHW * 3) + (buttonSpacing * 2)
        
        let leftSpacing = (screenWidth - gridHW) / 2
        let topSpacing = (screenHight - gridHW) / 2
        
        for (r, row) in grid.enumerate()
        {
            for (c,_) in row.enumerate()
            {
                let x = c * (buttonHW + buttonSpacing) + leftSpacing
                let y = r * (buttonHW + buttonSpacing) + topSpacing
                
                let button = TTTButton(frame: CGRect(x: x, y: y, width: buttonHW, height: buttonHW))
                
                
                
                button.backgroundColor = self.temeColor.colorGrid
                
                button.row = r
                button.col = c
                
                button.temeColor = self.temeColor
                
                //spacePressed uses (:) because take almost 1 argument
                button.addTarget(self, action: "spacePressed:", forControlEvents: .TouchUpInside)
                view.addSubview(button)
                
            }
        }

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Action Handrlers
    
    func spacePressed(button: TTTButton)
    {
        
        
        if button.player == 0
        {
//            if isPlayer1Turn
//            {
//                button.player = 1
//            }
//            else
//            {
//                button.player = 2
//            }
            
            button.player = isPlayer1Turn ? 1 : 2
            
            grid[button.row][button.col] = isPlayer1Turn ? 1 : 2
            
            isPlayer1Turn = !isPlayer1Turn
            
           checkForWinners()
            printMessage()
        }
        else
        {
            if turns > 9
            {
                stalemateScore += 1
                printMessage()
                clean()
            }
        }
        turns += 1
    }
    
    func checkForWinners()
    {
        
        let possibilities =
        [
            ((0,0),(0,1),(0,2)),
            ((1,0),(1,1),(1,2)),
            ((2,0),(2,1),(2,2)),
            ((0,0),(1,0),(2,0)),
            ((0,1),(1,1),(2,1)),
            ((0,2),(1,2),(2,2)),
            ((0,0),(1,1),(2,2)),
            ((2,0),(1,1),(0,2))
        
        ]
        
        for possibility in possibilities
        {
            let (p1,p2,p3) = possibility
            
            let value1 = grid[p1.0][p1.1]
            let value2 = grid[p2.0][p2.1]
            let value3 = grid[p3.0][p3.1]
            
            if value1 == value2 && value2 == value3
            {
                if value1 != 0
                {
                    print("Player \(value1) wins!")
                    
                    if value1 == 1
                    {
                        player1Score += 1
                        
                    }
                    else
                    {
                        player2Score += 1
                    }
                    
                    printMessage()
                    clean()
                    
                   
                }
                else
                {
                    print("No winner: all zeros")
                    
                }
            }
            else
            {
                print("Does not match")
                
            }
        }
        
       
    }
    
    func printMessage()
    {
        var playerT = 1
        var turnColor:UIColor = temeColor.colorP1
        if !isPlayer1Turn
        {
            playerT = 2
            turnColor = temeColor.colorP2
        }
        
        var message =    "Player 1 score: \(player1Score)    Player 2 score: \(player2Score) \n No winners: \(stalemateScore)  Player \(playerT) Trun"
        
        var myMutableString = NSMutableAttributedString(string: message )//as! NSMutableAttributedString //http://stackoverflow.com/questions/27728466/use-multiple-font-colors-in-a-single-label-swift
        
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: self.temeColor.colorP1 , range: NSRange(location:0, length:17))
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: self.temeColor.colorP2, range: NSRange(location:18, length:20))
        
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: self.temeColor.colorGrid, range: NSRange(location: 39, length:16))
        
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: turnColor, range: NSRange(location: 55, length:14))
        //
       
            gameStatusLabel.attributedText = myMutableString
        
        
    }

    func clean()
    {
        temeColor = Colors()
        view.backgroundColor = temeColor.backGround
        grid = [[0,0,0],[0,0,0],[0,0,0]]
        
        
        isPlayer1Turn = true
        turns = 0
        createGameGrid()
        printMessage()
    }
}

class Colors
{
    var colorP1: UIColor!
    var colorP2: UIColor!
    var colorGrid : UIColor!
    var backGround: UIColor!
    
    init()
    {
        repeat
        {
            self.colorP1 = self.getColor()
            self.colorGrid = self.getColor()
            self.colorP2 = self.getColor()
            self.backGround = self.getColor()
        }while colorP1 == colorP2 || colorP2 == colorGrid || colorP1 == colorGrid || backGround == colorGrid || backGround == colorP1 || backGround == colorP2
        
        
    }
    
    func getColor() -> UIColor
    {
        var colorrandom:Int = 0
        
        
        colorrandom = Int(arc4random_uniform(11))
        
        switch colorrandom
        {
        case 0:
            return UIColor.orangeColor()
        case 1:
            return UIColor.redColor()
        case 2:
            return UIColor.magentaColor()
        case 3:
            return UIColor.brownColor()
        case 4:
            return UIColor.yellowColor()
        case 5:
            return UIColor.greenColor()
        case 6:
            return UIColor.grayColor()
        case 7:
            return UIColor.blackColor()
        case 8:
            return UIColor.blueColor()
        case 9:
            return UIColor.whiteColor()
        default:
            return UIColor.cyanColor()
        
        }
    }
}

class TTTButton: UIButton
{
    var row = 0
    var col = 0
    
    var temeColor:Colors!
    
    var player = 0
    {
        didSet
        {
            switch player
            {
                case 1: backgroundColor = temeColor.colorP1
                case 2: backgroundColor = temeColor.colorP2
                default: backgroundColor = temeColor.colorGrid

//                case 1: backgroundColor = UIColor.magentaColor()
//                case 2: backgroundColor = UIColor.yellowColor()
//                default: backgroundColor = UIColor.cyanColor()
            }
        }
    }
}
