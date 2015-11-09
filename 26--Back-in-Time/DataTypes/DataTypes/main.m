//
//  main.m
//  DataTypes
//
//  Created by Pedro Trujillo on 11/9/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        // insert code here...
        //NSLog(@"Hello, World!");
        
        int anInt = -2147483648;
        long aLong = -98765432112345;
        
        float aFloat = 21.09f;
        double aDouble = -21.09f;
        
        long double aLonDouble = 123456567456456452;
        
        int integerResult = 5/4;
        double doubleResult = 5.0 / 4;
        
        NSLog(@"%.17f", .1); /// to print same that c++ for the format
        
        
        BOOL isBool = YES;
        
        NSString * myString = @"Hello World!";
        
        NSLog(@"%@", myString);
        
        id mysteryObject = @"An NSString object";
        
        NSLog(@"%@", [mysteryObject description]);
        
        mysteryObject = @{@"model": @"Ford", @"year": @1967};
        NSLog(@"%@",[mysteryObject description]);
        
        NSArray *shipCaptains = @[@"Malcom Reynolds", @"JEan-Luc Picard", @"James T. Kirk", @"Han Solo"];
        
        NSArray *sameCaptains = @[@"Malcom Reynolds", @"JEan-Luc Picard", @"James T. Kirk", @"Han Solo"];

        //if (shipCaptains == sameCaptains)// this is address comparition
         if ([shipCaptains isEqualToArray:sameCaptains])// right way to compare pointers with Obj. C
        {
            NSLog(@"They are the same!");
        }
        if ([shipCaptains containsObject:@"Kathryn Janeway"])
        {
            NSLog(@"U.S.S. Voyager represent! ");
        }
        
        NSMutableArray *mutableShipCaptains = [shipCaptains mutableCopy];
        
        [mutableShipCaptains addObject:@"Kathryn Janeway"];
        
        NSLog(@"%ld captains",(long)mutableShipCaptains.count);
        
        
    }
    return 0;
}
