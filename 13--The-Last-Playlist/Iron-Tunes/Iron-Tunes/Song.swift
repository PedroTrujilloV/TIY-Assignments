//
//  Song.swift
//  Iron-Tunes
//
//  Created by Pedro Trujillo on 10/21/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import Foundation
import AVFoundation


class Song
{
    let title: String
    let artist: String
    let fileName: String
    let albumArtworkName : String
    
    let playerItem: AVPlayerItem
    
    
    init(title:String, artist:String, fileName:String, albumArtworkName: String)
    {
        self.title = title
        self.artist = artist
        self.fileName = fileName
        self.albumArtworkName = albumArtworkName
        
        self.playerItem = AVPlayerItem(URL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(self.fileName, ofType: "mp3")!))
    }
}