//
//  NextTableViewController.h
//  CoreDataDemo
//
//  Created by pfl on 15/5/26.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopIncomeItem;
@class NSFetchedResultsController;
@interface NextTableViewController : UITableViewController
@property (nonatomic, strong) NSFetchedResultsController *fetchResultController;
- (instancetype)initWithShopIncomeItem:(ShopIncomeItem*)shopIcomeItem;


@end
