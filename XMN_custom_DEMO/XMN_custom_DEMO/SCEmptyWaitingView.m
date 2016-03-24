//
//  SCEmptyWaitingView.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/22.
//  Copyright (c) 2015年 soon. All rights reserved.
//

#import "SCEmptyWaitingView.h"
#import "config_soon.h"

@implementation SCEmptyWaitingView
{
    CallBackBlock _callBackBlock;
}

-(instancetype)initWithCallBackBlock:(CallBackBlock)block mainTableView:(UITableView *)tableView
{
    self = [super init];
    
    if (self) {
        
        _callBackBlock = block;
        
        [self loadCustomViewWithTableView:tableView];
    
        self.hidden = YES;
    }
    
    [tableView addSubview:self];
    
    return self;
}

-(void)reloadEmptyViewWithDataSource:(NSMutableArray *)dataSource
{
    BOOL isHiden = (dataSource.count == 0)? NO:YES;
    
    if (isHiden) {
        
        self.hidden = YES;
        
    }else{
        
        self.hidden = NO;
    }
}

- (void)loadCustomViewWithTableView:(UITableView *)tableView
{
    _bird = [UIImageView new];
    [self addSubview:_bird];
    [_bird makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY).with.offset(-15);
    }];
    _bird.backgroundColor = [UIColor redColor];
    
    _titleLabel = [UILabel new];
    [self addSubview:_titleLabel];
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bird.mas_bottom).with.offset(10);
        make.centerX.mas_equalTo(_bird.mas_centerX);
    }];
    _titleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _titleLabel.font = [UIFont systemFontOfSize:16];
    
    _noticeLabel = [UILabel new];
    [self addSubview:_noticeLabel];
    [_noticeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_titleLabel.mas_centerX);
        make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(5);
    }];
    _noticeLabel.textColor = [UIColor orangeColor];
    _noticeLabel.font = [UIFont systemFontOfSize:16];
    _noticeLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noticeLabelWasClicked)];
    [_noticeLabel addGestureRecognizer:backTap];
}

-(void)setImageWithName:(NSString *)imageName TitleText:(NSString *)title noticeText:(NSString *)notice
{
    _bird.image = [UIImage imageNamed:imageName];
    
    _titleLabel.text = title;
    
    _noticeLabel.text = notice;
}

- (void)noticeLabelWasClicked
{
    _callBackBlock(YES);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
