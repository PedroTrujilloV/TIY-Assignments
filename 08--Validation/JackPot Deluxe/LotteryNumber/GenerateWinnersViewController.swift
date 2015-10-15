//
//  GenerateWinnersViewController.swift
//  LotteryNumber
//
//  Created by Pedro Trujillo on 10/14/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class GenerateWinnersViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    
    
    @IBOutlet var picker: UIPickerView!
    var delegate:WinerTicketDelegate?
    var arrayWinner = Array<Int>()
    var array:[Int:Int]!
    var arrayTickets = Array<Ticket>()


    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        array = [:]
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
  
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
    
        
        for var x = 0; x < 6; x++
        {
            arrayWinner.append(picker.selectedRowInComponent(x))
        }
        
        delegate?.winnerTicketWasChosen(arrayTickets)
    }
    
    
    
    //MARK: Initialize functions for detection
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 6
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return 53
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
       
        return "\(row)"
    }

    
    //MARK: - Compare Function
    func compareTicket(ticketA: Ticket, ticketB:Ticket) ->Int
    {

        var hits = 0
        for num in ticketA.ArrayNumbers
        {
            if ticketB.ArrayNumbers.contains(num)
            {
                hits++
            }
        }
        return hits
    }
    
    
    //MARK: - Action Buton to generate and Compare
    @IBAction func GenerateWinnersNumberCompare(sender: UIButton)
    {
//        for var x = 0; x < 6; x++
//        {
//            array[x] = picker.selectedRowInComponent(x)
//        }
        
        
        for var x = 0; x < 6; x++
        {
            arrayWinner.append(picker.selectedRowInComponent(x))
        }
        
        for ticketInArray in arrayTickets
        {
            var ticket = Ticket(arrayNumbers: arrayWinner, winningStatus: true, dollarAmount: 100)
            switch compareTicket(ticketInArray, ticketB:ticket)
            {
            case 3:
                ticketInArray.dollarAmount = 1
                ticketInArray.winningStatus = true
                print("case 3")
            case 4:
                ticketInArray.dollarAmount = 5
                ticketInArray.winningStatus = true
                print("case 4")
            case 5:
                ticketInArray.dollarAmount = 20
                ticketInArray.winningStatus = true
                print("case 5")
            case 6:
                ticketInArray.dollarAmount = 100
                ticketInArray.winningStatus = true
                print("case 6")
            default:
                ticketInArray.dollarAmount = 0
                ticketInArray.winningStatus = false
            }
        }
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
