//
//  AddItemViewController.swift
//  ModernMeal
//
//  Created by Pedro Trujillo on 12/28/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate
{
    
    @IBOutlet weak var item_nameTextField: UITextField!
    @IBOutlet weak var recipe_nameTextField: UITextField!
    @IBOutlet weak var textTextField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    var delegator: AddItemProtocol!
    var grocery_list_id: Int!
    var category_order: Array<String> = []
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - SendBack Info
    override func viewWillDisappear(animated: Bool)
    {
        let now = dateToString(NSDate())
        let dictionary = [ "id": 0,
            "grocery_list_id": grocery_list_id as NSNumber,
            "category": categoryPicker.selectedRowInComponent(0),
            "text": textTextField.text,
            "recipe_id": 0,
            "recipe_name": recipe_nameTextField.text,
            "shopped": false,
            "item_name": item_nameTextField.text,
            "created_at": now,
            "updated_at": now ]
        
        delegator.itemWasCreated(Item( ItemDict: dictionary))
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Picker Functions
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return category_order.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
        return category_order[row]
    }

    //MARK: - Helpers
    func dateToString(aDate:NSDate) -> String
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ" //http://stackoverflow.com/questions/28791771/swift-iso-8601-date-formatting-with-ios7
        let date = dateFormatter.stringFromDate(aDate)
        
        return date
        
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
