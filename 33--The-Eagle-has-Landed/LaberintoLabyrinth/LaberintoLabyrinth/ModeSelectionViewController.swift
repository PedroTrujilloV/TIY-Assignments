//
//  MainViewController.swift
//  LaberintoLabyrinth
//
//  Created by Pedro Trujillo on 12/6/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

protocol playMazeProtocolDelegate
{
    func gameResult(name:String, scoreTime:NSTimeInterval)
}

class ModeSelectionViewController: UIViewController,  UIPickerViewDataSource, UIPickerViewDelegate, playMazeProtocolDelegate
{
    
    @IBOutlet var modePicker: UIPickerView!
    
    var modesArray: Array<String>!
    var modesDict: Dictionary = ["":[Int]()]

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        modesArray = [ "Easy", "Medium", "Dificult"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return modesArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return modesArray[row]
    }

    @IBAction func PlayTapped(sender: UIButton)
    {
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        if segue.identifier == "ShowMazeViewControllerSegue"
        {
            let mazeVC = segue.destinationViewController as! MazeViewController
            mazeVC.delegator = self
            mazeVC.mazeSize = 34
            mazeVC.numberOfBalls = 2
            mazeVC.mazeHightRows = 1
        }
    }
    
    // MARK: - Game protocol
    
    func gameResult(name:String, scoreTime:Double)
    {
        print("name:")
        print(name)
        print("scoreTime")
        print(scoreTime)
    }
    

}
