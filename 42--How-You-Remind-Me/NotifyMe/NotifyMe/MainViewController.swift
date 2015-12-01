//
//  ViewController.swift
//  NotifyMe
//
//  Created by Pedro Trujillo on 12/1/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

let popViewNotification = "PopviewNotification"

class MainViewController: UIViewController
{
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserverForName(popViewNotification, object: nil, queue: NSOperationQueue.mainQueue())
        {
            (notification) -> Void in
            
            self.navigationController?.popToRootViewControllerAnimated(true)
            self.label.text = notification.object as? String
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

