//
//  LoginViewController.swift
//  IronTips
//
//  Created by Ben Gohlke on 11/4/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController
{
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
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
    
    func userCanSignIn() -> Bool
    {
        if usernameTextField.text != "" && passwordTextField.text != ""
        {
            return true
        }
        
        return false
    }
    
    @IBAction func signInTapped(sender: UIButton)
    {
        if userCanSignIn()
        {
        PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil
                {
                    print("login successful")
                    self.performSegueWithIdentifier("UnwindFromLoginSegue", sender: self)
                }
                else
                {
                    print(error?.localizedDescription)
                }
            }
        }
    }

}
