//
//  NewFriendViewController.m
//  GitHubFriends
//
//  Created by Pedro Trujillo on 11/10/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

#import "NewFriendViewController.h"

@interface NewFriendViewController () <NSURLSessionDelegate>
{
    UITextField * usernameTextField;
    NSMutableData * receiveData;
}

@end

@implementation NewFriendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, 300, 40)];
    
    usernameTextField.placeholder = @"Username";
    [self.view addSubview:usernameTextField];
    
    UIButton * saveFriend = [[UIButton alloc]initWithFrame:CGRectMake(10, 110, 300, 40)];
    [saveFriend setTitle:@"Git User" forState:UIControlStateNormal];
    [saveFriend addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveFriend];
    
    UIButton * cancel = [[UIButton alloc]initWithFrame:CGRectMake(10, 160, 300, 40)];
    [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancel];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) save
{
    NSString * name = usernameTextField.text;
    NSString * urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@",name];
    NSURL * url = [NSURL URLWithString:urlString];
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask * task = [session dataTaskWithURL:url];
    [task resume];
    
}

- (void) cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - NSURLSessionData delegate

-(void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
    
}

- (void) adsas
{
    if(!receiveData)
    {
        receiveData = [[NSMutableData alloc]init];
        
    }
    [receiveData appendData:data];
}

- (void) asdasd
{
    if(!error)
    {
        NSLog(@"Download successful");
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
