//
//  FriendListViewController.swift
//  Friends
//
//  Created by Pedro Trujillo on 11/19/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit
import RealmSwift

class FriendListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableSortSegmentedControl:UISegmentedControl!
    @IBOutlet weak var tableViewControl:UITableView!
    
    let realm = try! Realm()
    
    var people:Results<Person>!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        people = realm.objects(Person).sorted("name")
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return people.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath)
        
        let aPerson = people[indexPath.row]
        cell.textLabel?.text = aPerson.name
        cell.detailTextLabel?.text = "\(aPerson.friendCount)"
        return cell
    }
    
    @IBAction func addFriend(sender:UIBarButtonItem)
    {
        let alertController = UIAlertController(title: "Add Person", message: "Type the person's name.", preferredStyle: UIAlertControllerStyle.Alert)
        
        let createActionn = UIAlertAction(title: "Create", style: .Default)
        {
            (action:UIAlertAction) -> Void in
            let personName = alertController.textFields?.first?.text
            
            
            let newPerson = Person()
            newPerson.name = personName!
            
            try!self.realm.write(
            {
                () -> Void in
                self.realm.add(newPerson)
                self.tableViewControl.reloadData()
            })
        }
        
        alertController.addAction(createActionn)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        alertController.addTextFieldWithConfigurationHandler
        {
            (textField) -> Void in
            
            textField.placeholder = "Name"
            textField.addTarget(self, action: "personNameFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
            
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        let personDetailVC = storyboard?.instantiateViewControllerWithIdentifier("PersonDetailViewController") as! PersonDetailViewController
    }
    
    
    func personNameFieldDidChange(sender:UITextField)
    {
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
