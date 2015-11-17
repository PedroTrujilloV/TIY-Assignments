//
//  MovieManiaTableViewController.m
//  MovieMania
//
//  Created by Isaiah Khan on 11/12/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "MovieManiaTableViewController.h"
#import "MoviesCell.h"
#import "SearchTableViewController.h"
#import "DetailTableViewController.h"


@interface MovieManiaTableViewController ()

@end


// validar que no se guarden repetidos 
@implementation MovieManiaTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"CineMania! 🎬";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor redColor]};

    self.view.backgroundColor = [UIColor blackColor];
    self.tableView.separatorColor = [UIColor clearColor];
    self.navigationItem.leftBarButtonItem = self.editButtonItem; //edit to remove movies from cell list


    
    _moviesArray = [[NSMutableArray alloc]init];
    _moviesRegisterArray = [[NSMutableArray alloc] init];
    _rightAddButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(addButtonActionTapped:)];
    _moviesForSearch = [NSString stringWithFormat:@""];
    
    //[self.navigationItem setRightBarButtonItems:@[_rightAddButton] animated:YES];

    
     self.navigationItem.rightBarButtonItem = _rightAddButton;
    
    [self.tableView registerClass:MoviesCell.self forCellReuseIdentifier:@"MoviesCell"];
    [self.tableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"UITableViewCell"];


    

    
    
    //test
    //[_moviesArray addObject:@"hola mundo"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _moviesArray.count*2;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 1)
    {
        return 120;
    }
    else
    {
        return  10;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Configure the cell...
    
    
   if(indexPath.row % 2 == 1)
   {
       MoviesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoviesCell" forIndexPath:indexPath];

       int indexPathCellInMoviesArray =(int) indexPath.row/2;//inside if use this index path
       
       cell.detailTextLabel.text = @"";
       
       [cell textTitle:[_moviesArray[indexPathCellInMoviesArray] title]];
       [cell textDetail:@"Year: "];
       [cell textDetail:[_moviesArray[indexPathCellInMoviesArray] yearM]];
       [cell textDetail:@"\r"];
       [cell stars:[_moviesArray[indexPathCellInMoviesArray] imdbRating]];
       [cell textDetail:@"\r"];
       [cell textDetail:@"Rate: "];
       [cell textDetail:[_moviesArray[indexPathCellInMoviesArray] imdbRating]];
       
       //cell.detailTextLabel.text = [cell.detailTextLabel.text stringByAppendingString:[_moviesArray[indexPath.row] imdbRating]];
       [cell loadImage:[_moviesArray[indexPathCellInMoviesArray] poster]];
       //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       //cell.detailTextLabel.text = [_moviesArray[indexPath.row] plot];
       
       return cell;

   }
   else
   {
       
       UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
       cell.textLabel.text = @"";
       cell.detailTextLabel.text = @"";
       cell.backgroundColor = [UIColor clearColor];
        return cell;
 
   }
   
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row % 2 == 1)
    {
        int indexPathCellInMoviesArray =(int) indexPath.row/2;//inside if use this index path
        
        DetailTableViewController *detailTableVC = [[DetailTableViewController alloc]init];
        
        detailTableVC.movie = _moviesArray[indexPathCellInMoviesArray];

        [self.navigationController pushViewController:detailTableVC animated:YES];
    }
    
}
// deletes the cell and the content thats in the cell.
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger indexPathCellInMoviesArray =(int) indexPath.row/2;//inside if use this index path

    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if (indexPath.row % 2 == 1)
        {
            [_moviesArray removeObjectAtIndex:indexPathCellInMoviesArray];
            //[self.tableView deleteRowsAtIndexPaths:@[indexPath.row/2] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
        }
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Handle Actions
-(void)addButtonActionTapped:(UIButton *)sender
{
    SearchTableViewController *searchTableVC = [[SearchTableViewController alloc]init];
    UINavigationController *navigationConroller = [[UINavigationController alloc]initWithRootViewController:searchTableVC];
    [[navigationConroller navigationBar] setBarTintColor:[UIColor colorWithRed:0.1 green:0.00 blue:0.00 alpha:1.0]];//reference[1] RED

    searchTableVC.delegator = self;
    searchTableVC.view.backgroundColor = [UIColor blackColor];
    searchTableVC.tableView.separatorColor = [UIColor clearColor];
    
    [self presentViewController:navigationConroller animated:YES completion:nil];
    
}

#pragma mark - Search Table Protocol
-(void)movieWasFound:(Movie *)aMovie
{
    [_moviesArray addObject:aMovie];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}


@end


///reference [1]: http://stackoverflow.com/questions/5577390/how-to-add-custom-color-to-navigation-bar-in-iphone
