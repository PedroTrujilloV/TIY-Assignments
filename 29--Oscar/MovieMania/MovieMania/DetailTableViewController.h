//
//  DetailTableViewController.h
//  MovieMania
//
//  Created by Isaiah Khan on 11/13/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "MoviesCell.h"

@interface DetailTableViewController : UITableViewController

@property (nonatomic) Movie *movie;
@property (nonatomic) NSMutableArray * allKeysInMovieDic;

@end
