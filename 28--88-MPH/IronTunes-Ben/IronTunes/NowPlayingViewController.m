//
//  ViewController.m
//  IronTunes
//
//  Created by Ben Gohlke on 11/11/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "NowPlayingViewController.h"
#import "Song.h"

@import AVFoundation;
@import MediaPlayer;

@interface NowPlayingViewController ()
{
    BOOL nowPlaying;
    Song *currentSong;
}

@property (weak, nonatomic) IBOutlet UILabel *songTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UIImageView *albumArtwork;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;

@property (nonatomic) NSMutableArray *songs;
@property (nonatomic) AVQueuePlayer *queuePlayer;

@end

@implementation NowPlayingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    nowPlaying = NO;
    currentSong = nil;
    self.songs = [[NSMutableArray alloc] init];
    self.queuePlayer = [[AVQueuePlayer alloc] init];
    
    [self setupAudioSession];
    [self configurePlaylist];
    [self loadCurrentSong];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configurePlaylist
{
    Song *acoustic = [[Song alloc] initWithTitle:@"Happiness" artist:@"Benjamin Tissot" fileName:@"happiness" andAlbumArtwork:@"Acoustic"];
    [self.songs addObject:acoustic];
    currentSong = acoustic;
    
    Song *dubstep = [[Song alloc] initWithTitle:@"Dubstep" artist:@"Benjamin Tissot" fileName:@"dubstep" andAlbumArtwork:@"Dubstep"];
    [self.songs addObject:dubstep];
    
    Song *hiphop = [[Song alloc] initWithTitle:@"Groovy Hip Hop" artist:@"Benjamin Tissot" fileName:@"groovyhiphop" andAlbumArtwork:@"HipHop"];
    [self.songs addObject:hiphop];
    
    Song *rock = [[Song alloc] initWithTitle:@"Actionable" artist:@"Benjamin Tissot" fileName:@"actionable" andAlbumArtwork:@"Rock"];
    [self.songs addObject:rock];
    
    Song *funk = [[Song alloc] initWithTitle:@"Funky Suspense" artist:@"Benjamin Tissot" fileName:@"funkysuspense" andAlbumArtwork:@"Funk"];
    [self.songs addObject:funk];
}

- (void)loadCurrentSong
{
    [self.queuePlayer removeAllItems];
    if (currentSong)
    {
        [currentSong.playerItem seekToTime:CMTimeMakeWithSeconds(0.0, 1)];
        [self.queuePlayer insertItem:currentSong.playerItem afterItem:nil];
        self.songTitleLabel.text = currentSong.title;
        self.artistLabel.text = currentSong.artist;
        self.albumArtwork.image = [UIImage imageNamed:currentSong.albumArtworkName];
    }
}

- (void)togglePlayback:(BOOL)play
{
    nowPlaying = play;
    if (play)
    {
        [self.playPauseButton setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateNormal];
        [self.queuePlayer play];
    }
    else
    {
        [self.playPauseButton setImage:[UIImage imageNamed:@"Play"] forState:UIControlStateNormal];
        [self.queuePlayer pause];
    }
}

#pragma mark - Audio Session Methods

- (void)setupAudioSession
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
//    [session requestRecordPermission:^(BOOL granted) {
//        if (granted)
//        {
            NSError *categoryError = nil;
            [session setCategory:AVAudioSessionCategoryPlayback error:&categoryError];
            if (categoryError)
            {
                NSLog(@"Error setting category: %@", [categoryError localizedDescription]);
            }
            
            NSError *activationError = nil;
            [session setActive:YES error:&activationError];
            if (activationError)
            {
                NSLog(@"Error activating session: %@", [activationError localizedDescription]);
            }
//        }
//        else
//        {
//            NSLog(@"User denied permission for audio playback");
//        }
//    }];
}

#pragma mark - Action Handlers

- (IBAction)playPauseTapped:(UIButton *)sender
{
    [self togglePlayback:!nowPlaying];
}

- (IBAction)skipForwardTapped:(UIButton *)sender
{
    NSUInteger index = [self.songs indexOfObject:currentSong];
    NSUInteger nextSong;
    
    if (index + 1 >= self.songs.count)
    {
        nextSong = 0;
    }
    else
    {
        nextSong = index + 1;
    }
    currentSong = self.songs[nextSong];
    [self loadCurrentSong];
    [self togglePlayback:YES];
}

- (IBAction)skipBackTapped:(UIButton *)sender
{
    [self.queuePlayer seekToTime:CMTimeMakeWithSeconds(0.0, 1)];
    if (!nowPlaying)
    {
        [self togglePlayback:YES];
    }
}

@end
