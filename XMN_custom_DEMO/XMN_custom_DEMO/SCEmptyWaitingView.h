//
//  SCEmptyWaitingView.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/22.
//  Copyright (c) 2015年 soon. All rights reserved.
//

/**
    1.  初始化视图
    2.  设置视图停靠位置
    3.  设置显示内容
    4.  刷新视图
 */

#import <UIKit/UIKit.h>

typedef void(^CallBackBlock)(BOOL isClick);

@interface SCEmptyWaitingView : UIView

@property (nonatomic) UILabel * noticeLabel;

@property (nonatomic) UILabel * titleLabel;

@property (nonatomic) UIImageView * bird;

-(instancetype)initWithCallBackBlock:(CallBackBlock)block mainTableView:(UITableView *)tableView;

-(void)reloadEmptyViewWithDataSource:(NSMutableArray *)dataSource;

-(void)setImageWithName:(NSString *)imageName TitleText:(NSString *)title noticeText:(NSString *)notice;

@end
