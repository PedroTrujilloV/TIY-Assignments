//
//  RegisterViewController.swift
//  IronTips
//
//  Created by Pedro Trujillo on 11/4/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit


class RegisterViewController: UIViewController
{
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passordTextField: UITextField!
    
    @IBOutlet weak var alertMessageLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Dude Sign Up"
        
        alertMessageLabel.text = ""

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
    
    func signUp() -> Bool
    {
        var rc = false
        
        let user = PFUser()
        user.username = usernameTextField.text
        user.password = passordTextField.text

        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error
            {
                //let errorString = error.userInfo["error"] as? NSString
                self.alertMessageLabel.textColor = UIColor.redColor()
                self.alertMessageLabel.text = "Username already exists, try with another username"
                print("error: "+(error.localizedDescription))
                rc = false
            }
            else
            {
                // Hooray! Let them use the app now.
                self.alertMessageLabel.textColor = UIColor.greenColor()
                self.alertMessageLabel.text = "User was created, now you can log in "
                print("Este puto hizo finalmente SignUp")
                rc = true
            }
        }
        return rc
    }

    
    @IBAction func createAccount(sender: UIButton)
    {
        
        if userCanRegister() && signUp()
        {
            
            
            let user = PFUser()
            user.username = usernameTextField.text!
            user.password = passordTextField.text!
            user.email = "email@example.com"
            user["phone"] = "415-392-0202"
            
            
//            let user = PFObject(className: "login")
//                    user["username"] = usernameTextField.text
//                    user["password"] = passordTextField.text
            
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
