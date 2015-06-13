//
//  TabbarView.h
//  customTabbar
//
//  Created by pangfuli on 14-10-9.
//  Copyright (c) 2014年 pflnh. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@protocol btnClickDelegate <NSObject>

@required
- (void)btnClickFrom:(NSInteger)from to:(NSInteger)to;

@end

typedef void(^btnClick)(NSInteger from, NSInteger to);

@interface TabbarView : UIView
@property (nonatomic, weak) id<btnClickDelegate>delegate;
@property (nonatomic, strong) btnClick block;


- (void)buttonClickblock:(btnClick)block;

@end
