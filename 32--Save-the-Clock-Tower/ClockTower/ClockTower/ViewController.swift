//
//  ViewController.swift
//  ClockTower
//
//  Created by Pedro Trujillo on 11/17/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let clockView = ClockView(frame: CGRect(x: view.center.x - 70 , y: view.center.y - 70 , width: 140.0 , height: 140.0))
        clockView.timezone = NSTimeZone(name: "America/New_York")
        view.addSubview(clockView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

