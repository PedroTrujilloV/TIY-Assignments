//
//  ViewController.swift
//  GitHub Friends
//
//  Created by Pedro Trujillo on 10/28/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate
{
    var searchBar:UITextField!
    var delegate: SearchViewProtocol!
    var friend = ""
   // var api: APIController!
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        searchBar = UITextField(frame: CGRect(x: 0, y: 80, width: UIScreen.mainScreen().bounds.width, height: 50))
        searchBar.textAlignment = .Center
        searchBar.center.x = view.center.x
        searchBar.center.y = UIScreen.mainScreen().bounds.height / 7
        searchBar.becomeFirstResponder()
        searchBar.addTarget(self, action: "SearchFriend:", forControlEvents: UIControlEvents.TouchUpInside)
        searchBar.textColor = UIColor.whiteColor()
        view.addSubview(searchBar)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func SearchFriend(sender:UITextField)
    {
        friend = sender.text!
        //api.searchGitHubFor(friend)
        print("textField: "+sender.text!)
        searchBar.resignFirstResponder()
        
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        //api.searchGitHubFor(friend)
        //delegate?.friendWasFound(friend)
        
        
        print("SearchViewController")
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
