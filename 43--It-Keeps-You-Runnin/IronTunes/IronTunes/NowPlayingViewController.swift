//
//  ViewController.swift
//  IronTunes
//
//  Created by Ben Gohlke on 9/14/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class NowPlayingViewController: UIViewController
{

    @IBOutlet var songTitleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var albumArtwork: UIImageView!
    
    @IBOutlet var playPauseButton: UIButton!
    
    let avQueuePlayer = AVQueuePlayer()
    var songs = Array<Song>()
    var currentSong: Song?
    var nowPlaying: Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupAudioSession()
        configurePlaylist()
        loadCurrentSong()
        setBackground()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBackground()
    {
        avQueuePlayer.addPeriodicTimeObserverForInterval(CMTimeMake(1, 100), queue: dispatch_get_main_queue()) {
            [unowned self] time in
            let timeString = String(format: "%02.2f", CMTimeGetSeconds(time))
            if UIApplication.sharedApplication().applicationState == .Active
            {
                //self.timeLabel.text = timeString
            } else {
                print("Background: \(timeString)")
            }
        }

    }
    
    // MARK: - Action handlers
    
    @IBAction func playPauseTapped(sender: UIButton)
    {
        togglePlayback(!nowPlaying)
    }
    
    @IBAction func skipForwardTapped(sender: UIButton)
    {
        skipFordward()
    }
    
    func skipFordward()
    {
        let currentSongIndex = (songs as NSArray).indexOfObject(currentSong!)
        let nextSong: Int
        
        if currentSongIndex + 1 >= songs.count
        {
            nextSong = 0
        }
        else
        {
            nextSong = currentSongIndex + 1
        }
        currentSong = songs[nextSong]
        loadCurrentSong()
        togglePlayback(true)
    }
    
    @IBAction func skipBackTapped(sender: UIButton)
    {
        skipBack()
    }
    
    func skipBack()
    {
        avQueuePlayer.seekToTime(CMTimeMakeWithSeconds(0.0, 1))
        if !nowPlaying
        {
            togglePlayback(true)
        }
    }
    
    // MARK: - Private methods
    
    func configurePlaylist()
    {
        let acoustic = Song(title: "Happiness", artist: "Benjamin Tissot", filename: "happiness", albumArtwork: "Acoustic")
        songs.append(acoustic)
        currentSong = acoustic
        
        let dubstep = Song(title: "Dubstep", artist: "Benjamin Tissot", filename: "dubstep", albumArtwork: "Dubstep")
        songs.append(dubstep)
        
        let hiphop = Song(title: "Groovy Hip Hop", artist: "Benjamin Tissot", filename: "groovyhiphop", albumArtwork: "HipHop")
        songs.append(hiphop)
        
        let rock = Song(title: "Actionable", artist: "Benjamin Tissot", filename: "actionable", albumArtwork: "Rock")
        songs.append(rock)
        
        let funk = Song(title: "Funky Suspense", artist: "Benjamin Tissot", filename: "funkysuspense", albumArtwork: "Funk")
        songs.append(funk)
    }
    
    func loadCurrentSong()
    {

        avQueuePlayer.removeAllItems()
        if let song = currentSong
        {
            song.playerItem.seekToTime(CMTimeMakeWithSeconds(0.0, 1))
            avQueuePlayer.insertItem(song.playerItem, afterItem: nil)
            songTitleLabel.text = song.title
            artistLabel.text = song.artist
            albumArtwork.image = UIImage(named: song.albumArtworkName)
            
            let albumArt = MPMediaItemArtwork(image: UIImage(named: song.albumArtworkName)!)
            
            let mpic = MPNowPlayingInfoCenter.defaultCenter()
            
            mpic.nowPlayingInfo = [
                MPMediaItemPropertyTitle: song.title ,
                MPMediaItemPropertyArtist: song.artist ,
                MPMediaItemPropertyArtwork: albumArt
            ]
        }
        
        
       
        
       
    }
    
    func setupAudioSession()
    {
        AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
            if granted
            {
                do {
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                } catch _ {
                }
                do {
                    try AVAudioSession.sharedInstance().setActive(true)
                } catch _ {
                }
            }
            else
            {
                print("Audio session could not be configured; user denied permission.")
            }
        })
    }
    
    func togglePlayback(play: Bool)
    {
        nowPlaying = play
        if play
        {
            playPauseButton.setImage(UIImage(named: "Pause"), forState: UIControlState.Normal)
            avQueuePlayer.play()
        }
        else
        {
            playPauseButton.setImage(UIImage(named: "Play"), forState: UIControlState.Normal)
            avQueuePlayer.pause()
        }
    }
    // Background
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "currentItem", let player = object as? AVPlayer,
            currentItem = player.currentItem?.asset as? AVURLAsset {
                songTitleLabel.text = currentItem.URL.lastPathComponent ?? "Unknown"
        }
    }
    
    
    
    // ======== respond to remote controls
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
    }
    
    override func remoteControlReceivedWithEvent(event: UIEvent?) { // *
        let rc = event!.subtype
        let p = self.avQueuePlayer
        print("received remote control \(rc.rawValue)") // 101 = pause, 100 = play
        switch rc {
        case .RemoteControlTogglePlayPause:
//            if p.playing
//            { p.pause() }
//            else
//            { p.play() }
            togglePlayback(!nowPlaying)
        case .RemoteControlPlay:
//            p.play()
            togglePlayback(!nowPlaying)
        case .RemoteControlPause:
//            p.pause()
            togglePlayback(!nowPlaying)
        case .RemoteControlNextTrack:
            skipFordward()
        case .RemoteControlPreviousTrack:
            skipBack()
        default:break
        }
        
    }}