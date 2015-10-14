//
//  FormTableViewController.swift
//  Valdator
//
//  Created by Pedro Trujillo on 10/14/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class FormTableViewController: UITableViewController, UITextFieldDelegate
{
    @IBOutlet weak var nameTextField:UITextField!
    @IBOutlet weak var addTextField:UITextField!
    @IBOutlet weak var cityTextField:UITextField!
    @IBOutlet var stateTextField:UITextField!
    @IBOutlet var zipCodeTextField:UITextField!
    @IBOutlet var phoneNumberTextField:UITextField!
    
    
    let validator = Validator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField:UITextField)->Bool // to validate and change the focus and keyboard jumping between textfields
    {
        switch textField
        {
            case nameTextField:
                if validator.ValidateName(textField.text!)
                {
                    addTextField.becomeFirstResponder()
                }
            
            case addTextField:

                if validator.ValidateAddress(addTextField.text!)
                {
                    cityTextField.becomeFirstResponder()
                }
            
            case cityTextField:
                if validator.ValidateCity(cityTextField.text!)
                {
                    stateTextField.becomeFirstResponder()
                }
            
            case stateTextField:
                if validator.ValidateState(stateTextField.text!)
                {
                    zipCodeTextField.becomeFirstResponder()
                }
            
            case  zipCodeTextField:
                
                if validator.ValidateZipCode(zipCodeTextField.text!)
                {
                    phoneNumberTextField.becomeFirstResponder()
                }
            
            case phoneNumberTextField:
                
                if validator.ValidatePhoneNumber(phoneNumberTextField.text!)
                {
                    phoneNumberTextField.resignFirstResponder()
                }
            
            default:
                textField.resignFirstResponder()
            
        }
        return true
        
    }

    // MARK: - Table view data source

    

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
