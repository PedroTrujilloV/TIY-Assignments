//
//  ViewController.swift
//  GitHub Friends
//
//  Created by Pedro Trujillo on 10/29/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    var userImageView:UIImageView!
    var userImage:UIImage!
    var nameLabel:UILabel!
    var loginLael:UILabel!
    var emailLabel:UILabel!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        //self.addSubview(frameView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadImage(var ImagePath:String = "")
    {
        if ImagePath == ""
        {ImagePath = self.imagePath}
        else
        {self.imagePath = ImagePath}
        
        
        if let url = NSURL(string: ImagePath)
        {
            if let data = NSData(contentsOfURL: url)
            {
                self.userImageView!.contentMode = UIViewContentMode.ScaleAspectFit
                self.userImageView!.image = UIImage(data: data)
            }
        }
        
        
        self.userImage = UIImage(named: ImagePath)
        
        
        self.userImageView = UIImageView(image: userImage!)
        
        self.userImageView.frame = CGRect(x: 0, y: (self.frame.size.height) - (self.frame.size.height * 0.95 ), width: self.frame.size.height * 0.9 , height: self.frame.size.height * 0.9 )
        
        self.userImageView.frame = CGRect(x: self.frame.size.width * 0.8 , y: (self.frame.size.height) - (self.frame.size.height * 0.95 ), width: self.frame.size.height * 0.9 , height: self.frame.size.height * 0.9 )
        
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
