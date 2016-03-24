//
//  SCWaitRebateViewController.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/29.
//  Copyright © 2015年 soon. All rights reserved.
//

#import "UIBaseViewController.h"

@interface SCWaitRebateViewController : UIBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic) UITableView * mainTableView;

@property(nonatomic) UIView * headerView;

@end
