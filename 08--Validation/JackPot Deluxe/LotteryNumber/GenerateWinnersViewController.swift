//
//  GenerateWinnersViewController.swift
//  LotteryNumber
//
//  Created by Pedro Trujillo on 10/14/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

class GenerateWinnersViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func compareTicket(ticketA: Ticket, ticketB:Ticket) ->Int
    {
        var count = 0
        var hits = 0
        for num in ticketA.ArrayNumbers
        {
            if ticketB.ArrayNumbers[0] == num
            {
                hits++
            }
        }
        return hits
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
