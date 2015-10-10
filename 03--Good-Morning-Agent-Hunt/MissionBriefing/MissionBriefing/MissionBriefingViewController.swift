//
//  ViewController.swift
//  MissionBriefing
//
//  Created by Pedro Trujillo on 10/7/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class MissionBriefingViewController: UIViewController, UITextFieldDelegate
{
    // Place IBOutlet properties below
    @IBOutlet var nameTextFieldn1:UITextField!
    @IBOutlet var pswTextFieldn2:UITextField!
    @IBOutlet var messageLable:UILabel!
    @IBOutlet var mbTextView:UITextView!
    @IBOutlet var AutenticateButton:UIButton!
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //
        // 3. The three UI elements need to be emptied on launch
        //    Hint: there is a string literal that represents empty
        //
        
        nameTextFieldn1.text = ""
        pswTextFieldn2.text = ""
        messageLable.text = ""
        mbTextView.text = "Please sing in to get the gif!, Por favor ingrese para recibir el regalo!"
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        return logIn(textField.text!)
    }
    
    // MARK: - Action Handlers
    
    @IBAction func authenticateAgent(sender: UIButton)
    {
        // This will cause the keyboard to dismiss when the authenticate button is tapped
        
        let greetingNameText = nameTextFieldn1.text
        if nameTextFieldn1.isFirstResponder()////name text field property identifier goes here.isFirstResponder
        {
            nameTextFieldn1.resignFirstResponder()
            //name text field property identifier goes here.resignFirstResponder
            logIn(greetingNameText!)
        }
        
        if pswTextFieldn2.isFirstResponder()////name text field property identifier goes here.isFirstResponder
        {
            pswTextFieldn2.resignFirstResponder()
            //name text field property identifier goes here.resignFirstResponder
            logIn(greetingNameText!)
        }
        
        
    }
    
    func logIn(greetingNameText:String) ->Bool
    {
        var rc:Bool
        
        if nameTextFieldn1.text != "" && pswTextFieldn2.text != ""
        {
            
            let greetingArray = String(greetingNameText).characters.split(" ")
            
            messageLable.text = ("Good evening, Agent \(String(greetingArray[1]))")
            
            mbTextView.text = "This mission will be and arduous one, fraught with peril. You will cover much strange and unfamiliar territory. Should you choose to accept this mission, Agent \(String(greetingArray[1])), you will certainly be disavowed, but you will be doing your country a great service. This message will self destruct in 5 seconds."
            
            view.backgroundColor = UIColor(red: 0.585, green: 0.78, blue: 0.188, alpha: 1.0)
            
            rc = true
        }
        else
        {
            view.backgroundColor = UIColor(red: 0.78, green: 0.188, blue: 0.188, alpha: 1.0)
            
            mbTextView.text = "Please sing in to get the gif!, Por favor ingrese para recibir el regalo!"
            
            rc = false
        }
        return rc
    }
}

