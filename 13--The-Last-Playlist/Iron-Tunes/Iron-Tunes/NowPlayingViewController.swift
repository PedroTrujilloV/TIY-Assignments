//
//  ViewController.swift
//  Iron-Tunes
//
//  Created by Pedro Trujillo on 10/21/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class NowPlayingViewController: UIViewController
{
    
    @IBOutlet weak var songTitleLabel:UILabel!
    @IBOutlet weak var artistLabel:UILabel!
    @IBOutlet weak var albumArtwork: UIImageView!
    
    @IBOutlet weak var playPauseButton: UIButton!
    
    var songs = Array<Song>()
    var currentSong: Song?
    var nowPlaying: Bool = false
    
    let avQueuePlayer = AVQueuePlayer()
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupAudioSession()
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    //MARK: - Action Handlers
    
    @IBAction func playPausedTapped(sender: UIButton)
    {
        
    }
    
    @IBAction func skipForwardTapped(sender: UIButton)
    {
        
    }
    @IBAction func skipBackTapped(sender: UIButton)
    {
        
    }
    
    //MARK: - Audio
    
    func setupAudioSession()
    {
        AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool) -> Void in
            
            if granted
            {
                do
                {try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)}
                catch _
                {}
                do{ try AVAudioSession.sharedInstance().setActive(true)}
                catch _
                {}
            }
            else
            {
                print("Audio session could not be configured: user denied permission")
            }
            
            } )
    }
    
    func configurePlaylist()
    {
        let acoustic = Song(title: "Happiness", artist: "Benjamin Tissot", fileName: "happiness", albumArtworkName: "Acoustic")
        let dubstep = Song(title: "Happiness", artist: "Benjamin Tissot", fileName: "happiness", albumArtworkName: "Acoustic")
        let acoustic = Song(title: "Happiness", artist: "Benjamin Tissot", fileName: "happiness", albumArtworkName: "Acoustic")
        let acoustic = Song(title: "Happiness", artist: "Benjamin Tissot", fileName: "happiness", albumArtworkName: "Acoustic")
        let acoustic = Song(title: "Happiness", artist: "Benjamin Tissot", fileName: "happiness", albumArtworkName: "Acoustic")
        let acoustic = Song(title: "Happiness", artist: "Benjamin Tissot", fileName: "happiness", albumArtworkName: "Acoustic")
        let acoustic = Song(title: "Happiness", artist: "Benjamin Tissot", fileName: "happiness", albumArtworkName: "Acoustic")
        let acoustic = Song(title: "Happiness", artist: "Benjamin Tissot", fileName: "happiness", albumArtworkName: "Acoustic")
    }

}

