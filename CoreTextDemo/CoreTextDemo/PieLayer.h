//
//  PieLayer.h
//  CoreTextDemo
//
//  Created by pangfuli on 15/1/10.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PieLayer : CALayer
@property (nonatomic, assign) CGFloat percentage;
@property (nonatomic, strong) UIColor *corlor;
@property (nonatomic, assign) CGPoint pieCenter1;
@property (nonatomic, assign) CGPoint pieCenter2;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, strong) NSArray *itemArr;
@property (nonatomic, strong) NSArray *corlorArr;
@property (nonatomic, assign) float startAngle;//default 0
@property (nonatomic, assign) float endAngle;//default 360
@property (nonatomic, strong,readonly) NSArray *values;

- (void)startDrawItem:(NSArray*)itemsArr color:(NSArray*)colorArr;
@end
