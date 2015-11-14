//
//  CircleView.m
//  KVODemo
//
//  Created by pfl on 15/1/27.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "CircleView.h"



@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.contentsScale = [UIScreen mainScreen].scale;
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;

    }
    return self;
}


+ (Class)layerClass
{
    return [CircleLayer class];
}







@end
