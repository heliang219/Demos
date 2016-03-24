//
//  SCRebateListViewController.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/18.
//  Copyright (c) 2015年 soon. All rights reserved.
//

#import "UIBaseViewController.h"
#import "SCExpansionView.h"

@interface SCRebateListViewController : UIBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) UITableView * mainTableView;

@property (nonatomic) SCExpansionView * expansionView;

@end
