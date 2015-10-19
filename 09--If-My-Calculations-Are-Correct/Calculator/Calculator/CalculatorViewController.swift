//
//  ViewController.swift
//  Calculator
//
//  Created by Pedro Trujillo on 10/15/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController
{
    @IBOutlet weak var displayLabel:UILabel!

    var calculationTransaction:CalculatorBrain = CalculatorBrain()
    var bufferArray = Array<String>()
    var bufferString: String = "0"
    var operationBufferString: String = ""
    var previusButtonPushed:UIButton!
    var dotTyped:Bool = false
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//MARK: - Actions Buttons
    
    @IBAction func operatorButtons(sender: UIButton)
    {

        if previusButtonPushed != nil
        {
            previusButtonPushed.titleLabel?.textColor = UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1)
        }
        //print("\(sender.titleLabel?.textColor)")
        sender.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        previusButtonPushed = sender
        
        //print("\(sender.currentTitle!)")
        
        
        
        let operation = sender.currentTitle!
        equalTo()
        operationBufferString = operation
        
        //show result
        let result = calculationTransaction.calculateValue()
        printInDisplay("\(result)")
            
        //clean
        //bufferString = "0"
        
        
        /////
        print(bufferArray)
        print(bufferString)
        print(calculationTransaction.calculateValue())
        
    }
    
    @IBAction func numericButtons(sender: UIButton)
    {
        let digit = sender.currentTitle!
       
        
        bufferArray.append(digit)
        bufferString = bufferArray.joinWithSeparator("") //convert from Array to string
        printInDisplay(bufferString)
        
        /////
        print(bufferArray)
        print(bufferString)
        print(calculationTransaction.calculateValue())
    }
    
    @IBAction func resultButton(sender: UIButton)
    {
        if previusButtonPushed != nil
        {
            previusButtonPushed.titleLabel?.textColor = UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1)
        }
        
        equalTo()

        let result = "\(calculationTransaction.calculateValue())"
        printInDisplay(result)
        bufferString = result
        
        //clean
        //operationBufferString=""
        
        //new change to optimize
        let temporalStore = bufferString
        clean()
        bufferString = temporalStore
        
        printInDisplay(bufferString)
    }
    
    
    @IBAction func cleanAllButton(sender: UIButton)
    {
        if previusButtonPushed != nil
        {
            previusButtonPushed.titleLabel?.textColor = UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1)
        }
        
        clean()
    }
    
//MARK: - Helper Functions 
    
    func equalTo()
    {
        calculationTransaction.appendValue(bufferString)
        calculationTransaction.appendBufferCalculations(operationBufferString)
        
        /// clean
        bufferArray = []
        
    }
    
    func printInDisplay(msj:String)
    {
        self.displayLabel.text = "\(msj)"// \(operationBufferString)"
    }

    func clean()
    {
       
        calculationTransaction.cleanAll()
        operationBufferString=""
        bufferString = ""
        bufferArray = []
        printInDisplay("0")
    }

}

