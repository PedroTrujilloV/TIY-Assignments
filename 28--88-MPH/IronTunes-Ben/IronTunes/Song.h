//
//  Song.h
//  IronTunes
//
//  Created by Ben Gohlke on 11/11/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AVFoundation;

@interface Song : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *artist;
@property (nonatomic) NSString *filename;
@property (nonatomic) NSString *albumArtworkName;

@property (nonatomic) AVPlayerItem *playerItem;

- (instancetype)initWithTitle:(NSString *)title artist:(NSString *)artist fileName:(NSString *)filename andAlbumArtwork:(NSString *)albumArtworkName;

@end
