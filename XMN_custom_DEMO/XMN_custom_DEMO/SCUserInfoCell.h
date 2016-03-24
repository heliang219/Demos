//
//  SCUserInfoCell.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/17.
//  Copyright (c) 2015年 soon. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SCUserInfoCellModel.h"

typedef NS_ENUM(NSInteger, UserInfoClickType)
{
    kUserInfoClickName = 0,
    kUserInfoClickBalance,
    kUserInfoClickRebate,
};


typedef void(^UserInfoClickBlock)(UserInfoClickType clickType);

@interface SCUserInfoCell : UITableViewCell

@property (nonatomic) UILabel * userNameLabel;

@property (nonatomic) UILabel * saveMoneyLabel;

@property (nonatomic) UILabel * EquivalentLabel;

@property (nonatomic) UILabel * accountBalanceLabel;

@property (nonatomic) UILabel * rebackMoneyLabel;


- (void)setUserInfoCellWithModel:(SCUserInfoCellModel *)model callBackBlock:(UserInfoClickBlock)block;

@end
