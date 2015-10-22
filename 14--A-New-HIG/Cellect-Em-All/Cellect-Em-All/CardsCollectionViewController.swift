//
//  CardsCollectionViewController.swift
//  Cellect-Em-All
//
//  Created by Pedro Trujillo on 10/22/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit


protocol CharacterListTableViewControllerDelegate
{
    func characterWasChosen(chosenCharacter: String)
}

class CardsCollectionViewController: UICollectionViewController, UIPopoverPresentationControllerDelegate, CharacterListTableViewControllerDelegate
{
    var visibleCards = [String]()
    
    let allCards = ["Obi-Wan Kenobi": "Kenobi.jpg", "Leia Organa": "Organa.jpg", "R2-D2": "R2.jpg", "Luke Skywalker": "Skywalker.jpg", "Grand Moff Tarkin": "Tarkin.jpg", "Darth Vader": "Vader.jpg"]
    
    var remainingCharacters = ["Obi-Wan Kenobi", "Leia Organa", "R2-D2", "Luke Skywalker", "Grand Moff Tarkin", "Darth Vader"]
    

    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "Collect 'Em-All"
        
        //visibleCards.append("Luke Skywalker")
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ShowCharacterListPopoverSegue"
        {
            let destVC = segue.destinationViewController as! CharacterListTableViewController
            destVC.characters = remainingCharacters
            destVC.popoverPresentationController?.delegate = self
            destVC.delegate = self //CharacterListTableViewControllerDelegate
            let contentHeight = 44.0 * CGFloat(remainingCharacters.count)
            destVC.preferredContentSize = CGSizeMake(200.0, contentHeight)
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of items
        return visibleCards.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CardCollectionViewCell", forIndexPath: indexPath) as! CardCollectionViewCell
    
        // Configure the cell
        let characterName = visibleCards[indexPath.item] // now is "item" besides  row but is almost same
        cell.nameLabel.text = characterName
        cell.imageView.image = UIImage(named: allCards[characterName]!)
    
        return cell
    }
    
 

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
    //MARK: - UIPopoverPresentationController Delegate
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return  .None
    }
    
    //MARK: CharacterListTableViewController Delegate
    
    func characterWasChosen(chosenCharacter: String)
    {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
        visibleCards.append(chosenCharacter)
        
        let rowToRemove = (remainingCharacters as NSArray).indexOfObject(chosenCharacter)
        
        remainingCharacters.removeAtIndex(rowToRemove)
        
        collectionView?.reloadData()
    }
}
