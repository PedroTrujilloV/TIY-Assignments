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
    //MARK: - IBOutlets
    @IBOutlet var datePicker:UIDatePicker!
    
    //MARK: - Constants
    let dateFormatter : NSDateFormatter = NSDateFormatter()
    
    //MARK: - Variables
    var datePickerString:String!
    var delegate: TimeCircuitsDelegate?
    
    let dateFormater: NSDateFormatter = NSDateFormatter()
    //let timeFormater: NSDateFormatter = NSDateFormatter()
    
    
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        datePickerString = ""
        setDateFormatter()

        
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        delegate?.dateWasPicked(datePickerString)
        print("TimeCircuits")
        print(datePickerString)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Set funcions 
    
    func setDateFormatter()
    {
        
        self.dateFormatter.dateStyle = .MediumStyle
        self.dateFormatter.dateFormat = "MM dd, yyyy"
        datePickerString = dateFormatter.stringFromDate(datePicker.date)
    }
    
    //MARK: - Actions
    @IBAction func datePickerChange(sender: UIDatePicker)
    {
        setDateFormatter()
    }
    
}


