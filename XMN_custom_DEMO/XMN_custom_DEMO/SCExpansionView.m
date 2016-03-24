//
//  SCExpansionView.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/21.
//  Copyright (c) 2015年 soon. All rights reserved.
//

#import "SCExpansionView.h"
#import "config_soon.h"

#define FontSize 14

@implementation SCExpansionView
{
    TypeChangeBlock _callBackBlock;
}

- (instancetype)initWithHeight:(CGFloat)height Parameters:(NSDictionary *)parameters;

{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    
    if (self) {
        
        [self setUpCustomView];     //设置自定义视图
        
        [self setUpSelector];       //设置响应事件
    }
    return self;
}

-(void)changeButtonClickWithCallBackBlock:(TypeChangeBlock)callBackBlock
{
    _callBackBlock = callBackBlock;
}

- (void)setUpCustomView
{
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel * lineOne = [UILabel new];
    [self addSubview:lineOne];
    [lineOne makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
        make.bottom.mas_equalTo(self.bottom).with.offset(-40);
    }];
    lineOne.backgroundColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR);
    
    UILabel * lineTwo = [UILabel new];
    [self addSubview:lineTwo];
    [lineTwo makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(0.5, 15));
        make.centerY.mas_equalTo(self.bottom).with.offset(-20);
    }];
    lineTwo.backgroundColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR);
    
    UILabel * lineUp = [UILabel new];
    [self addSubview:lineUp];
    [lineUp makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
        make.top.mas_equalTo(self.top).with.offset(0);
    }];
    lineUp.backgroundColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR);
    
    UILabel * lineDown = [UILabel new];
    [self addSubview:lineDown];
    [lineDown makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
        make.bottom.mas_equalTo(self.bottom).with.offset(0);
    }];
    lineDown.backgroundColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR);
    
    
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_leftButton];
    [_leftButton makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2 - 10, 38));
        make.centerX.mas_equalTo(self.mas_centerX).with.offset(- SCREEN_WIDTH/4);
        make.centerY.mas_equalTo(lineTwo.mas_centerY);
    }];
    _leftButton.backgroundColor = [UIColor clearColor];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_rightButton];
    [_rightButton makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2 - 10, 38));
        make.centerX.mas_equalTo(self.mas_centerX).with.offset(SCREEN_WIDTH/4);
        make.centerY.mas_equalTo(lineTwo.mas_centerY);
    }];
    _rightButton.backgroundColor = [UIColor clearColor];

    [_leftButton setTitle:@"全部类型" forState:UIControlStateNormal];
    [_leftButton setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:FontSize];
    
    [_rightButton setTitle:@"全部时间" forState:UIControlStateNormal];
    [_rightButton setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:FontSize];
    
    UILabel * titleLabel = [UILabel new];
    [self addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(15);
        make.top.mas_equalTo(self.mas_top).with.offset(15);
    }];
    titleLabel.text = @"账户余额";
    titleLabel.font = [UIFont systemFontOfSize:FontSize];
    titleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    
    _moneyLabel = [UILabel new];
    [self addSubview:_moneyLabel];
    [_moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(30);
        make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(15);
        make.height.mas_equalTo(@22);
    }];
    _moneyLabel.text = @"314.69";
    _moneyLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _moneyLabel.backgroundColor = [UIColor clearColor];
    _moneyLabel.font = [UIFont fontWithName:NUMBERFONTNAME size:22];
    
    UILabel * symbol = [UILabel new];
    [self addSubview:symbol];
    [symbol makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_moneyLabel.mas_bottom);
        make.right.mas_equalTo(_moneyLabel.mas_left);
        make.height.mas_equalTo(@12);
    }];
    symbol.text = @"￥";
    symbol.font = [UIFont systemFontOfSize:12];
    symbol.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    
    _TixianImageView = [UIImageView new];
    [self addSubview:_TixianImageView];
    [_TixianImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.offset(12);
        make.right.mas_equalTo(self.mas_right).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    _TixianImageView.backgroundColor = [UIColor orangeColor];
    _TixianImageView.layer.cornerRadius = 30;
    _TixianImageView.clipsToBounds = YES;
}

- (void)setUpSelector
{
    _leftButton.tag = 100;
    _rightButton.tag = 101;
    
    [_leftButton addTarget:self action:@selector(ChangeButtonClickWithTag:) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton addTarget:self action:@selector(ChangeButtonClickWithTag:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)ChangeButtonClickWithTag:(UIButton *)sender
{
    RebateClickType channel = sender.tag % 100;
    
    switch (channel) {
        case kRebateClickLeft:
            _callBackBlock(kRebateClickLeft);
            break;
        
        case kRebateClickRight:
            _callBackBlock(kRebateClickRight);
            break;
            
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
