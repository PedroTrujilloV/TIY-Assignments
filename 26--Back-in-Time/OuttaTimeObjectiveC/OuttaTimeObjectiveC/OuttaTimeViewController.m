//
//  OuttaTimeViewController.m
//  OuttaTimeObjectiveC
//
//  Created by Pedro Trujillo on 11/9/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//


#import "OuttaTimeViewController.h"
#import "TimeCircutsViewController.h"


@interface OuttaTimeViewController () <DatePickerDelegate>

@property (nonatomic) IBOutlet UILabel *presentTimeLabel;
@end

@implementation OuttaTimeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.currentSpeed = 0;
    //[self.lastTimeDeparted ]
    
    NSDate * now = [NSDate date];

    NSString * dateString = [[self setDateTimeAndFormat:[NSDate date]] description];
    
    [self setPresentTimeLabel: [dateString mutableCopy]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) dateWasSelected:(NSDate *)seclectedDate
{
    
    [self setDestinationLabel:[self setDateTimeAndFormat:seclectedDate]];
    
    //[self setLastTimeDeparted:self.lastTimeDeparted];
    //self.lastTimeDeparted = formatterDateString;
}



-(NSString *) setDateTimeAndFormat:(NSDate *)seclectedDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle: NSDateFormatterNoStyle];
    [dateFormatter setDateFormat:@"MMM d, yy"];
    NSString *formatterDateString = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:seclectedDate]];
    return formatterDateString;
}

-(void) SetPresentTime
{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateStyle: NSDateFormatterNoStyle];
//    [dateFormatter setDateFormat:@"MMM d, ''yy"];
//    self.currentDate = [NSDate date];
//    NSString *formatterDateString = [dateFormatter stringFromDate:self.currentDate];
//    [self setPresentTimeLabel:formatterDateString];
//    NSLog(@"current time is: %@", formatterDateString);
//    
//    
    
}

-(void) setDestinationLabel:(NSString *) destination
{
    DestinationTimeLabel.text = destination;
}


-(void) setPresentTimeLabel:(NSString *)presentTime
{
    self.presentTimeLabel.text = presentTime;
}


-(void) setLastTimeDepartedLabel:(NSString *) lastTimeDeparted
{
//    LastTimeDepartedLabel.text = lastTimeDeparted;
}


-(void) setSpeedLabel:(NSString *) speed
{
    //SpeedLabel.text = [NSString stringWithFormat:speed,"%@!",@"MPH"];
}

-(void) startTime
{
    self.timerBack = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(currentSpeed_UI) userInfo:nil repeats:true];
}
-(void) StopTimer
{
    [self.timerBack invalidate];
    self.timerBack = nil;
}

-(void) currentSpeed_UI
{
//    if (self.currentSpeed <= 87)
//    {
//        
//        self.currentSpeed = self.currentSpeed +1;
//        NSString * current = [NSString stringWithFormat:@"%id",self.currentSpeed];
//        [self setSpeedLabel:current];
//    }
//    else
//    {
//        [self StopTimer];
//        [self setLastTimeDeparted:PresentTimeLabel.text];
//        [self setPresentTimeLabel:DestinationTimeLabel.text];
//        self.currentSpeed = 0;
//    }
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ShowTimeCircutsViewControllerSegue"])
    {
        UIViewController *newController = segue.destinationViewController;
        TimeCircutsViewController *dateVC = (TimeCircutsViewController *) newController;
        dateVC.delegate = self;
    }
}

@end
