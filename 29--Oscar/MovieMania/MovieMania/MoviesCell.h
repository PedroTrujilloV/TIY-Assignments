//
//  MoviesCell.h
//  MovieMania
//
//  Created by Isaiah Khan on 11/12/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesCell : UITableViewCell


-(void)loadImage:(NSString *)ImagePath;
@property (strong,nonatomic) UILabel * labelText;
@property (strong,nonatomic) UILabel * detailLabelText;

-(void) textTitle:(NSString * )text;
-(void) textDetail:(NSString * )text;
-(void) stars:(NSString * )text;
-(void) textSubTitle:(NSString * )text;

-(void)setLabelsDefaultProperties;
-(void) textDetailStandar:(NSString * )text;

@end
