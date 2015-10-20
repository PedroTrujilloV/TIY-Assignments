//
//  SiteDescriptionViewController.swift
//  TheGrailDiary
//
//  Created by Pedro Trujillo on 10/20/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class SiteDescriptionViewController: UIViewController
{
    
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var country :UILabel!
    @IBOutlet weak var descriptions:UITextView!
    @IBOutlet weak var photo:UIImageView!
    
    var site:SiteModel!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.name.text = self.site.getName()
        self.country.text = self.site.getCountry()
        self.descriptions.text = self.site.getDescriptions()
        self.photo.image = UIImage(named: self.site.getPhotoPath())
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) 
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
