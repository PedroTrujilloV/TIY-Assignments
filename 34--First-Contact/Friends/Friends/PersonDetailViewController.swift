//
//  PersonDetailViewController.swift
//  Friends
//
//  Created by Ben Gohlke on 11/19/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import RealmSwift

class PersonDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{

    @IBOutlet weak var friendCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var person: Person?
    var allPeople: Results<Person>!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        allPeople = realm.objects(Person).filter("name != %@", person!.name).sorted("name")
        updateFriendCountLabel()
    }
    
    func updateFriendCountLabel()
    {
        friendCountLabel.text = "\(person!.name) has \(person!.friendCount) friend\(person!.friendCount == 1 ? "" : "s")"
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableView Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return allPeople.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Add some friends"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath)
        
        let aPossibleFriend = allPeople[indexPath.row]
        cell.textLabel?.text = aPossibleFriend.name
        let results = person!.friends.filter("name == %@", aPossibleFriend.name)
        if results.count == 1
        {
            cell.accessoryType = .Checkmark
        }
        else
        {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell?.accessoryType == UITableViewCellAccessoryType.None
        {
            cell?.accessoryType = .Checkmark
            try! realm.write { () -> Void in
                self.person!.friends.append(self.allPeople[indexPath.row])
                self.person!.friendCount++
            }
            updateFriendCountLabel()
        }
        else
        {
            cell?.accessoryType = .None
            try! realm.write { () -> Void in
                let index = self.person!.friends.indexOf(self.allPeople[indexPath.row])
                self.person!.friends.removeAtIndex(index!)
                self.person!.friendCount--
            }
            updateFriendCountLabel()
        }
    }
}