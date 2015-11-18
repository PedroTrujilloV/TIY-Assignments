//
//  MoviesCell.m
//  MovieMania
//
//  Created by Pedro Trujillo on 11/12/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "MoviesCell.h"

@implementation MoviesCell





- (void)awakeFromNib
{
    // Initialization code 

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];


    // Configure the view for the selected state
    //self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    [self setLabelsDefaultProperties];
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier//reference[1]
{
    // overwrite style
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    return self;
}

-(void)setLabelsDefaultProperties
{
    self.backgroundColor = [UIColor blackColor];
    self.textLabel.textColor = [UIColor redColor];
    //self.textLabel.font = [UIFont fontWithName:@"Palatino-Bold" size:(30.0)];
    self.textLabel.numberOfLines = 3;
    
    self.detailTextLabel.textColor = [UIColor whiteColor];
    //self.detailTextLabel.font = [UIFont fontWithName:@"Verdana" size:(14.0)];
    self.detailTextLabel.textAlignment = NSTextAlignmentJustified;// NSTextAlignmentLeft;
    self.detailTextLabel.numberOfLines = 11;
}




-(void) textTitle:(NSString * )text // for title
{
    if ([text length] > 11)
    {
        if ([text length] > 17)
        {
            self.textLabel.font = [UIFont fontWithName:@"Palatino-Bold" size:(18.0)];
        }
        else
        {
            self.textLabel.font = [UIFont fontWithName:@"Palatino-Bold" size:(24.0)];

        }
    }
    else
    {
        self.textLabel.font = [UIFont fontWithName:@"Palatino-Bold" size:(30.0)];
    }
    
    self.textLabel.text = text;
}

-(void) textSubTitle:(NSString * )text//for subtitles
{
    if ([text length] > 25)
    {
       
        self.textLabel.font = [UIFont fontWithName:@"Palatino-Bold" size:(18.0)];
        
    }
    else
    {
        self.textLabel.font = [UIFont fontWithName:@"Palatino-Bold" size:(22.0)];
    }
    
    self.textLabel.text = text;
}

-(void) textDetail:(NSString * )text //for detail
{
    if ([text length] > 30)
    {
        if ([text length] > 60)
        {
            self.detailTextLabel.font = [UIFont fontWithName:@"Verdana" size:(11.3)];
        }
        else
        {
            self.detailTextLabel.font = [UIFont fontWithName:@"Verdana" size:(15.3)];

        }
    }
    else
    {
        self.detailTextLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:(15.0)];
    }
    
    if(!self.detailTextLabel.text || [self.detailTextLabel.text isEqual:nil]||[self.detailTextLabel.text isEqualToString:@""])
    {
        self.detailTextLabel.text = text;
    }
    else
    {
        NSString * tempString = [[NSString alloc] initWithFormat:@"%@",self.detailTextLabel.text];
        self.detailTextLabel.text =  [tempString stringByAppendingString:text];
        tempString = @"";
        tempString = nil;
    }
}

-(void) textDetailStandar:(NSString * )text //for detail
{
 
    if ([text length] > 80)
    {
        //self.detailTextLabel.font = [UIFont fontWithName:@"Verdana" size:(11.3)];
        self.textLabel.font = [UIFont fontWithName:@"Palatino-Bold" size:(18.0)];
    }
    else
    {
        self.detailTextLabel.font = [UIFont fontWithName:@"Verdana" size:(15.3)];
        
    }
 
    self.detailTextLabel.text = text;

}

-(void) stars:(NSString * )text
{
    
    int numberStars = [text intValue];
    
    int totalStars = 1;
    
    NSString * starsEmoji = @"";
    
    if (numberStars < 1)
    {
        starsEmoji = [starsEmoji stringByAppendingString:@"☆☆☆☆☆☆☆☆☆☆"];
    }
    else
    {
        
        while (totalStars < 11 )
        {
            if(totalStars > numberStars)
            {
                starsEmoji = [starsEmoji stringByAppendingString:@"☆"];//⭐️"];
            }
            else
            {
                starsEmoji = [starsEmoji stringByAppendingString:@"⭐️"];
            }
            
            totalStars++;
        }
    }
    
    [self textDetail:starsEmoji];
    
}


-(void) titleTextLabel:(NSString *)text
{
    
    _labelText = [ [UILabel alloc ] initWithFrame:CGRectMake(0.0, 0.0, (self.bounds.size.width / 2), 43.0) ];
    _labelText.textAlignment = NSTextAlignmentLeft;
    _labelText.textColor = [UIColor cyanColor];
    //_labelText.backgroundColor = [UIColor redColor];
    _labelText.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(36.0)];
    [self addSubview:_labelText];
    _labelText.text = [NSString stringWithFormat: @"%@", text];
}



-(void)loadImage:(NSString *)ImagePath
{
   NSString *defaultImagePath = @"gravatar.jpg";
    NSString *path;
    
    if ([ImagePath  isEqual: @""] || [ImagePath  isEqual: @"N/A"] )
    {
        path = defaultImagePath;
        
        UIImage *image = [UIImage imageNamed:path];
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;

        [self.imageView setImage: image];
    }
    else
    {
        path = ImagePath;
        
        NSURL *posterURL = [NSURL URLWithString:path];
        
        NSData *imageData = [NSData dataWithContentsOfURL:posterURL];
        
        UIImage *image = [UIImage imageWithData:imageData];
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;

        [self.imageView setImage: image];
    }
    
    
    
    //self.imageView.image = image;
    
    
}

@end

///reference[1]://http://stackoverflow.com/questions/24131805/uitableviewcell-subtitle-not-showing-up
