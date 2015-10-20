//
//  SiteTableViewCell.swift
//  TheGrailDiary
//
//  Created by Pedro Trujillo on 10/19/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class SiteTableViewCell: UITableViewCell
{
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var country :UILabel!
    //@IBOutlet weak 
    var descriptions :String!
    @IBOutlet weak var photo:UIImageView!
    
    var siteModel: SiteModel!

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLabelsValues(siteModel:SiteModel)
    {
        self.siteModel = siteModel
        
        self.name.text = self.siteModel.getName()
        self.country.text = self.siteModel.getCountry()
        self.descriptions = self.siteModel.getDescriptions()
        self.photo.image = UIImage(named: self.siteModel.getPhotoPath())
        
    }
    
   

}
