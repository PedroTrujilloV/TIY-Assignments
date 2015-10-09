//
//  OutaTimeViewController.swift
//  OutaTime
//
//  Created by Pedro Trujillo on 10/8/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit


@objc protocol TimeCircuitsDelegate
{
    func dateWasPicked(datePickerDateString:String)
}


class OutaTimeViewController: UIViewController, TimeCircuitsDelegate
{
    //MARK: - IBOutles
    @IBOutlet var destinationTimeLabel:UILabel!
    @IBOutlet var presentTimeLabel:UILabel!
    @IBOutlet var lastTimeDeparted:UILabel!
    @IBOutlet var speedLabel:UILabel!
    
    //MARK: - Constants
    let dateFormatter : NSDateFormatter = NSDateFormatter()
    
    //MARK: - Variables
    var currentDate : NSDate!
    var currenSpeed : Int!
    var lasTimeDep: String!
    var timerBack: NSTimer?

    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lasTimeDep = "--- -- ----"
        setDestinationLabel("--- -- ----")
        setPresentTime()
        setCurrentSpeed(0)
        lasTimeDep = dateFormatter.stringFromDate(currentDate)
        //setLastTimeDepart(dateFormatter.stringFromDate(currentDate))
       
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ShowTimeCircuitsSegue"
        {
            let datePickerVC = segue.destinationViewController as! TimeCircuitsViewController
            datePickerVC.delegate = self
        }
    }
    
    
    //MARK: - Delegate
    
    func dateWasPicked(datePickerDateString:String)
    {
        print("Outa..")
        print(datePickerDateString)
        setDestinationLabel(datePickerDateString)
        setLastTimeDepart()
        lasTimeDep = datePickerDateString
    }
    
    //MARK: - Set functions
    
    func setPresentTime()
    {
        self.currentDate = NSDate()
        self.dateFormatter.dateStyle = .ShortStyle
        self.dateFormatter.dateFormat = "MM dd, yyyy" // Set the way the date should be displayed
        //print(dateFormatter.stringFromDate(currentDate))
        setPresentTimeLable(self.dateFormatter.stringFromDate(currentDate))
    }
    
    func setDestinationLabel(dateStr:String)
    {
        destinationTimeLabel.text = dateStr
    }
    
    func setPresentTimeLable(dateStr:String)
    {
        presentTimeLabel.text = dateStr
    }
    
    func setCurrentSpeed(speed:Int)
    {
        self.currenSpeed = speed
        speedLabel.text = "\(String(currenSpeed)) MPH"
    }
    
    func setLastTimeDepart()
    {
        lastTimeDeparted.text = lasTimeDep
    }
    
    //MARK: - Get functions


}

