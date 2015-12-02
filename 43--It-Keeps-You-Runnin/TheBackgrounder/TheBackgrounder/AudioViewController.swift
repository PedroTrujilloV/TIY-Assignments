//
//  AudioViewController.swift
//  TheBackgrounder
//
//  Created by Ray Fix on 12/9/14.
//  Copyright (c) 2014 Razeware, LLC. All rights reserved.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController {
  
  @IBOutlet weak var songLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  var player: AVQueuePlayer!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    var error: NSError?
    var success: Bool
    do {
      try AVAudioSession.sharedInstance().setCategory(
            AVAudioSessionCategoryPlayAndRecord,
            withOptions: .DefaultToSpeaker)
      success = true
    } catch var error1 as NSError {
      error = error1
      success = false
    }
    if !success {
      NSLog("Failed to set audio session category.  Error: \(error)")
    }
    let songNames = ["FeelinGood","IronBacon","WhatYouWant"]
    let songs = songNames.map { AVPlayerItem(URL:
      NSBundle.mainBundle().URLForResource($0, withExtension: "mp3")!) }
    
    player = AVQueuePlayer(items: songs)
    player.actionAtItemEnd = .Advance
    player.addObserver(self, forKeyPath: "currentItem", options: [.New, .Initial] , context: nil)
    player.addPeriodicTimeObserverForInterval(CMTimeMake(1, 100), queue: dispatch_get_main_queue()) {
      [unowned self] time in
      let timeString = String(format: "%02.2f", CMTimeGetSeconds(time))
      if UIApplication.sharedApplication().applicationState == .Active {
        self.timeLabel.text = timeString
      } else {
        print("Background: \(timeString)")
      }
    }
  }
  
  override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    if keyPath == "currentItem", let player = object as? AVPlayer,
      currentItem = player.currentItem?.asset as? AVURLAsset {
        songLabel.text = currentItem.URL.lastPathComponent ?? "Unknown"
    }
  }
  
  @IBAction func playPauseAction(sender: UIButton) {
    sender.selected = !sender.selected
    if sender.selected {
      player.play()
    } else {
      player.pause()
    }
  }
}

