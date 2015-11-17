//
//  Song.m
//  IronTunes
//
//  Created by Ben Gohlke on 11/11/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "Song.h"

@implementation Song

- (instancetype)initWithTitle:(NSString *)title artist:(NSString *)artist fileName:(NSString *)filename andAlbumArtwork:(NSString *)albumArtworkName
{
    if (self = [super init])
    {
        _title = title;
        _artist = artist;
        _filename = filename;
        _albumArtworkName = albumArtworkName;
        _playerItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:filename ofType:@"mp3"]]];
    }
    return self;
}

@end