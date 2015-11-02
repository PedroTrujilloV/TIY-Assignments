//
//  GitHubFriendCell.swift
//  GitHub Friends
//
//  Created by Pedro Trujillo on 10/27/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell
{
    var labelString = "Empty"
    var imagePath = "gravatar.png"
    var userImage:UIImage!
    //var frameView: UIImageView!
    

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        
        self.loadImage()
        self.setLabels()
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLabels(var labelString:String = "")
    {
        if labelString == ""
        {labelString = self.labelString}
        else
        {self.labelString = labelString}
        
        
        
        let thing = false
        if thing
        {/* self.textLabel?.frame  = CGRect(x: 0, y: 0, width: self.frame.size.width * 0.2, height: self.frame.size.height)
        self.textLabel?.text = labelString
        self.textLabel?.center.x = 20//self.frameView.frame.width * 0.1
        self.textLabel?.numberOfLines = 2*/
        }
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
                self.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
                self.imageView!.image = UIImage(data: data)
            }
        }
        
        
        //self.userImage = UIImage(named: ImagePath)
        
        //self.imageView?.image = UIImage(named: ImagePath)
        
        let thing = false
        if thing
        {
        /*
        self.frameView = UIImageView(image: userImage!)
        self.frameView.frame = CGRect(x: 0, y: (self.frame.size.height) - (self.frame.size.height * 0.95 ), width: self.frame.size.height * 0.9 , height: self.frame.size.height * 0.9 )
        
        //self.frameView.frame = CGRect(x: self.frame.size.width * 0.8 , y: (self.frame.size.height) - (self.frame.size.height * 0.95 ), width: self.frame.size.height * 0.9 , height: self.frame.size.height * 0.9 )
        
        //self.addSubview(frameView)
        */
        }
    }

}
