//
//  CalculationTableViewCell.swift
//  High Voltage
//
//  Created by Pedro Trujillo on 10/22/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class CalculationTableViewCell: UITableViewCell
{

    @IBOutlet weak var calculationLabel: UILabel!
    @IBOutlet weak var calculationTextField: UITextField!
    
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
