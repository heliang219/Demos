//
//  SCUserNormalCell.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/18.
//  Copyright (c) 2015年 soon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCUserNormalCell : UITableViewCell

/**
 *  标志性图片
 */
@property (nonatomic) UIImageView * headImageView;

/**
 *  标题名称
 */
@property (nonatomic) UILabel * customTitleLabel;

/**
 *  消息提示标志
 */
@property (nonatomic) UIImageView * noticeImageView;

/**
 *  向右箭头
 */
@property (nonatomic) UIImageView * symbolImageView;

@property (nonatomic) UILabel * line;

@property (nonatomic) UILabel * rightLabel;

-(void)setCellWithHeadimageNames:(NSArray *)imageNames Titles:(NSArray *)titles indexPath:(NSIndexPath *)indexPath isLogin:(BOOL)isLogin;
@end
