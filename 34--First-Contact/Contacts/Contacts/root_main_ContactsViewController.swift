//
//  root_main_ContactsViewController.swift
//  Contacts
//
//  Created by Pedro Trujillo on 11/22/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit
import RealmSwift

class root_main_ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableSortSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    let realm = try! Realm()
    var contacts: Results<Contact>!
    var currentCreateAction : UIAlertAction!


    override func viewDidLoad()
    {
        super.viewDidLoad()
        contacts = realm.objects(Contact).sorted("name")
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
        return contacts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath)
        let aContact = contacts[indexPath.row]
        cell.textLabel?.text = aContact.name
        cell.detailTextLabel?.text = "Contacts: \(aContact.familyConunt + aContact.friendCount)"
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print("Hay que rico!!!")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let contactDetailVC = storyboard?.instantiateViewControllerWithIdentifier("ContactViewController") as! ContactViewController
        contactDetailVC.contact = contacts[indexPath.row]
        navigationController?.pushViewController(contactDetailVC, animated: true)
    }

    //MARK: - Action Handlers
    
    
    @IBAction func addContactButtonTappedAction(sender: UIBarButtonItem)
    {
        let popUpAlertController = UIAlertController(title: "Add Contact", message: "Type the information for your contact" , preferredStyle: UIAlertControllerStyle.Alert)
        
        popUpAlertController.addTextFieldWithConfigurationHandler
        { (textField) -> Void in
            textField.placeholder = "Name"
            textField.addTarget(self, action: "personNameFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        }
        popUpAlertController.addTextFieldWithConfigurationHandler
            { (textField) -> Void in
                textField.placeholder = "Phone number"
        }
        popUpAlertController.addTextFieldWithConfigurationHandler
            { (textField) -> Void in
                textField.placeholder = "Email"
        }
        popUpAlertController.addTextFieldWithConfigurationHandler
            { (textField) -> Void in
                textField.placeholder = "Birthday"
        }
       
//        let datepicker:AlertdatePickerViewController = AlertdatePickerViewController()
        
//        popUpAlertController.addChildViewController(datepicker)
//        popUpAlertController.childViewControllers
        
        
        currentCreateAction = UIAlertAction(title: "Create", style: UIAlertActionStyle.Default)
        {
            (action:UIAlertAction) -> Void in
            
            var arrayTextFields = popUpAlertController.textFields
            
            let contactName = popUpAlertController.textFields?.first?.text
            let contactNumber = arrayTextFields?.removeAtIndex(1)
            let contactEmail = arrayTextFields?.removeAtIndex(1)// popUpAlertController.textFieldAtIndex(2).text
            let contactBirthday = arrayTextFields?.removeAtIndex(1)//popUpAlertController.textFieldAtIndex(3)?.text

            
            let newContact = Contact()
            
            newContact.name = contactName!
            newContact.email = (contactEmail?.text)!
            newContact.phone = (contactNumber?.text)!
            newContact.birthdaty = (contactBirthday?.text)!
            
            
            try! self.realm.write({ () -> Void in
                self.realm.add(newContact)
                self.tableView.reloadData()
            })
        }
        
        popUpAlertController.addAction(currentCreateAction)
        currentCreateAction.enabled = false
        
        popUpAlertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(popUpAlertController, animated: true, completion: nil)
        
        self.tableView.reloadData()

    }
    @IBAction func changeSortCriteria(sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0
        {
            contacts = contacts.sorted("name")
        }
        else if sender.selectedSegmentIndex == 1
        {
            contacts = contacts.sorted("friendCount", ascending: false)
        }
        else
        {
            contacts = contacts.sorted("familyConunt", ascending: false)
        }
        
        tableView.reloadData()
    }
    
    
    //MARK - Configuration Text Fields
    
    func personNameFieldDidChange(sender: UITextField)
    {
        self.currentCreateAction.enabled = sender.text?.characters.count > 0
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

class AlertdatePickerViewController: UIViewController
{
    var datePicker:UIDatePicker!
    var dateTextField:UITextField!
    
    override func viewDidLoad()
    {
        let customView:UIView = UIView (frame: CGRectMake(0, 100, 320, 160))
        dateTextField = UITextField(frame: CGRectMake(0, 0, 320, 50))
        customView .addSubview(dateTextField)
        customView.backgroundColor = UIColor.brownColor()
        datePicker = UIDatePicker(frame: CGRectMake(0, 0, 320, 160))
        customView .addSubview(datePicker)
        dateTextField.inputView = customView
        let doneButton:UIButton = UIButton (frame: CGRectMake(100, 100, 100, 44))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.addTarget(self, action: "datePickerSelected", forControlEvents: UIControlEvents.TouchUpInside)
        doneButton.backgroundColor = UIColor .blueColor()
        dateTextField.inputAccessoryView = doneButton
    }
    
    func datePickerSelected() {
        dateTextField.text =  datePicker.date.description
    }
}