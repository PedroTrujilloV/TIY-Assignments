//
//  ViewController.swift
//  Countdown
//
//  Created by Ben Gohlke on 10/8/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

@objc protocol TimerPickerDelegate
{
    func timerWasChosen(timerCount: Int)
}

class CountdownViewController: UIViewController, TimerPickerDelegate
{

    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ShowCountdownPickerSegue"
        {
            let timerPickerVC = segue.destinationViewController as! TimerPickerViewController
            timerPickerVC.delegate = self
        }
    }
    
    // MARK: - TimerPicker Delegate
    
    func timerWasChosen(timerCount: Int)
    {
        countLabel.text = "\(timerCount)"
    }

}

