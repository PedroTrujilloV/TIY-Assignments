//
//  Movie.h
//  MovieMania
//
//  Created by Pedro Trujillo on 11/12/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *yearM;
@property (nonatomic) NSString *plot;
@property (nonatomic) NSString *director;
@property (nonatomic) NSString *runtime;
@property (nonatomic) NSString *genre;
@property (nonatomic) NSString *poster;
@property (nonatomic) NSString *imdbRating;
@property (nonatomic) NSDictionary *completeInformationDict;


-(id)init:(NSDictionary *)movieDictionary;

@end
