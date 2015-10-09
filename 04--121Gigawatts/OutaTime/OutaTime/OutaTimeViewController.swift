//
//  OutaTimeViewController.swift
//  OutaTime
//
//  Created by Pedro Trujillo on 10/8/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class OutaTimeViewController: UIViewController
{
    //MARK: - IBOutles
    @IBOutlet var destinationTimeLabelr:UILabel!
    @IBOutlet var presentTimeLabel:UILabel!
    @IBOutlet var lastTimeDeparted:UILabel!
    @IBOutlet var speedLabel:UILabel!
    
    //MARK: - Constants
    let dateFormatter : NSDateFormatter = NSDateFormatter()
    
    //MARK: - Variables
    var currentDate : NSDate!
    var currenSpeed : Int!

    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        setPresentTime()
        setCurrentSpeed(0)
        setLastTimeDepart(dateFormatter.stringFromDate(currentDate))
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Set functions
    
    func setPresentTime()
    {
        self.currentDate = NSDate()
        self.dateFormatter.dateStyle = .ShortStyle
        self.dateFormatter.dateFormat = "MM dd, yyyy" // Set the way the date should be displayed
        //print(dateFormatter.stringFromDate(currentDate))
        presentTimeLabel.text = dateFormatter.stringFromDate(currentDate)
    }
    
    func setCurrentSpeed(speed:Int)
    {
        self.currenSpeed = speed
        speedLabel.text = "\(String(currenSpeed)) MPH"
    }
    
    func setLastTimeDepart(lasTimeDep:String)
    {
        lastTimeDeparted.text = lasTimeDep
    }
    
    //MARK: Get functions


}

