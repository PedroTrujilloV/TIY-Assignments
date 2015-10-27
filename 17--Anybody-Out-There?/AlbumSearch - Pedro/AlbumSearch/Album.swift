//
//  Album.swift
//  AlbumSearch
//
//  Created by Pedro Trujillo on 10/27/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import Foundation

struct Album
{
    let title: String
    let price: String
    let thumbnailImageURL: String
    let largeImageURL: String
    let itemURL: String
    let artistURL: String
    
    init(name:String, price:String, thumbnailImageURL:String, largeImageURL:String, itemURL: String, artistURL: String)
    {
        self.title = name
        self.price = price
        self.thumbnailImageURL = thumbnailImageURL
        self.largeImageURL = largeImageURL
        self.itemURL = itemURL
        self.artistURL = artistURL
    }
    
    static func albumsWithJSON(results: NSArray) ->[Album]
    {
        var albums = [Album]()
        
        if results.count > 0
        {
            for result in results
            {
                var name = result["artistName"] as? String
                if name == nil
                {
                    name = result["trackName"] as? String
                    if name == nil
                    {
                        name == result["collectionName"] as? String
                    }
                }
                
                var price = result["formattedPrice"] as? String
                if price == nil
                {
                    price = result["collectionPrice"] as? String
                    
                        if price == nil
                        {
                            let priceFloat = result["collectionPrice"] as? Float
                            let nf = NSNumberFormatter()
                            nf.maximumFractionDigits = 2
                            if priceFloat != nil
                            {
                                price = "$\(nf.stringFromNumber(priceFloat!)!)"
                            }
                        }

                }
                let thumbnailURL = result["artworkUrl60"] as? String ?? ""
                let imageURL = result["artworkUrl100"] as? String ?? ""
                let artistURL = result["artistViewUrl"] as? String ?? ""
                var itemURL = result["collectionViewUrl"] as? String
                if itemURL == nil
                {
                        itemURL = result["trackViewUrl"] as? String
                }
                albums.append(Album(name: name!, price: price!, thumbnailImageURL: thumbnailURL, largeImageURL: imageURL, itemURL: itemURL!, artistURL: artistURL))

            }
        }
        
        return albums
    }
}