//
//  TipCell.swift
//  IronTips
//
//  Created by Ben Gohlke on 11/5/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class TipCell: UITableViewCell
{

    @IBOutlet weak var textField: UITextField!
    
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

}
