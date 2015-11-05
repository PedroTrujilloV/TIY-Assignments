//
//  RegisterViewController.swift
//  IronTips
//
//  Created by Ben Gohlke on 11/4/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
        if usernameTextField.text != "" && passwordTextField.text != ""
        {
            return true
        }
        
        return false
    }
    
    @IBAction func createAccountTapped(sender: UIButton)
    {
        if userCanRegister()
        {
            let user = PFUser()
            user.username = usernameTextField.text!
            user.password = passwordTextField.text!
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if !succeeded
                {
                    print(error?.localizedDescription)
                }
                else
                {
                    self.navigationController?.popToRootViewControllerAnimated(true)
                }
            }
        }
    }

}
