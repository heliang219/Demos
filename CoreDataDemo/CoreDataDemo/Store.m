//
//  Store.m
//  CoreDataDemo
//
//  Created by pfl on 15/5/26.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "Store.h"
#import <CoreData/CoreData.h>
#import "ShopIncomeItem.h"

@implementation Store

- (ShopIncomeItem *)shopIcomeItem
{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ShopIncomeItem"];
    request.predicate = [NSPredicate predicateWithValue:YES];
    NSArray *objects = [self.managedContext executeFetchRequest:request error:NULL];
    ShopIncomeItem *item = [objects firstObject];
    if (!item) {
        
        item = [ShopIncomeItem insertShopIncomeItem:nil inManagedObjectContext:self.managedContext];
        
    }

    
    return item;
    
}



@end
