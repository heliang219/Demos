//
//  SCCollectionCell.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/10/9.
//  Copyright © 2015年 soon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCCollectionModel.h"

@interface SCCollectionCell : UITableViewCell

/**
 *  预览图
 */
@property (nonatomic) UIImageView * HeadImage;

/**
 *  节省规则图片
 */
@property (nonatomic) UIImageView * bargainRuleImage;

/**
 *  新用户规则图片
 */
@property (nonatomic) UIImageView * NewUserRuleImage;

/**
 *  餐厅名字
 */
@property (nonatomic) UILabel * titleLabel;

/**
 *  价格
 */
@property (nonatomic) UILabel * priceLabel;

/**
 *  位置
 */
@property (nonatomic) UILabel * positionLabel;

/**
 *  订单量
 */
@property (nonatomic) UILabel * ordersLabel;

/**
 *  节省规则
 */
@property (nonatomic) UILabel * bargainRuleLabel;

/**
 *  新用户规则
 */
@property (nonatomic) UILabel * NewUserRuleLabel;


- (void)setCellWithCollectionModel:(SCCollectionModel *)model;

@end
