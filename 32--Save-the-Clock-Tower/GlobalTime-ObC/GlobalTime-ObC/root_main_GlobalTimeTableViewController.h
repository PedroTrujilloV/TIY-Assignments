//
//  root_main_GlobalTimeTableViewController.h
//  GlobalTime-ObC
//
//  Created by Pedro Trujillo on 11/17/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SearchTimeZoneProtocol <NSObject>

-(void) timeZoneWasChozen:(NSString * )timeZoneString;

@end


@interface root_main_GlobalTimeTableViewController : UITableViewController

extern const CGFloat DEFAULT_CLOCK_SIZE;

@property (nonatomic) UIBarButtonItem * rightAddButton;
@property (nonatomic) NSMutableArray * namesTimeZonesArray;

@end
