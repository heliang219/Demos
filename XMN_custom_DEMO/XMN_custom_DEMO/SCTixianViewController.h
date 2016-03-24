//
//  SCTixianViewController.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/10/15.
//  Copyright © 2015年 soon. All rights reserved.
//

#import "UIBaseViewController.h"

typedef NS_ENUM( NSInteger,confirmButtonType)
{
    
    kConfirmButtonTypeEnable = 1,
    kConfirmButtonTypeDisable
};

@interface SCTixianViewController : UIBaseViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic) UITableView * mainTableView;

@property (nonatomic) UILabel * rebateLabel;

@property (nonatomic) UITextField * accountNumberTextField;

@property (nonatomic) UITextField * nameTextField;

@property (nonatomic) UITextField * exportMoneyTextField;

@property (nonatomic) UIButton * confirmButton;

@end
