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


@property (nonatomic, assign) double_t todayrebate;
@property (nonatomic, assign) double_t  ystdayrebate;
@property (nonatomic, assign) double_t  allrebate;
@property (nonatomic, assign) double_t  availablerebate;
@property (nonatomic, assign) double_t  todayturnover;
@property (nonatomic, assign) double_t  ystdayturnover;
@property (nonatomic, assign) double_t  allturnover;
@property (nonatomic, assign) double_t  outsidemover;
@property (nonatomic, assign) double_t  availbleturnover;
@property (nonatomic, assign) int64_t  newmember;
@property (nonatomic, assign) int64_t  allmember;
@property (nonatomic, assign) int64_t  todayorder;
@property (nonatomic, assign) int64_t  allorder;
@property (nonatomic, assign) double_t  orderrebate;
@property (nonatomic, assign) double_t  giverebate;
@property (nonatomic, assign) double_t  todayoutsidemover;
@property (nonatomic, assign) double_t  outrebatemover;
@property (nonatomic, assign) double_t  naincome;
@property (nonatomic, assign) double_t  nacommision;
@property (nonatomic, assign) double_t  adincome;
@property (nonatomic, assign) double_t  adcommision;
@property (nonatomic, assign) double_t  sncommision;
@property (nonatomic, assign) double_t  snincome;


+ (instancetype)insertShopIncomeItem:(ShopIncomeItem*)item inManagedObjectContext:(NSManagedObjectContext*)managedContext;
- (NSFetchedResultsController*)getFetchResultsControllers;

@end





