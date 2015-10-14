//
//  NameViewController.swift
//  SayMyName
//
//  Created by Pedro Trujillo on 10/7/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class NameViewController: UIViewController, UITextFieldDelegate
{
    //IBOutlets go here
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var messageLabel: UILabel!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        messageLabel.text = ""
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - Action Handlers
    
    @IBAction func switchValueChanged(sender: UISwitch)
    {
        if sender.on
        {
            view.backgroundColor = UIColor.greenColor()
        }
        else
        {
            view.backgroundColor = UIColor.whiteColor()
        }
    }
    
    @IBAction func goTapped(sender: UIButton)
    {
        sayHello()
    }
    
// MARK: - UITextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        return sayHello()
    }
    
// MARK: - Private
    
    func sayHello()->Bool
    {
        var rc = false
        
        if let name = nameTextField.text
        {
            rc = true
            nameTextField.resignFirstResponder()
            // this guy desapear the            keyboard and the focus in the text field :)
            let nameComponents = String(name).characters.split(" ")
            //let nameComponents = name.characters.split(" ").map{String($0)}
            messageLabel.text = "Hello!!, \(String(nameComponents[0]))"
        }
        
        return rc
    }

}

