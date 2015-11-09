//
//  GroceryItem.m
//  Groceries
//
//  Created by Pedro Trujillo on 11/9/15.
//  Copyright © 2015 Pedro Trujillo. All rights reserved.
//

#import "GroceryItem.h"

@implementation GroceryItem


+ (GroceryItem *) groceryItemWithDictionary:(NSDictionary *)groceryItemDictionary
{
    GroceryItem *anItem = nil;
    if(groceryItemDictionary)
    {
        anItem = [[GroceryItem alloc]init];
        anItem.name = [groceryItemDictionary objectForKey:@"name"];
        
        anItem.category = [groceryItemDictionary objectForKey:@"category"];
        anItem.aisle = [[groceryItemDictionary objectForKey:@"aisle"]integerValue];
        
    }
    return  anItem;
}


@end
