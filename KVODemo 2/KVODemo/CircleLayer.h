//
//  CircleLayer.h
//  KVODemo
//
//  Created by pfl on 15/1/27.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CircleItem.h"

@interface CircleLayer : CALayer

@property (nonatomic, strong) NSArray *itemArr;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;

- (void)startAnimation;
@end
