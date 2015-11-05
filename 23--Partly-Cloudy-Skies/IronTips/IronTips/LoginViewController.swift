//
//  LoginViewController.swift
//  IronTips
//
//  Created by Pedro Trujillo on 11/4/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController, UITextFieldDelegate
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
    
    func userCanSing() -> Bool
    {
        
        if usernameTextField.text != "" && passordTextField.text != ""
        {
            return true
        }
        
        return false
    }
    
    @IBAction func sinInTapped(sender: UIButton)
    {
        if userCanSing()
        {
            PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passordTextField.text!, block:
            {
                (user: PFUser?, error: NSError?) -> Void in
                

                if user !== nil
                {print("login successful!")}
                else
                {print("error: "+(error?.localizedDescription)!)}
                
            })
        }
    }

}
