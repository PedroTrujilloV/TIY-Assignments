//
//  RegisterViewController.swift
//  IronTips
//
//  Created by Pedro Trujillo on 11/4/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func userCanRegister() -> Bool
    {
        
        if usernameTextField.text != "" && passordTextField.text != ""
        {
            return true
        }
        
        return false
    }
    
    @IBAction func createAccount(sender: UIButton)
    {
        if userCanRegister()
        {
            
            
            let user = PFUser()
            user.username = usernameTextField.text!
            user.password = passordTextField.text!
            
            user.saveInBackgroundWithBlock
            {
                (succeded:Bool, error:NSError?) -> Void in
                if succeded
                {print("register successful!")}
                else
                {print("error: "+(error?.localizedDescription)!)}
            }
            
            
        }
    }
    

}
