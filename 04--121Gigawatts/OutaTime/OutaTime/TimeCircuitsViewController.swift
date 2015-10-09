//
//  TimeCircuitsViewController.swift
//  OutaTime
//
//  Created by Pedro Trujillo on 10/8/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//


import UIKit

class TimeCircuitsViewController: UIViewController
{
    @IBOutlet var datePicker:UIDatePicker!
    var datePickerString:String!
    
    let dateFormater: NSDateFormatter = NSDateFormatter()
    //let timeFormater: NSDateFormatter = NSDateFormatter()
    
    
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        datePickerString = ""
        setDateFormatter()

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Set Date 
    
    func setDateFormatter()
    {
        dateFormater.dateStyle = NSDateFormatterStyle.ShortStyle
        //datePickerString = dateFormater.stringFromDate(datePicker.date)
    }
    
    //MARK: - Actions
    @IBAction func datePickerChange(sender: UIDatePicker)
    {
        setDateFormatter()
    }
    
}


