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
    }
    return self;
}


+ (Class)layerClass
{
    return [CircleLayer class];
}







@end
