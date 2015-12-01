//
//  TaskCell.swift
//  InDueTime
//
//  Created by Pedro Trujillo on 10/20/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell
{

    @IBOutlet weak var indexTaskLabel: UILabel!
    
    @IBOutlet weak var titleTaskLabel: UITextField!
    
    @IBOutlet weak var statusTaskSwitch: UISwitch!
    
    //@IBOutlet weak var dueDateTaskLabel: UILabel!
    
    @IBOutlet weak var setDueDateButton: UIButton!
    //@IBOutlet weak var dueDateTaskButton: UIButton!
    
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
