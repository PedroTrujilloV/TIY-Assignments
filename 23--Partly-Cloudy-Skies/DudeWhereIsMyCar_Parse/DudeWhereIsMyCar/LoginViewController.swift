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
    
    @IBOutlet weak var alertMessageLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Dude login"
        
        alertMessageLabel.text = ""

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
       
        
        
       
    }
    
    
    func userCanSing() -> Bool
    {
        
        if usernameTextField.text != "" && passordTextField.text != ""
        {
            return true
        }
        
        return false
    }
    
    @IBAction func signInTapped(sender: UIButton)
    {
        
        if userCanSing()
        {
            PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passordTextField.text!, block:
                {
                    (user: PFUser?, error: NSError?) -> Void in
                    
                    
                    if user != nil
                    {
                        print("login successful!")
                        print(user?.description)
                        
                            //let MapViewSesion = segue.destinationViewController as! MapViewController
                            //                            MapViewSesion
                        self.alertMessageLabel.text = ""
                            self.performSegueWithIdentifier("ShowMapViewControllerSegue", sender: self)
      
                    }
                    else
                    {
                        print("User no registered")
                        self.alertMessageLabel.text = "Sorry, user no registered, please create an account."
                        print("error: "+(error?.localizedDescription)!)
                    }
                    
            })
        }

    }
    
    @IBAction func unwindFromMapViewController(sender: UIStoryboardSegue) // remember create this IBAaction every time when you want come back here from other view controller!
    {
    }

}
