//
//  ViewController.m
//  IronTunes
//
//  Created by Pedro Trujillo on 11/11/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

#import "NowPlayingViewController.h"
#import "Song.h"
#import <AVFoundation/AVFoundation.h> // or @import AVFoundations
@import MediaPlayer;

@interface NowPlayingViewController ()
{
    BOOL nowPlaying;
    Song * currentSong;
}

@property (weak,nonatomic) IBOutlet UILabel * songTitleLabel;
@property (weak,nonatomic) IBOutlet UILabel * artisLabel;
@property (weak,nonatomic) IBOutlet UIImageView * albumArtwork;
@property (weak,nonatomic) IBOutlet UIButton * playPauseButton;

@property (nonatomic) NSMutableArray *songs;
@property (nonatomic) AVQueuePlayer * queuePlayer;

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

-(void)configurePlaylist
{
    Song * acoustic = [[Song alloc] initWithTitle:@"Happiness" artist:@"Benjamin Tissot" fileName:@"happiness" andAlbumArtWork:@"Acoustic"];
    [self.songs addObject:acoustic];
//    
//    Song * dubstep = [[Song alloc] initWithTitle:@"Dubstep" artist:@"Benjamin Tissot" fileName:@"Dubstep" andAlbumArtWork:@"Dubstep"];
//    [self.songs addObject:dubstep];
    
//    Song * hiphop = [[Song alloc] initWithTitle:@"Groove Hip Hop" artist:@"Benjamin Tissot" fileName:@"Actionable" andAlbumArtWork:@"Rock"];
//    [self.songs addObject:hiphop];
    
    Song * rock = [[Song alloc] initWithTitle:@"Actionable" artist:@"Benjamin Tissot" fileName:@"actionable" andAlbumArtWork:@"Rock"];
    [self.songs addObject:rock];
    
}

-(void)loadCurrentSong
{
    [self.queuePlayer removeAllItems];
    if (currentSong)
    {
        [currentSong.playerItem seekToTime:CMTimeMakeWithSeconds(0.0, 1)];
        [self.queuePlayer insertItem:currentSong.playerItem afterItem: nil];
        self.songTitleLabel.text = currentSong.title;
        self.artisLabel.text = currentSong.artist;
        self.albumArtwork.image = [UIImage imageNamed:currentSong.albumArtworkName];
    }
}

#pragma mark - Audio Session Methods 


-(void)setupAudioSession
{
    AVAudioSession * session =  [AVAudioSession sharedInstance];
//    [session requestRecordPermission:
//         ^(BOOL granted)
//        {
//            if(granted)
//            {
                NSError * categoryError = nil;
                [session setCategory:AVAudioSessionCategoryPlayback error:&categoryError];
                if(categoryError)
                {
                    NSLog(@"Error setting category: %@", [categoryError localizedDescription]);
                }
                
                NSError * activationError = nil;
                [session setActive:YES error:&activationError];
                if (activationError)
                {
                    NSLog(@"Error activationg session: %@",[activationError localizedDescription]);
                }
//            }
//
//            else
//            {
//                NSLog(@"User denied permission for audio playback");
//            }
//            
//        }
//     ];
}

-(void) togglePlayback:(BOOL) play
{
    nowPlaying = play;
    if(play)
    {
        [self.playPauseButton setImage:[UIImage  imageNamed:@"Pause"] forState:UIControlStateNormal];
        [self.queuePlayer play];
    }
    else
    {
        [self.playPauseButton setImage:[UIImage  imageNamed:@"Play"] forState:UIControlStateNormal];
        [self.queuePlayer pause];
    }
        
}

#pragma mark - Action Hadlers

-(IBAction)playPauseTapped:(UIButton * )sender
{
    [self togglePlayback:!nowPlaying];
}

-(IBAction)skipFordawardTapped:(UIButton * )sender
{
    NSInteger index = [self.songs indexOfObject:currentSong];
    
    NSUInteger nextSong;
    
    if(index + 1 >= self.songs.count)
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

-(IBAction) skipBackTapped:(UIButton * )sender
{
    [self.queuePlayer seekToTime:CMTimeMakeWithSeconds(0.0, 1)];
    if (!nowPlaying)
    {
        [self togglePlayback:YES];
    }
    
}
@end
