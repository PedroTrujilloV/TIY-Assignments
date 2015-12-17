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
    func didReceiveListOfListsFromAPIResults(results:Array<NSDictionary>)
    
}
protocol HTTPControllerProtocol
{
    func didReceiveHTTPResults(token:String)
    
}

var api: APIController!

class MainViewController: UIViewController, UITextFieldDelegate, NSURLSessionDelegate, HTTPControllerProtocol, APIControllerProtocol
{
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var httpController: HTTPController!
    var arrayResults:Array<NSDictionary>!
    //var api: APIController!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        httpController = HTTPController(delegate:self)
        api = APIController(delegate: self)        //create instance of API controller with self
        
//       usernameTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInTapped(sender: UIButton)
    {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        httpController.singIn()
        
//        usernameTextField.resignFirstResponder()
//        passwordTextField.resignFirstResponder()
        
    }
    
    //MARK: Protocol functions
    
    func didReceiveHTTPResults(token:String)
    {
        dispatch_async(dispatch_get_main_queue(),
        {
                api.getListOfGroceryListsFromAPIModernMeal(token)
                
        })
    }
    
    func didReceiveAPIResults(results:Array<Int>)
    {
        dispatch_async(dispatch_get_main_queue(),
        {
                print(results)
                api.getGroceryListFromAPIModernMeal(results)


        })
    }
    
    func didReceiveListOfListsFromAPIResults(results:Array<NSDictionary>)
    {
        dispatch_async(dispatch_get_main_queue(),
        {
            print("didReceiveListOfListsFromAPIResults")
            //print(results)
            self.arrayResults = results
            print("----------end")
//            let taskTableVC:TasksTableViewController = TasksTableViewController()
//            taskTableVC.sincronizeCoredataAndDataBase(results)
//            //here is created the navigation controler for the app
//            let navigationController = UINavigationController(rootViewController: taskTableVC)
//            
//            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//            self.presentViewController(navigationController, animated: true, completion: nil)
//            
            self.performSegueWithIdentifier("PresentTaskTableViewControllerSegue", sender: self) //call the segue to navigate at tabBarController

        })
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "PresentTaskTableViewControllerSegue"
        {
            let taskTableVC = segue.destinationViewController as! TasksTableViewController
            taskTableVC.sincronizeCoredataAndDataBase(self.arrayResults)
            
            //here is created the navigation controler for the app
            let navigationController = UINavigationController(rootViewController: taskTableVC)
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false

        }
    }

        
    

}

