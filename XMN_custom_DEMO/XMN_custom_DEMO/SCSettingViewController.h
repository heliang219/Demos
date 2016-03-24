//
//  SCSettingViewController.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/24.
//  Copyright © 2015年 soon. All rights reserved.
//

#import "UIBaseViewController.h"

@interface SCSettingViewController : UIBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) UITableView * mainTableView;

@end
