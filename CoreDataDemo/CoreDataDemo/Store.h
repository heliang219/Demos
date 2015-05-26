//
//  Store.h
//  CoreDataDemo
//
//  Created by pfl on 15/5/26.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ShopIncomeItem;
@class NSManagedObjectContext;
@interface Store : NSObject
@property (nonatomic, strong) NSManagedObjectContext *managedContext;
- (ShopIncomeItem*)shopIcomeItem;

@end
