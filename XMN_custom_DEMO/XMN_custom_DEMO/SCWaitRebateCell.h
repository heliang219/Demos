//
//  SCWaitRebateCell.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/10/8.
//  Copyright © 2015年 soon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCWaitRebateModel.h"

@interface SCWaitRebateCell : UITableViewCell

/**
 *  标题
 */
@property (nonatomic) UILabel * titleLabel;

/**
 *  金额
 */
@property (nonatomic) UILabel * moneyLabel;

/**
 *  订单号
 */
@property (nonatomic) UILabel * orderNumberLabel;

/**
 *  状态
 */
@property (nonatomic) UILabel * statusLabel;

/**
 *  日期
 */
@property (nonatomic) UILabel * dateLabel;

- (void)setCellWithModel:(SCWaitRebateModel *)model;

@end
