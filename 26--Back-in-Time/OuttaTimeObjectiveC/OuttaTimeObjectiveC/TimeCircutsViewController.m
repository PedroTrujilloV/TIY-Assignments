//
//  TimeCircutsViewController.m
//  OuttaTimeObjectiveC
//
//  Created by Pedro Trujillo on 11/9/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

#import "TimeCircutsViewController.h"


@interface TimeCircutsViewController ()

@end

@implementation TimeCircutsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@synthesize delegate = _delegate;

- (IBAction)DatePickerChanged:(UIDatePicker *)sender
{
    [self.delegate dateWasSelected: sender.date];
}
@end
