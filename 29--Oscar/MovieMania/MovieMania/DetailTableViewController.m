//
//  DetailTableViewController.m
//  MovieMania
//
//  Created by Pedro Trujillo on 11/13/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "DetailTableViewController.h"

@interface DetailTableViewController ()

@end

@implementation DetailTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title =  _movie.title;
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor redColor]};
    self.tableView.separatorColor = [UIColor clearColor];

    
    
    _allKeysInMovieDic = [[_movie.completeInformationDict allKeys] mutableCopy];
    
    
//    NSLog(@"lenght array of keys Before is = %lid",_allKeysInMovieDic.count);
//    NSLog(@"array of keys is = %@",_allKeysInMovieDic);
    [_allKeysInMovieDic removeObject:@"Title"];
    [_allKeysInMovieDic removeObject:@"Plot"];
    [_allKeysInMovieDic removeObject:@"Poster"];
    [_allKeysInMovieDic removeObject:@"imdbRating"];
    [_allKeysInMovieDic removeObject:@"Response"];
    //[_allKeysInMovieDic removeObject:@"Year"];
//
    //_allKeysInMovieDic =[[_allKeysInMovieDic sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] mutableCopy];
    
    
   // [_allKeysInMovieDic addObject :@"Year"];
    

//    NSLog(@"lenght array of keys After is = %lid",_allKeysInMovieDic.count);
//    NSLog(@"array of keys is = %@",_allKeysInMovieDic);


     [self.tableView registerClass:MoviesCell.self forCellReuseIdentifier:@"MoviesCell"];
    [self.tableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"UITableViewCell"];
    
self.tableView.rowHeight = UITableViewAutomaticDimension;


}

-(void)viewDidAppear:(BOOL)animated
{
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    [self.tableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tableView.estimatedRowHeight = 70.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView reloadData];

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
    return _allKeysInMovieDic.count+3;
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 15;
    }
    else
    {
        if(indexPath.row == 1)
        {
            return 205;
        }
        else
        {
            //return 70;
            return UITableViewAutomaticDimension;
        }
    }
   
        
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Configure the cell...

   
    
    
    if (indexPath.row == 0) // a small separator
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else
    {
        MoviesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoviesCell" forIndexPath:indexPath];
        
        cell.detailTextLabel.text = nil;
        cell.textLabel.text = nil;
        cell.imageView.image = nil;
        
        

        if(indexPath.row == 1)// to poster with title ... row in position 1
        {
            [cell loadImage:_movie.poster];
            [cell textTitle:_movie.title];
            [cell textDetail:_movie.plot];
            return cell;
        }
        else
        {
            
            if(indexPath.row == 2) // to rate and stars row in position 2
            {
                NSString * rateTitle = [NSString stringWithFormat:@"IMDB Rate: %@",_movie.imdbRating];
                [cell textSubTitle:rateTitle];
                [cell stars:_movie.imdbRating];
                return cell;

            }
            else //default for others values
            {
                MoviesCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"MoviesCell" forIndexPath:indexPath];
                //[cell2 setLabelsDefaultProperties];

                cell2.detailTextLabel.text = nil;
                cell2.textLabel.text = nil;
                cell2.imageView.image = nil;

                
                int indexPathCellInMoviesArray = (int) indexPath.row-3;//inside if use this index path
                

                NSString * anyTitleinDic = _allKeysInMovieDic[indexPathCellInMoviesArray];
                [cell2 textSubTitle:anyTitleinDic];
                //cell2.detailTextLabel.text = _movie.completeInformationDict[anyTitleinDic];
                [cell2 textDetailStandar:_movie.completeInformationDict[anyTitleinDic]];
                //[cell2 textDetail:_movie.completeInformationDict[anyTitleinDic]];
                
                //cell2.contentView.clipsToBounds = YES;
             
                

                return cell2;
            }
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


@end
