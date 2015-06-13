//
//  TabbarView.m
//  customTabbar
//
//  Created by pangfuli on 14-10-9.
//  Copyright (c) 2014年 pflnh. All rights reserved.
//

#import "TabbarView.h"

#define kWidth 320/5
#define kHight 44

@interface TabbarView()
{
    UIButton *_btn;
    NSArray *_arr;
}

@end

@implementation TabbarView

- (id)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
    if (self)
    {
        [self addButton];
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)addButton
{
    _arr = @[@"科技",@"新闻",@"军事",@"体育",@"收藏"];
    for (int i = 0; i < 5; i++)
    {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i * kWidth, 0, kWidth, kHight)];
        btn.tag = i;
        [btn setTitle:_arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor redColor] forState:(UIControlStateSelected)];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
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
//    if (_delegate && [_delegate respondsToSelector:@selector(btnClickFrom:to:)])
//    {
//        [_delegate btnClickFrom:_btn.tag to:btn.tag];
//    }
    
    _block(_btn.tag,btn.tag);
    NSLog(@"_btn%p",_block);
    _btn.selected = NO;
    btn.selected = YES;
    _btn = btn;
    
    
}



- (void)buttonClickblock:(btnClick)block
{
    _block = block;
   
}



@end












