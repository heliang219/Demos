//
//  SCCollectionViewController.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/10/9.
//  Copyright © 2015年 soon. All rights reserved.
//

#import "UIBaseViewController.h"

@interface SCCollectionViewController : UIBaseViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) UITableView * mainTableView;

@property (nonatomic) NSMutableArray * dataSource;

@end
