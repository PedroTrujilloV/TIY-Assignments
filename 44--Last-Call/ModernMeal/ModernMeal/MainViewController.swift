//
//  ViewController.swift
//  ModernMeal
//
//  Created by Pedro Trujillo on 12/4/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

protocol APIControllerProtocol
{
    func didReceiveAPIResults(results:Array<Int>)
    func didReceiveAPIResults2(results:Array<Int>)
    
}
protocol HTTPControllerProtocol
{
    func didReceiveHTTPResults(token:String)
    
}
class MainViewController: UIViewController, UITextFieldDelegate, NSURLSessionDelegate, HTTPControllerProtocol, APIControllerProtocol
{
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var httpController: HTTPController!
    var api: APIController!
    
    //var

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        httpController = HTTPController(delegate:self)
        api = APIController(delegate: self)        //create instance of API controller with self
        httpController.singIn()
        
//       usernameTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInTapped(sender: UIButton)
    {
        //UIApplication.sharedApplication().networkActivityIndicatorVisible = true
//        httpController.singIn()
        
//        usernameTextField.resignFirstResponder()
//        passwordTextField.resignFirstResponder()
        
    }
    
    //MARK: Protocol functions
    
    func didReceiveHTTPResults(token:String)
    {
        dispatch_async(dispatch_get_main_queue(),
        {
                self.api.getListOfGroceryListsFromAPIModernMeal(token)
                
        })
    }
    
    func didReceiveAPIResults(results:Array<Int>)
    {
        dispatch_async(dispatch_get_main_queue(),
        {
                print(results)
                self.api.getGroceryListFromAPIModernMeal(results)


        })
    }
    
    func didReceiveAPIResults2(results:Array<Int>)
    {
        dispatch_async(dispatch_get_main_queue(),
        {
                print("didReceiveAPIResults2")
                print(results)
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }

        
    

}

