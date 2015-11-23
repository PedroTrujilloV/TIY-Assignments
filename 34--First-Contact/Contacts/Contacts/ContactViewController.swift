//
//  ContactViewController.swift
//  Contacts
//
//  Created by Pedro Trujillo on 11/23/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit
import RealmSwift


class ContactViewController: UIViewController {

    @IBOutlet weak var contactCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var contact: Contact?
    var allContacts: Results<Contact>!
    var modeSelectionfamily = false
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        allContacts = realm.objects(Contact).filter("name != %@", contact!.name).sorted("name")
        updateContactsLabel()
    }
    
    func updateContactsLabel()
    {
        let thing = (contact!.friendCount == 1 ? "" : "s")

        contactCountLabel.text = "\(contact!.name) has \(contact!.friendCount) friend\(thing) and \(contact?.familyConunt) family"
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
        return allContacts.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return "Add some Contacts"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath)
        
        let aPosibleContact = allContacts[indexPath.row]
        cell.textLabel?.text = aPosibleContact.name
        let results = contact!.friends.filter("name == %@", aPosibleContact.name)
        
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
        
        if modeSelectionfamily == false
        {
            if cell?.accessoryType == UITableViewCellAccessoryType.None
            {
                cell?.accessoryType = .Checkmark
                try! realm.write { () -> Void in
                    self.contact!.friends.append(self.allContacts[indexPath.row])
                    self.contact!.friendCount++
                }
                updateContactsLabel()
            }
            else
            {
                cell?.accessoryType = .None
                try! realm.write { () -> Void in
                    let index = self.contact!.friends.indexOf(self.allContacts[indexPath.row])
                    self.contact!.friends.removeAtIndex(index!)
                    self.contact!.friendCount--
                }
                updateContactsLabel()
            }
        }
        else
        {
            if cell?.accessoryType == UITableViewCellAccessoryType.None
            {
                cell?.accessoryType = .Checkmark
                try! realm.write { () -> Void in
                    self.contact!.family.append(self.allContacts[indexPath.row])
                    self.contact!.familyConunt++
                }
                updateContactsLabel()
            }
            else
            {
                cell?.accessoryType = .None
                try! realm.write { () -> Void in
                    let index = self.contact!.family.indexOf(self.allContacts[indexPath.row])
                    self.contact!.family.removeAtIndex(index!)
                    self.contact!.familyConunt--
                }
                updateContactsLabel()
            }
        }
    }
    
    @IBAction func changeSortCriteria(sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0
        {
            allContacts = allContacts.sorted("friendCount", ascending: false)
        }
        else
        {
            allContacts = allContacts.sorted("familyConunt", ascending: false)
        }
        
        tableView.reloadData()
    }
}