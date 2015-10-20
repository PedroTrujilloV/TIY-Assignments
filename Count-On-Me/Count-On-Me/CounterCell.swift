//
//  CounterCell.swift
//  Count-On-Me
//
//  Created by Pedro Trujillo on 10/20/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class CounterCell: UITableViewCell
{

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var countStepper: UIStepper!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
