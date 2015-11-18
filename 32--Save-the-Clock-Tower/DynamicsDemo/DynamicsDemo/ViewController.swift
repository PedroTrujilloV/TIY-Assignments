//
//  ViewController.swift
//  DynamicsDemo
//
//  Created by Pedro Trujillo on 11/18/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var animator: UIDynamicAnimator!
    var gravity:UIGravityBehavior!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        let square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        square.backgroundColor = UIColor.grayColor()
        view.addSubview(square)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

