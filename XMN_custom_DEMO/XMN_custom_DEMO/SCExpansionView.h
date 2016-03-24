//
//  SCExpansionView.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/21.
//  Copyright (c) 2015年 soon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RebateClickType)
{
    kRebateClickLeft = 0,
    kRebateClickRight,
};

typedef void(^TypeChangeBlock)(RebateClickType type);

@interface SCExpansionView : UIView

@property (nonatomic) NSDictionary * parameter;

@property (nonatomic) UIButton * leftButton;

@property (nonatomic) UIButton * rightButton;

@property (nonatomic) UILabel * moneyLabel;

@property (nonatomic) UIImageView * TixianImageView;

- (instancetype)initWithHeight:(CGFloat)height Parameters:(NSDictionary *)parameters;

- (void)changeButtonClickWithCallBackBlock:(TypeChangeBlock)callBackBlock;

@end
