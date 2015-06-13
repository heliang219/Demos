//
//  TabbarView.m
//  customTabbar
//
//  Created by pangfuli on 14-10-9.
//  Copyright (c) 2014年 pflnh. All rights reserved.
//

#import "TabbarView.h"
#define kWidth 320/5


@interface TabbarView()
{
    UIButton *_btn;
    NSArray *_array;
}

@end

@implementation TabbarView

- (id)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
    if (self) {
        [self addButton];
        
        
    }
    return self;
}

- (void)addButton
{
    _array = @[@"头条",@"科技",@"动态",@"空间",@"收藏"];
    for (int i = 0; i < 5; i++)
    {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth * i, 0, kWidth, 44)];
        btn.tag = i;
        [btn setTitle:_array[i] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor redColor] forState:(UIControlStateSelected)];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        btn.backgroundColor = [UIColor whiteColor];
        [self addSubview:btn];
        if(i == 0)
        {
            btn.selected = YES;
            _btn = btn;
        }
    }
}

- (void)btnClick:(UIButton*)btn
{
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(btnClickFrom:to:)]) {
        [_delegate btnClickFrom:_btn.tag to:btn.tag];
        
    }
    _btn.selected = NO;
    btn.selected = YES;
    _btn = btn;
    
}


@end
