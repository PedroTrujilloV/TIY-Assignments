//
//  PopoverAddCityViewController.swift
//  MuttCuttsHitsTheRoad
//
//  Created by Pedro Trujillo on 10/28/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class PopoverAddCityViewController: UIViewController,UITextFieldDelegate
{
    @IBOutlet weak var cityTextFiled: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    
    var delegator:PopoverViewControllerProtocol!
    var cityAndStateArray = Array<String>()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cityTextFiled.text = ""
        stateTextField.text = ""
        cityTextFiled.becomeFirstResponder()
        
        
        //delegator?.operatorWasChosen(selectedOperation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cityEditingDidEnd(sender: UITextField)
    {
        
        if sender.text != ""
        {
            cityAndStateArray.append(sender.text!)
            stateTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func stateEditionDidEnd(sender: UITextField)
    {
        if sender.text != ""
        {
            cityAndStateArray.append(sender.text!)
            let searchString = cityAndStateArray.joinWithSeparator(", ")
            delegator?.cityWasChosen(searchString)
            cityAndStateArray = []
            
        }
        //sender.resignFirstResponder()
    }
    
    //MARK: - UITextField Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        
        var rc = false
        
        if textField.text != ""
        {
            rc = true
            //cityAndStateArray.append(textField.text!)
            textField.resignFirstResponder()
            
            
        }
        
        return rc
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
