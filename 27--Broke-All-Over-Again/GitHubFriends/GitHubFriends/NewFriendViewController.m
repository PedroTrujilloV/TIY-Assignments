//
//  NewFriendViewController.m
//  GithubFriends
//
//  Created by Ben Gohlke on 3/17/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "NewFriendViewController.h"

@interface NewFriendViewController () <NSURLSessionDataDelegate>
{
    UITextField *usernameTextField;
    
    NSMutableData *receivedData;
}

@end

@implementation NewFriendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, 300, 40)];
    usernameTextField.placeholder = @"Username";
    [self.view addSubview:usernameTextField];
    
    UIButton * saveFriend = [[UIButton alloc] initWithFrame:CGRectMake(10, 110, 300, 40)];
    [saveFriend setTitle:@"Git User" forState:UIControlStateNormal];
    [saveFriend addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveFriend];
    
    UIButton * cancel = [[UIButton alloc] initWithFrame:CGRectMake(10, 160, 300, 40)];
    [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cancel];
    
}

- (void)save
{    
    NSString * username = usernameTextField.text;
    
    NSString * urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@",username];
    NSURL * url = [NSURL URLWithString:urlString];
    
//    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
//    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
//    NSDictionary * userInfo = [NSJSONSerialization JSONObjectWithData:responseData
//                                                              options:NSJSONReadingMutableContainers
//                                                                error:nil];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration
                                                          delegate:self
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    
    [dataTask resume];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSURLSessionData delegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    if (!receivedData)
    {
        receivedData = [[NSMutableData alloc] initWithData:data];
    }
    else
    {
        [receivedData appendData:data];
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (!error)
    {
        NSLog(@"Download successful");
        NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:nil];
        [self.friends addObject:userInfo];
        [self cancel];
    }
}

@end
