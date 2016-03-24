//
//  CustomerTabBar.h
//  XMNiao_Customer
//
//  Created by Esc on 14/10/21.
//  Copyright (c) 2014年 Luo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    LPSlideDirectionRight = 0,
    LPSlideDirectionLeft
} LPSlideDirection;

@interface CustomerTabBar : UIViewController<UINavigationControllerDelegate>
{
    
	NSArray  *_viewControllers;
	NSArray  *_nomalImageArray;
	NSArray  *_hightlightedImageArray;
	long      _seletedIndex;
	NSArray  *_previousNavViewController;
//    UIView *_tabBarView;
    
    
}

@property (nonatomic,retain) NSArray  *previousNavViewController;
@property (nonatomic,retain) NSArray  *viewControllers;
@property (nonatomic,assign) long      seletedIndex;
@property (nonatomic, retain) UIView *tabBarView;
- (void)tabBarButtonClicked:(UIButton *)sender;
- (void)showTabBar:(LPSlideDirection)direction animated:(BOOL)isAnimated;
- (void)hideTabBar:(LPSlideDirection)direction animated:(BOOL)isAnimated;
- (void)setTabBarBackgroundColor:(UIColor *)color;

@end
