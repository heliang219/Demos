//
//  SCRebateListCell.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/22.
//  Copyright (c) 2015年 soon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCRebateListModel.h"
#import "config_soon.h"

@interface SCRebateListCell : UITableViewCell

@property (nonatomic) UILabel * TitleLabel;

@property (nonatomic) UILabel * moneyLabel;

@property (nonatomic) UILabel * detailLabel;

@property (nonatomic) UILabel * timeLabel;

@property (nonatomic) UILabel * orderNumberLabel;

@property (nonatomic) UILabel * stageLabel;

- (void)setCellWithRebateListModel:(SCRebateListModel *)model;

@end
