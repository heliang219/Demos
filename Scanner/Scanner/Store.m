//
//  Store.m
//  CoreDataDemo
//
//  Created by pfl on 15/5/26.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "Store.h"
#import <CoreData/CoreData.h>
#import "ScanItem.h"

@implementation Store

- (ScanItem *)scanItem
{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ScanItem"];
    request.predicate = [NSPredicate predicateWithValue:YES];
    NSArray *objects = [self.managedContext executeFetchRequest:request error:NULL];
    ScanItem *item = [objects lastObject];
    if (!item) {
        
        item = [ScanItem insertShopIncomeItem:nil inManagedObjectContext:self.managedContext];
        
    }

    NSLog(@"item:%p",item);
    
    return item;
    
}



@end
