//
//  GroceryItem.h
//  Groceries
//
//  Created by Pedro Trujillo on 11/9/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroceryItem : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *category;
@property (assign) NSInteger aisle;


+ (GroceryItem *) groceryItemWithDictionary: (NSDictionary *) groceryItemDictionary;

@end
