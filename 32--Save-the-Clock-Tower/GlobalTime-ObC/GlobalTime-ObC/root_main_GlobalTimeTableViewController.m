//
//  root_main_GlobalTimeTableViewController.m
//  GlobalTime-ObC
//
//  Created by Pedro Trujillo on 11/17/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

#import "root_main_GlobalTimeTableViewController.h"
#import "SearchTimeZoneTableViewController.h"
#import "SPClockView.h"

const CGFloat DEFAULT_CLOCK_SIZE = 100.0;

@interface root_main_GlobalTimeTableViewController ()<SearchTimeZoneProtocol>

@end

@implementation root_main_GlobalTimeTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.tableView.separatorColor = [UIColor clearColor];
    _namesTimeZonesArray = [[NSMutableArray alloc] init];
    
    _rightAddButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTimeZoneTappedButtonAction:)];
    self.navigationItem.rightBarButtonItem = _rightAddButton;
    [self.tableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _namesTimeZonesArray.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

        return  120.0;

}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    SPClockView * newClockView = [[SPClockView alloc] initWithFrame:(CGRectMake(30.0, 10.0, DEFAULT_CLOCK_SIZE, DEFAULT_CLOCK_SIZE))];
    //[newClockView setTimeZone:[[NSTimeZone alloc] initWithName:_namesTimeZonesArray[indexPath.row]]];
    //[newClockView setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EDT"]];
    cell.textLabel.text = _namesTimeZonesArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"gravatar.png"];
    [cell addSubview:newClockView];
    
   
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        [_namesTimeZonesArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert)
//    {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) timeZoneWasChozen:(NSString * )timeZoneString
{
    printf("Hello world ");
    NSLog(@"me lo mando! esto: %@",timeZoneString);
    
    [_namesTimeZonesArray addObject:timeZoneString];
    
    [self.tableView reloadData];
}


#pragma mark - Action Handlers


-(void) addTimeZoneTappedButtonAction:(UIButton *)sender
{
    SearchTimeZoneTableViewController * newSearchTVC = [[SearchTimeZoneTableViewController alloc] init];
    UINavigationController * newNavigationController = [[UINavigationController alloc] initWithRootViewController:newSearchTVC];
    newSearchTVC.delegator = self;
    newSearchTVC.tableView.separatorColor = [UIColor clearColor];
    [self presentViewController:newNavigationController animated:YES completion:nil];
    
    
    NSLog(@"Hay que rico me clicaste el addTimeZoneTappedButtonAction");
}

@end
