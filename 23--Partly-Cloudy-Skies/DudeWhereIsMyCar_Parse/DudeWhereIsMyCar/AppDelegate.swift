//
//  AppDelegate.swift
//  DudeWhereIsMyCar
//
//  Created by Pedro Trujillo on 11/3/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit
//import Parse
//import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Parse.setApplicationId("3jBrRTB9xRiXADI0Z08TWE93JXnVe7SkpG5s7nkY",
            clientKey: "kia0361iUs4n8RNTNG5bg3OjYQ4KH7BwIaklEmE0")
        
        
        // [Optional] Track statistics around application opens.
        //PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        
        //        let player = PFObject(className: "Player")
        //        player["name"] = "Pedro"
        //        player["score"] = 234
        //        player.saveInBackgroundWithBlock
        //        {
        //            (success: Bool, error: NSError?) -> Void in
        //            if success
        //            {print("YAY!!!")}
        //            else
        //            {
        //                print(error?.description)
        //            }
        //        }
        //
        //        let query = PFQuery(className: "Player")
        //        query.whereKey("score", greaterThan: 500)
        //        query.findObjectsInBackgroundWithBlock
        //        {
        //            (results: [PFObject]?, error: NSError?) -> Void in
        //            if error == nil
        //            {
        //                print(results)
        //            }
        //            else
        //            {
        //                print(error?.description)
        //            }
        //        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        let navController = window?.rootViewController as! UINavigationController
        let citiesVC = navController.viewControllers[0] as! MapViewController
        citiesVC.saveAnnotationsData()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        let navController = window?.rootViewController as! UINavigationController
        let citiesVC = navController.viewControllers[0] as! MapViewController
        //citiesVC.loadAnnotationsData()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

