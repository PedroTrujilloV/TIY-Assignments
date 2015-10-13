//
//  HeroDetailViewController.swift
//  SHIELD_HeroTracker
//
//  Created by Pedro Trujillo on 10/12/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import Foundation

import UIKit





class HeroDetailViewController: UIViewController
{
    @IBOutlet var nameAgentSHIELD_Label:UILabel!
    @IBOutlet var homeworldAgentSHIELD_Label:UILabel!
    @IBOutlet var powersAgentSHIELD_Label:UILabel!
    @IBOutlet var imageAgentSHIELD:UIImageView!
    
    var hero:Hero!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        nameAgentSHIELD_Label.text = hero.name
        homeworldAgentSHIELD_Label.text = hero.homeworld
        powersAgentSHIELD_Label.text = hero.powers
        //imageAgentSHIELD.image
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

    

    
}