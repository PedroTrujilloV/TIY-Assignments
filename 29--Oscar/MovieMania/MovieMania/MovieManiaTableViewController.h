//
//  MovieManiaTableViewController.h
//  MovieMania
//
//  Created by Isaiah Khan on 11/12/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@protocol SearchTableViewProtocol <NSObject>

-(void)movieWasFound:(Movie *)aMovie;


@end

@interface MovieManiaTableViewController : UITableViewController

@property (nonatomic) UIBarButtonItem *rightAddButton;
@property (nonatomic) NSMutableArray *moviesArray;
//@property (weak, nonatomic) APIController *apiController;
@property (nonatomic) NSMutableArray *moviesRegisterArray;
@property (nonatomic) NSString *moviesForSearch;

@end
