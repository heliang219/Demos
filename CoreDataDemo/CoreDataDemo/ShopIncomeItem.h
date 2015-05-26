//
//  Entity.h
//  CoreDataDemo
//
//  Created by pfl on 15/5/26.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ShopIncomeItem : NSManagedObject

@property (nonatomic, retain) NSNumber * todayrebate;
@property (nonatomic, retain) NSNumber * ystdayrebate;
@property (nonatomic, retain) NSNumber * allrebate;
@property (nonatomic, retain) NSNumber * availablerebate;
@property (nonatomic, retain) NSNumber * todayturnover;
@property (nonatomic, retain) NSNumber * ystdayturnover;
@property (nonatomic, retain) NSNumber * allturnover;
@property (nonatomic, retain) NSNumber * outsidemover;
@property (nonatomic, retain) NSNumber * availbleturnover;
@property (nonatomic, retain) NSNumber * newmember;
@property (nonatomic, retain) NSNumber * allmember;
@property (nonatomic, retain) NSNumber * todayorder;
@property (nonatomic, retain) NSNumber * allorder;
@property (nonatomic, retain) NSNumber * orderrebate;
@property (nonatomic, retain) NSNumber * giverebate;
@property (nonatomic, retain) NSNumber * todayoutsidemover;
@property (nonatomic, retain) NSNumber * outrebatemover;
@property (nonatomic, retain) NSNumber * naincome;
@property (nonatomic, retain) NSNumber * nacommision;
@property (nonatomic, retain) NSNumber * adincome;
@property (nonatomic, retain) NSNumber * adcommision;
@property (nonatomic, retain) NSNumber * sncommision;
@property (nonatomic, retain) NSNumber * snincome;
+ (instancetype)insertShopIncomeItem:(ShopIncomeItem*)item inManagedObjectContext:(NSManagedObjectContext*)managedContext;
- (NSFetchedResultsController*)fetchResultsController;
@end
