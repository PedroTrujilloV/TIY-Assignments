//
//  Movie.m
//  MovieMania
//
//  Created by Pedro Trujillo on 11/12/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "Movie.h"

@implementation Movie


-(id)init:(NSDictionary *)movieDictionary
{
    self = [super init];
    if (self)
    {
        _title = [[NSString alloc] initWithFormat:@"%@",movieDictionary[@"Title"]];
        _director = [[NSString alloc] initWithFormat:@"%@",movieDictionary[@"Director"]];
        _plot = [[NSString alloc] initWithFormat:@"%@",movieDictionary[@"Plot"]];
        _yearM = [[NSString alloc]initWithFormat:@"%@",movieDictionary[@"Year"]];
        _runtime = [[NSString alloc]initWithFormat:@"%@",movieDictionary[@"Runtime"]];
        _genre = [[NSString alloc]initWithFormat:@"%@",movieDictionary[@"Genre"]];
        _poster = [[NSString alloc]initWithFormat:@"%@",movieDictionary[@"Poster"]];
        _imdbRating = [[NSString alloc]initWithFormat:@"%@",movieDictionary[@"imdbRating"]];
        
        _completeInformationDict  = [[NSDictionary alloc] initWithDictionary:movieDictionary];
        
//        NSLog(@"title: %@",_title);
//        NSLog(@"director: %@",_director);
//        NSLog(@"year: %@",_year);
//        NSLog(@"runtime: %@",_runtime);
//        NSLog(@"genre: %@",_genre);
//        NSLog(@"poster: %@",_poster);
//        NSLog(@"imdbRating: %@",_imdbRating);
    }
    return self;
}



@end
