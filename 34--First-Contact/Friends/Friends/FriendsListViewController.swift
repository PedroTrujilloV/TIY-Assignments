//
//  FriendsListViewController.swift
//  Friends
//
//  Created by Ben Gohlke on 11/19/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import RealmSwift

class FriendsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet weak var tableSortSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var people: Results<Person>!
    var currentCreateAction: UIAlertAction!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        people = realm.objects(Person).sorted("name")
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(true)
        tableView.reloadData()
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
    
    @IBAction func addFriend(sender: UIBarButtonItem)
    {
        let alertController = UIAlertController(title: "Add Person", message: "Type the person's name.", preferredStyle: UIAlertControllerStyle.Alert)
        currentCreateAction = UIAlertAction(title: "Create", style: .Default) { (action) -> Void in
            let personName = alertController.textFields?.first?.text
            let newPerson = Person()
            newPerson.name = personName!
            
            try! self.realm.write({ () -> Void in
                self.realm.add(newPerson)
                self.tableView.reloadData()
            })
        }
        
        alertController.addAction(currentCreateAction)
        currentCreateAction.enabled = false
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Name"
            textField.addTarget(self, action: "personNameFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func changeSortCriteria(sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0
        {
            people = people.sorted("name")
        }
        else
        {
            people = people.sorted("friendCount", ascending: false)
        }
        tableView.reloadData()
    }
    
    func personNameFieldDidChange(sender: UITextField)
    {
        self.currentCreateAction.enabled = sender.text?.characters.count > 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let personDetailVC = storyboard?.instantiateViewControllerWithIdentifier("PersonDetailViewController") as! PersonDetailViewController
        personDetailVC.person = people[indexPath.row]
        navigationController?.pushViewController(personDetailVC, animated: true)
    }
    
}













