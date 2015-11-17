//
//  Song.m
//  IronTunes
//
//  Created by Pedro Trujillo on 11/11/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

#import "Song.h"

@implementation Song


- (instancetype)initWithTitle:(NSString * )title artist:(NSString *)artist fileName:(NSString * )filename andAlbumArtWork:(NSString * )albumArtWorkName
{
    if (self = [super init])
    {
        _title = title;
        _artist = artist;
        _filename = filename;
        _albumArtworkName = albumArtWorkName;
        
        //_playerItem = [[AVPlayerItem alloc] initWithURL:[[NSURL alloc] initWithString:[[NSBundle mainBundle] pathForResource:filename ofType:@"mp3"] ]];
        
        _playerItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:filename ofType:@"mp3"]]];
    }
    return self;
}

@end
