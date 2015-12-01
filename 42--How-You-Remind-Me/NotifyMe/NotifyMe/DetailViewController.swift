//
//  DetailViewController.swift
//  NotifyMe
//
//  Created by Pedro Trujillo on 12/1/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postNotificationTapped(sender:UIButton)
    {
        NSNotificationCenter.defaultCenter().postNotificationName(popViewNotification, object: "Popped from Detail view")
    }
    


}
