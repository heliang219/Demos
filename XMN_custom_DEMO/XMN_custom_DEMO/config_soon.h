//
//  config_soon.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/16.
//  Copyright (c) 2015年 soon. All rights reserved.
//

#ifndef XMN_custom_DEMO_config_soon_h
#define XMN_custom_DEMO_config_soon_h

#import "ColorDefineCollection.h"
#import "FontSizeCollection.h"
#define MAS_SHORTHAND
#import "Masonry.h"

#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ISIPHONE4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)

#define SCAL_GET_WIDTH(customSize) ([UIScreen mainScreen].bounds.size.width/320.0 * (CGFloat)customSize)
#define SCAL_GET_HEIGHT(customSize) ([UIScreen mainScreen].bounds.size.height/568 * (CGFloat)customSize)
#define IS_EQUAL_TO_NULL(string) (!string || [string isKindOfClass:[NSNull class]] || [string isEqualToString: @"<null>"] || [string isEqualToString: @"(null)"] || [[string stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]  isEqualToString: @""])

#define SC_BACKGROUND_COLOR [UIColor colorWithRed:246/255.0 green:245/255.0 blue:240/255.0 alpha:1.0]
#define MAINCOLOR 0XFFB400

// 展示TabBar
#define SHOW_TAB_BAR (@"showTabBar")

// 隐藏TabBar
#define HIDE_TAB_BAR (@"hideTabBar")


#endif
