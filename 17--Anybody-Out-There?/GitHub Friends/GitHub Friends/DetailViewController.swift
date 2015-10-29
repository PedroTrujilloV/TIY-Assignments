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
    var imagePath = "gravatar.png"
    var userImage:UIImage!
    
    
    var gitHubFriend: GitHubFriend!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        //
        self.loadImage(gitHubFriend.largeImageURL)
        
        self.setLabels(gitHubFriend.login,x: view.center.x, y: userImageView.center.y * 0.4)
        self.setLabels(gitHubFriend.name,x: view.center.x, y: userImageView.center.y * 1.6)
        self.setLabels(gitHubFriend.email,x: view.center.x, y: userImageView.center.y * 1.7)
        self.setLabels(gitHubFriend.location,x: view.center.x, y: userImageView.center.y * 1.8)
        self.setLabels(gitHubFriend.company,x: view.center.x, y: userImageView.center.y * 1.9)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLabels( labelString:String = "Penpenuche", x :CGFloat = 0, y :CGFloat = 0)
    {
        
        let loginLabel:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 60))
        //self.loginLabel.frame  = CGRect(x: 0, y: 0, width: self.view.frame.size.width * 0.9 , height:  self.view.frame.size.width * 0.1)
        loginLabel.text = labelString
        loginLabel.center.x = x
        loginLabel.center.y = y
        loginLabel.numberOfLines = 1
        loginLabel.textAlignment = .Center
        view.addSubview(loginLabel)
        
        
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
                
                self.userImage = UIImage(data: data)
                self.userImageView = UIImageView(image: userImage!)
                self.userImageView!.contentMode = UIViewContentMode.ScaleAspectFit
                self.userImageView.frame = CGRect(x: 0, y: 0 , width: self.view.frame.size.width * 0.9 , height: self.view.frame.size.width * 0.9 )
                self.userImageView.center.x = view.center.x
                self.userImageView.center.y = UIScreen.mainScreen().bounds.height * 0.5
                
                view.addSubview(userImageView)
            }
        }
        
        
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
