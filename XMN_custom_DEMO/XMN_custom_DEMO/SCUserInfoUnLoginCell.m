//
//  SCUserInfoUnLoginCell.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/18.
//  Copyright (c) 2015年 soon. All rights reserved.
//

#import "SCUserInfoUnLoginCell.h"
#import "config_soon.h"

@implementation SCUserInfoUnLoginCell
{
    LoginBlock _callBackBlock;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self loadItem];
        
    }
    
    return self;
}

- (void)loadItem
{
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:loginButton];
    [loginButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
    loginButton.backgroundColor = UIColorFromRGB(DOMINANTCOLOR);
    loginButton.layer.cornerRadius = 20;
    loginButton.clipsToBounds = YES;
    
    [loginButton setTitle:@"登录/注册" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [loginButton addTarget:self action:@selector(LoginButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)LoginButtonClick
{
    _callBackBlock();
}

-(void)callBackWithBlock:(LoginBlock)block
{
    _callBackBlock = block;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
