//
//  DrawView.h
//  CoreTextDemo
//
//  Created by pfl on 15/1/8.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PieLayer;

@interface DrawView : UIView

@property (nonatomic, assign) CGFloat percentage;
@property (nonatomic, strong) UIColor *corlor;
@property (nonatomic, assign) CGPoint pieCenter1;
@property (nonatomic, assign) CGPoint pieCenter2;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, strong) NSArray *itemArr;
@property (nonatomic, strong) NSArray *corlorArr;
@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;
- (void)startDraw;

@end

@interface DrawView (ex)

@property (nonatomic, strong) PieLayer *layer;

@end
