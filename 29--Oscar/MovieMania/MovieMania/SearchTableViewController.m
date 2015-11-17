//
//  SearchTableViewController.m
//  MovieMania
//
//  Created by Isaiah Khan on 11/12/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "SearchTableViewController.h"
#import "MoviesCell.h"


@interface SearchTableViewController ()<UISearchBarDelegate,UISearchDisplayDelegate,UISearchResultsUpdating,UITableViewDataSource, NSURLSessionDataDelegate>

@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Search Movie";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor redColor]};


    _moviesArray = [[NSMutableArray alloc] init];
    _shouldShowSearchResults = NO;
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _idObjectInMoviesDic = [[NSMutableArray alloc] init];
    
    
    [self.tableView registerClass:MoviesCell.self forCellReuseIdentifier:@"MoviesCell"];
    [self.tableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"UITableViewCell"];

    
    //Customize the view controller bar
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.delegate = self;
    //_searchController.searchBar.backgroundColor = [UIColor redColor];
    [[_searchController searchBar] setBarTintColor:[UIColor colorWithRed:0.4 green:0.00 blue:0.00 alpha:1.0]]; // to box search bar
    [[_searchController searchBar] setTintColor:[UIColor redColor]]; // to texts and target bar
    [[_searchController searchBar] setPlaceholder:@"Type name of movie "];
    [_searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = _searchController.searchBar;
    
    
    //[_searchController.searchResultsUpdater self];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
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
    if(indexPath.row % 2 == 1)
    {
        MoviesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoviesCell" forIndexPath:indexPath];
        
        int indexPathCellInMoviesArray =(int) indexPath.row/2;//inside if use this index path
        
        cell.detailTextLabel.text = @"";

        // Configure the cell...
        [cell textTitle:[_moviesArray[indexPathCellInMoviesArray] title]];
        [cell loadImage:[_moviesArray[indexPathCellInMoviesArray] poster]];
        [cell textDetail:@"Genre: "];
        [cell textDetail:[_moviesArray[indexPathCellInMoviesArray] genre]];
        [cell textDetail:@"\r"];
        [cell textDetail:@"Rate: "];
        [cell textDetail:[_moviesArray[indexPathCellInMoviesArray] imdbRating]];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
        
        [_arrayTasks removeAllObjects];
    
        [self.delegator movieWasFound:_moviesArray[indexPathCellInMoviesArray]];
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
#pragma mark - Search Bar Methods
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _shouldShowSearchResults = YES;
    [self.tableView reloadData];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _shouldShowSearchResults = YES;
 
    [self.moviesArray removeAllObjects];
    [self.tableView reloadData];

    
    [self dismissViewControllerAnimated:true completion:nil];
    
}

//-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    if (!_shouldShowSearchResults)
//    {
//        _shouldShowSearchResults = YES;
//        [self omdbAPIRequest:searchBar.text];
//        [self.tableView reloadData];
//        
//    }
//    [_searchController.searchBar resignFirstResponder];
//}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    _shouldShowSearchResults = NO;
    [self.moviesArray removeAllObjects];
    [self.tableView reloadData];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    if (![searchBar.text isEqualToString:@""])
    {
        
        _shouldShowSearchResults = YES;
        [self.moviesArray removeAllObjects];
        [self omdbAPIRequest:searchBar.text];
        [self.tableView reloadData];
    }
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [self.tableView reloadData];
}


#pragma mark - Request to OMDB API

-(void) omdbAPIRequest:(NSString * )searchTerm
{
    
     NSString * searchTermProcesed = [searchTerm stringByReplacingOccurrencesOfString:@" " withString: @"+"];
    
    _arrayTasks = [[NSMutableArray alloc] init];

    [self search:searchTermProcesed]; // normal
    [self searchByType:searchTermProcesed]; // by type
    
    [_arrayTasks[0] resume];
    
}

-(void) search:(NSString * )searchTerm
{
   
    NSString *urlString = [NSString stringWithFormat:@"https://www.omdbapi.com/?t=%@",searchTerm ];
    [self requestAPI:urlString];
  
}

-(void) searchByType:(NSString * )searchTerm
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
   // NSInteger day = [components day];
    //NSInteger month = [components month];
    NSInteger presentYear = [components year];

    NSInteger year = 1980;
    
    
    //NSString *urlStringMovie = [NSString stringWithFormat:@"https://www.omdbapi.com/?t=%@",searchTerm];
    //[self requestAPI:urlStringMovie];
    
    NSInteger part = 0;
    
    for (NSInteger iy = year; iy <= presentYear; iy++)
    {

        //NSString *urlStringMovie = [NSString stringWithFormat:@"https://www.omdbapi.com/?t=%@%@%li",searchTerm,@"+&y=",iy];
        //[self requestAPI:urlStringMovie];
        
        NSString *urlStringMovieType = [NSString stringWithFormat:@"https://www.omdbapi.com/?t=%@%@%li",searchTerm,@"&type=movie&y=",iy];
        [self requestAPI:urlStringMovieType];
        
        
        NSString *urlStringMoviePart = [NSString stringWithFormat:@"https://www.omdbapi.com/?t=%@%@%li",searchTerm,@"+",part];
        [self requestAPI:urlStringMoviePart];
        
        
        NSString *urlStringSeries = [NSString stringWithFormat:@"https://www.omdbapi.com/?t=%@%@%li",searchTerm,@"&type=series&y=",iy];
        [self requestAPI:urlStringSeries];
        
        NSString *urlStringEpisode = [NSString stringWithFormat:@"https://www.omdbapi.com/?t=%@%@",searchTerm,@"&type=episode"];
        [self requestAPI:urlStringEpisode];
        
        
        
//                    });
    
       part++;
    }
   
}

#pragma mark - NSURLSessionData delegate

-(void) requestAPI:(NSString * )searchTerm
{
    
    NSURL *url = [NSURL URLWithString:searchTerm];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    
    //[dataTask resume];
    
    [_arrayTasks addObject:dataTask];

}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    if (!_receivedData)
    {
        _receivedData = [[NSMutableData alloc] initWithData:data];
    }
    else
    {
        [_receivedData appendData:data];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (!error)
    {
        //NSLog(@"Download successful");
        //_moviesArray = [[NSJSONSerialization JSONObjectWithData:_receivedData options:0 error:nil] mutableCopy];
        
        
        //NSLog(@"/n the information from _receivedData: %@", _receivedData);
        
        if (_receivedData != nil)
        {
            NSDictionary * aDictionary = [[NSJSONSerialization JSONObjectWithData:_receivedData options:0 error:nil] mutableCopy];
            //be very carefull with the object returned from here because isn't mutable, so you have create a mutable copy of that object if you want do any operation in your class with that object.
            if (aDictionary !=nil)
            {
                NSLog(@"/n the information from aDict: %@", aDictionary);
                
                if ([aDictionary[@"Response"] isEqualToString:@"True"])
                {
                    if (![_idObjectInMoviesDic containsObject: aDictionary[@"imdbID"]])
                    {
                        Movie * newMovie = [[Movie alloc] init:aDictionary];
                        [_moviesArray addObject:newMovie];
                        [_idObjectInMoviesDic addObject:aDictionary[@"imdbID"]];
                        [self.tableView reloadData];
                         _receivedData = nil;
                       // [task cancel];
                    
                    
                    }
                    
                }
                else
                {
//                    [task cancel];
                }
                
            }
        }
        else
        {
//            [task cancel];
        }
        
        [task cancel];
        [_arrayTasks removeObject:task];
        
        if (_arrayTasks.count != 0 )
        {
            [_arrayTasks[0] resume];

        }
        
      

       
        
        //NSLog(@"the information from omdb: %@", _moviesArray);
        
    }
    else
    {
        //[task cancel];
    }
    _receivedData = nil;
    
}



@end
