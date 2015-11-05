//
//  TipsTableViewController.swift
//  IronTips
//
//  Created by Ben Gohlke on 11/5/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class TipsTableViewController: UITableViewController, UITextFieldDelegate
{

    var tips = [PFObject]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addTip:")
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        if PFUser.currentUser() == nil
        {
            performSegueWithIdentifier("ShowLoginModalSegue", sender: self)
        }
        else
        {
            refreshTips()
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return tips.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TipCell", forIndexPath: indexPath) as! TipCell

        let aTip = tips[indexPath.row]
        if let comment = aTip["comment"] as? String
        {
            if comment == ""
            {
                cell.textField.becomeFirstResponder()
            }
            else
            {
                cell.textField.text = comment
            }
        }
        else
        {
            cell.textField.becomeFirstResponder()
        }

        return cell
    }
    
    // MARK: - Parse Queries
    
    func refreshTips()
    {
        if PFUser.currentUser() != nil
        {
            let query = PFQuery(className: "Tip")
            query.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                if error == nil
                {
                    self.tips = objects!
                    self.tableView.reloadData()
                }
                else
                {
                    print(error?.localizedDescription)
                }
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Action Handlers
    
    @IBAction func unwindToTipsTableViewController(unwindSegue: UIStoryboardSegue)
    {
        refreshTips()
    }
    
    @IBAction func addTip(sender: UIBarButtonItem)
    {
        let aTip = PFObject(className: "Tip")
        tips.insert(aTip, atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    // MARK: - TextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        var rc = false
        
        if textField.text != ""
        {
            rc = true
            
            textField.resignFirstResponder()
            let contentView = textField.superview
            let cell = contentView?.superview as? TipCell
            let indexPath = tableView.indexPathForCell(cell!)
            let aTip = tips[indexPath!.row]
            aTip["comment"] = textField.text
            aTip.saveInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if succeeded
                {
                    // object was saved to Parse
                }
                else
                {
                    print(error?.localizedDescription)
                }
            }
        }
        
        return rc
    }

}
