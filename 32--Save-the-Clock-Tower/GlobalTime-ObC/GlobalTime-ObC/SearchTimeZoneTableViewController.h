//
//  SearchTimeZoneTableViewController.h
//  GlobalTime-ObC
//
//  Created by Pedro Trujillo on 11/17/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "root_main_GlobalTimeTableViewController.h"

@interface SearchTimeZoneTableViewController : UITableViewController

@property (nonatomic) UIBarButtonItem * leftCancelButton;

@property (nonatomic,weak) id <SearchTimeZoneProtocol> delegator;

@property (nonatomic) NSMutableArray * namesTimeZonesArray;


@end
