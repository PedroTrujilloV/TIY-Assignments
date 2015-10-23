//
//  CalculationListTableViewController.swift
//  High Voltage
//
//  Created by Pedro Trujillo on 10/22/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

protocol OperatorListViewControllerDelegate
{
    func operatorWasChosen(electronicOperator: String)
}

class CalculationListTableViewController: UITableViewController, UITextFieldDelegate, UIPopoverPresentationControllerDelegate, OperatorListViewControllerDelegate
{
    
    
    @IBOutlet weak var addOperationButton: UIBarButtonItem!
    
    var calculationBrain = CalculatorBrain()
    
    var bufferOperators:String = ""
    
    var operations = Array<String>()
    
    var operatorList = ["Watts", "Volts", "Amps", "Ohms"]

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        title = "High Voltage"
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
        return operations.count//calculationBrain.bufferCalculations.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CalculationTableViewCell", forIndexPath: indexPath) as! CalculationTableViewCell

        // Configure the cell...
        
//        if calculationBrain.bufferCalculations.count == 0
//        {
//            //cell.calculationLabel.text == nil
//            cell.calculationTextField.enabled = true
//            cell.calculationTextField.text = nil
//        }
        
        print(" ")
        print(calculationBrain.bufferCalculations.count)
        print(operations.count)
        print(indexPath.row)
        

        // Extremly nescesary to hide the keyboard after insert values
            if cell.calculationTextField.text == nil || cell.calculationTextField.text == ""
            {
                if operations.count-1  < calculationBrain.bufferCalculations.count
                {
                    cell.calculationTextField.enabled = false
                    cell.calculationTextField.text = "\(calculationBrain.bufferCalculations[indexPath.row])"
                }
                else
                {
                    addOperationButton.enabled = false
                    cell.calculationTextField.becomeFirstResponder()
                }
            }
            else
            {
                addOperationButton.enabled = true
                cell.calculationTextField.text = "\(calculationBrain.bufferCalculations[indexPath.row])"
            }

        cell.calculationLabel.text = operations[indexPath.row]
    

        return cell
    }

    
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
    
    //MARK: Action handlers 
    
    
    @IBAction func RefreshList(sender: UIBarButtonItem)
    {
        
        bufferOperators = ""
        calculationBrain.cleanAll()
        operatorList = ["Watts", "Volts", "Amps", "Ohms"]
        cleanTable()
        addOperationButton.enabled = true
        
    }
    
    func cleanTable()
    {
        while operations.count > 0
        {
            let newIndexPath = NSIndexPath(forRow: operations.count-1, inSection: 0)
            
            operations.removeFirst()
            
            let cell = tableView.cellForRowAtIndexPath(newIndexPath) as! CalculationTableViewCell
            
            cell.calculationTextField.text = nil //KILL (clean) the fucking text fields motherfuckers!
            cell.calculationLabel.text = nil // and it friend
            cell.calculationTextField.enabled = true
            
            tableView.deleteRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        }
        tableView.reloadData()
    }
    
    
    
    //MARK: - UITextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        
        var rc = false
 
    
        if textField.text != "" || textField.text != nil
        {
            rc = true
            
            //let parentContentView = textField.superview
            //let cell = parentContentView?.superview as! CalculationTableViewCell
            //let indexPath = tableView.indexPathForCell(cell)

            textField.resignFirstResponder()
            calculationBrain.appendValue(textField.text!)
            tableView.reloadData()
        }
        
        return rc
    }
    
   

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ShowOperatorsListTableViewControllerSegue"
        {
            let destVC  = segue.destinationViewController as! OperatorsListTableViewController // 1
            destVC.operatorList = operatorList
            destVC.popoverPresentationController?.delegate = self // 2
            destVC.delegator = self // 3 nescessary to get the value from the popover
            let contentHight = 45.0 * CGFloat(operatorList.count)
            destVC.preferredContentSize = CGSizeMake(100.0, contentHight)
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    func operatorWasChosen(electronicOperator: String)
    {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)// this thing hides the popover
        print("operatorWasChosen:")
        print(electronicOperator)
        
        
//        bufferArray.append(electronicOperator)
//        bufferString = bufferArray.joinWithSeparator("") //convert from Array to string
//        printInDisplay(bufferString)
        
        
        operations.append(electronicOperator)
        let rowToRemove = (operatorList as NSArray).indexOfObject(electronicOperator)
        operatorList.removeAtIndex(rowToRemove)
        
        
        var wordToArray = Array(electronicOperator.characters)
        let charOperator = wordToArray.removeAtIndex(0)
        
        if operations.count < 3
        {
            bufferOperators += "\(charOperator)"
        }
        else
        {
            print(bufferOperators+"\(charOperator) was chosen")
            calculationBrain.appendBufferCalculations(bufferOperators+"\(charOperator)")
        }

        
        tableView.reloadData()
        
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }

}
