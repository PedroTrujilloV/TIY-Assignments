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
    
    var modesArray: Array<playMode> = []
    var modesDict: Dictionary = ["":[Int]()]

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //modesArray = [ "1 Easy", "1 Medium", "Dificult"]
        //modesDict = ["Easy": [20,1,1], "Medium": [30,2,1], "Dificult": [35,2,2]]

        modesArray.append(playMode(dataDictionary: ["id":"01","name":"Easy","mazeSize":"20", "numberOfBalls":"1", "mazeHightRows":"1", "idPlayer":"001", "maxScoreTime":"1234"]))
        modesArray.append(playMode(dataDictionary: ["id":"02","name":"Medium","mazeSize":"30", "numberOfBalls":"2", "mazeHightRows":"1", "idPlayer":"002", "maxScoreTime":"1234"]))
        modesArray.append(playMode(dataDictionary: ["id":"03","name":"Dificult","mazeSize":"35", "numberOfBalls":"2", "mazeHightRows":"2", "idPlayer":"001", "maxScoreTime":"1234"]))
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
        let newPlayMode = modesArray[row] as playMode
        return newPlayMode.name
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
            let aMode =  modesArray[ modePicker.selectedRowInComponent(0)] as playMode
            
            let mazeVC = segue.destinationViewController as! MazeViewController
            mazeVC.delegator = self
            mazeVC.mazeSize = aMode.mazeSize
            mazeVC.numberOfBalls = aMode.numberOfBalls
            mazeVC.mazeHightRows = aMode.mazeHightRows
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
