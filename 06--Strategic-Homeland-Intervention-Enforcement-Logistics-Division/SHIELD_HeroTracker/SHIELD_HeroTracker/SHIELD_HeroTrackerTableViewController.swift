//
//  SHIELD_HeroTrackerTableViewController.swift
//  SHIELD_HeroTracker
//
//  Created by Pedro Trujillo on 10/12/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit

//protocol HeroDetailDelegate
//{
//    func showHeroSHIELD(controler: UITableViewController, anHero:Hero)
//}

class SHIELD_HeroTrackerTableViewController: UITableViewController
{
    var customHeroModels = Array<Hero>()
    var heroes = Array<Hero>()
    let filePathName = "heroes"
    let typeOf = "json"
    
   // var delegate: HeroDetailDelegate!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "S.H.I.E.L.D Agent Tracker" //if there is time change font and size
        
        loadHeroesList()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return heroes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("AgentSHIELDcell", forIndexPath: indexPath)
        
        // Configure the cell...
        
        
        let anHeroSHIELD = heroes[indexPath.row]
        cell.textLabel!.text = anHeroSHIELD.name
        cell.detailTextLabel!.text = anHeroSHIELD.homeworld
        
        return cell
    }
 
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)///select the row !!
    {
//        let row = indexPath.row //2
//        //let section = indexPath.section//3
//        let anHeroSHIELD = heroes[indexPath.row]
//        delegate?.showHeroSHIELD(self, anHero: anHeroSHIELD)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let selectedHero = heroes[indexPath.row]
        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("HeroDetailViewController") as! HeroDetailViewController
        detailVC.hero = selectedHero 
        navigationController?.pushViewController(detailVC, animated: true)
    }
    

    //MARK: - Private:
    
    private func loadHeroesList()
    {
        
        do
        {
            let heroesFilePath = NSBundle.mainBundle().pathForResource(filePathName, ofType: typeOf)
            let heroDataFromFile = NSData(contentsOfFile: heroesFilePath!)
            let heroData = try NSJSONSerialization.JSONObjectWithData(heroDataFromFile!, options: []) as! NSArray
            var tempArr = Array<Hero>()
            for hero in heroData
            {
                let newHero = Hero(heroDictionary: hero as! NSDictionary)
                tempArr.append(newHero)
            }
            
            //tempArr.sortInPlace({$0.name < $1.name})
            
            //heroes = tempArr
            
            
            heroes = tempArr.sort(getMaxLexicographic)
            
          
        }
        catch let error as NSError
        {
            print("Error loading file \(filePathName).\(typeOf) error information: \(error)")
        }
        
    }
    
    func getMaxLexicographic(H1:Hero, _ H2:Hero)->Bool
    {
        return H1.name < H2.name
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier ==  "ShowHeroDetailSegue"
        {
            let heroDetails = segue.destinationViewController as! HeroDetailViewController
            //heroDetails.delegate = self
            
        }
    }
   /* */

}
