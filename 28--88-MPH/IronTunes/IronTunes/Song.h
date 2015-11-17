//
//  Song.h
//  IronTunes
//
//  Created by Pedro Trujillo on 11/11/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface Song : NSObject
@property (nonatomic) NSString * title;
@property (nonatomic) NSString * artist;
@property (nonatomic) NSString * filename;
@property (nonatomic) NSString * albumArtworkName;


@property (nonatomic) AVPlayerItem * playerItem;

- (instancetype)initWithTitle:(NSString * )title artist:(NSString *)artist fileName:(NSString * )filename andAlbumArtWork:(NSString * )albumArtWorkName;

@end
