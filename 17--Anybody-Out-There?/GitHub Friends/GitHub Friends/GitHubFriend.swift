//
//  GitHubFriend.swift
//  GitHub Friends
//
//  Created by Pedro Trujillo on 10/27/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import Foundation

struct GitHubFriend
{
    let name: String
    let login: String
    let thumbnailImageURL: String
    let largeImageURL: String
    let email:String
    let company: String
    let location: String
    
    
    init(name:String, login:String, thumbnailImageURL:String, largeImageURL:String, company: String, location: String, email: String)
    {
        self.name = name
        self.login = login
        self.thumbnailImageURL = thumbnailImageURL+"&s=96"
        self.largeImageURL = largeImageURL
        self.email = email
        self.company = company
        self.location = location
        
        print("name: \(self.name )")
        print("self.login: \(self.login)")
        print("self.thumbnailImageURL: \(self.thumbnailImageURL)")
        print("self.location: \(self.location)")
        
       
    }
    
    static func friendsWithJSON(results: NSArray) ->[GitHubFriend]
    {
        var gitHubFriends = [GitHubFriend]()
        
        if results.count > 0
        {
            for result in results
            {
                var emailUser = result["email"] as? String
                if emailUser == nil
                {
                    emailUser = result["blog"] as? String
                    if emailUser == nil
                    {
                        emailUser == " no public email :("
                    }
                }
                
                let nameUser = result["name"] as? String ?? ""
                let loginUser = result["login"] as? String ?? ""
                let thumbnailURL = result["avatar_url"] as? String ?? ""
                let imageURL = result["avatar_url"] as? String ?? ""
                let locationUser = result["location"] as? String ?? ""
                let companyUser = result["company"] as? String
               
                gitHubFriends.append(GitHubFriend(name: nameUser, login: loginUser, thumbnailImageURL: thumbnailURL, largeImageURL: imageURL, company: companyUser!, location: locationUser, email: emailUser!))
                print("Im here")
            }
        }
        
        return gitHubFriends
    }
}