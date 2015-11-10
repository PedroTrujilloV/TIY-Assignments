//
//  OuttaTimeViewController.h
//  OuttaTimeObjectiveC
//
//  Created by Pedro Trujillo on 11/9/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OuttaTimeViewController : UIViewController
{
    __weak IBOutlet UILabel *DestinationTimeLabel;
    
    //__weak IBOutlet UILabel *PresentTimeLabel;
    
    __weak IBOutlet UILabel *LastTimeDepartedLabel;
    
    __weak IBOutlet UILabel *SpeedLabel;
}



@property(nonatomic) NSString * lastTimeDeparted;
@property(nonatomic) NSTimer * timerBack;
@property(nonatomic) int currentSpeed;
@property(nonatomic) NSDate * currentDate;


-(NSString *) setDateTimeAndFormat:(NSDate *)seclectedDate;
@end
