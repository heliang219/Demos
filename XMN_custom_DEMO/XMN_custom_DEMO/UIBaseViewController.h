//
//  UIBaseViewController.h
//  ZhongChou-iOS
//
//  Created by Esc on 14-8-7.
//  Copyright (c) 2014年 Esc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerTabBar.h"

// 自定义标记
#define CUSTOM_LEFT_TAG (100)

#define CUSTOM_RIGHT_TAG (101)

#define CUSTOM_TITLE_TAG (102)

@class EscTabButton;
@interface UIBaseViewController : UIViewController

@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *customNavigationBar;

//设置导航淡出跟随那个scrollview
//- (void)followRollingScrollView:(UIView *)scrollView;
//设置导航栏左Button图片
- (void)setNavigationBarLeftButtonImage:(NSString *)leftButtonImageStr;
//设置导航栏右Button图片
- (void)setNavigationBarRightButtonImage:(NSString *)rightButtonImageStr;
//弹窗
- (void)showMyMessage:(NSString*)aInfo;
//设置导页面标题
- (void)setNavigationBarTitle:(NSString *)titleLabel;
//判断一个NSNumber是否是整数
- (BOOL)isInteger:(NSNumber *)number;
//显示、隐藏tabBar
- (void)showTabBar;
- (void)hideTabBar;
//隐藏导航栏左Button
- (void)hideNavigationBarLeftButton;
- (void)showNavigationBarLeftButton;
// 设置导航栏左Button的标题
- (void) setNavigationBarLeftButtonTitle: (NSString *)leftButtonTitleStr;
// 设置导航栏右Button标题
- (void) setNavigationBarRightButtonTitle: (NSString *)rightButtonTitleStr;
// 左导航按钮点击事件
- (void)navigationLiftButonWasClick:(UIButton *)sender;
// 又导航按钮点击事件
- (void)navigationRightButtonWasClick:(UIButton *)sender;
// 展示progressView
- (void) showProgressView;
// 隐藏progressView
- (void) hideProgressView;
// 关闭键盘，参数为需要关闭键盘的视图的父视图
- (void) closeKeyboardWithSuperView: (UIView*) superView;
// MD5加密
- (NSString *)md5:(NSString *)str;
// 加密处理
- (NSString *)MD5EncipherWhitMD5Str:(NSString *)MD5Str;
// 获取设备xinx
- (NSString *)getCurrentDeviceModel;
// 添加tittleView的点击事件
- (void) addTitleViewTapGesture;

// 用于求高度或宽度
- (CGSize) sizeForText: (NSString *) text WithMaxSize: (CGSize) maxSize AndWithFontSize: (CGFloat) fontSize;

// 设置导航栏
- (void) setCustomNavigationBar;
// 隐藏导航栏
- (void) hidenCustomNavigationBar;
// 不隐藏导航栏
- (void) showCustonNavigationBar;

- (NSString *) stringFromInteger: (NSInteger) integerValue;
- (NSString *) stringFromFloat: (CGFloat) floatValue;



@end
