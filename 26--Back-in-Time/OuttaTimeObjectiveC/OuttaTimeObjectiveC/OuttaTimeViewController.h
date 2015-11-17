//
//  OuttaTimeViewController.h
//  OuttaTimeObjectiveC
//
//  Created by Pedro Trujillo on 11/9/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OuttaTimeViewController : UIViewController

@property(nonatomic) NSString * lastTimeDeparted;
@property(nonatomic) NSTimer * timerBack;
@property(nonatomic) int currentSpeed;
@property(nonatomic) NSDate * currentDate;

@property (weak, nonatomic) IBOutlet UILabel *presentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *DestinationTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *LastTimeDepartedLabel;
@property (weak, nonatomic) IBOutlet UILabel *SpeedLabel;

-(NSString *) setDateTimeAndFormat:(NSDate *)seclectedDate;
@end
