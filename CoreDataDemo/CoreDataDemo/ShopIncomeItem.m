//
//  Entity.m
//  CoreDataDemo
//
//  Created by pfl on 15/5/26.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "ShopIncomeItem.h"


@implementation ShopIncomeItem

@dynamic todayrebate;
@dynamic ystdayrebate;
@dynamic allrebate;
@dynamic availablerebate;
@dynamic todayturnover;
@dynamic ystdayturnover;
@dynamic allturnover;
@dynamic outsidemover;
@dynamic availbleturnover;
@dynamic newmember;
@dynamic allmember;
@dynamic todayorder;
@dynamic allorder;
@dynamic orderrebate;
@dynamic giverebate;
@dynamic todayoutsidemover;
@dynamic outrebatemover;
@dynamic naincome;
@dynamic nacommision;
@dynamic adincome;
@dynamic adcommision;
@dynamic sncommision;
@dynamic snincome;

+ (instancetype)insertShopIncomeItem:(ShopIncomeItem*)item inManagedObjectContext:(NSManagedObjectContext*)managedContext
{
    
    ShopIncomeItem *shopIncomeItem = [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:managedContext];
    
    shopIncomeItem.adcommision = item.adcommision;
    shopIncomeItem.adincome = item.adincome;
    shopIncomeItem.allmember = item.allmember;
    shopIncomeItem.allorder = item.allorder;
    shopIncomeItem.allrebate = item.allrebate;
    shopIncomeItem.allturnover = item.allturnover;
    shopIncomeItem.availablerebate = item.availablerebate;
    shopIncomeItem.availbleturnover = item.availbleturnover;
    shopIncomeItem.ystdayrebate = item.ystdayrebate;
    shopIncomeItem.ystdayturnover = item.ystdayturnover;
    shopIncomeItem.todayorder = item.todayorder;
    shopIncomeItem.todayoutsidemover = item.todayoutsidemover;
    shopIncomeItem.todayrebate = item.todayrebate;
    shopIncomeItem.todayturnover = item.todayturnover;
    shopIncomeItem.outrebatemover = item.outrebatemover;
    shopIncomeItem.orderrebate = item.orderrebate;
    shopIncomeItem.outsidemover = item.outsidemover;
    shopIncomeItem.nacommision = item.nacommision;
    shopIncomeItem.naincome = item.naincome;
    shopIncomeItem.newmember = item.newmember;
    shopIncomeItem.giverebate = item.giverebate;
    shopIncomeItem.sncommision = item.sncommision;
    shopIncomeItem.snincome = item.snincome;
    
    
    return shopIncomeItem;
    
}

+ (NSString*)entityName
{
    return @"ShopIncomeItem";
}


- (NSFetchedResultsController*)getFetchResultsControllers
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[self.class entityName]];
    fetchRequest.predicate = [NSPredicate predicateWithValue:YES];
    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc]initWithKey:@"allrebate" ascending:YES]];
    
   return [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}


@end









