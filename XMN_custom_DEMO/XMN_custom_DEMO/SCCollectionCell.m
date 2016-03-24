//
//  SCCollectionCell.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/10/9.
//  Copyright © 2015年 soon. All rights reserved.
//

#define CLTITLEFONTSIZE 17
#define CLNORMALFONTSIZE 15

#import "SCCollectionCell.h"
#import "config_soon.h"

@implementation SCCollectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createItem];
    }
    
    return self;
}

#pragma mark - 装载自定义视图

- (void)createItem
{
    [self createHeadImage];
    
    [self createLineOne];
    
    [self createLineTwo];
    
    [self createLineThree];
    
    [self createLineFour];
}

- (void)createLineFour
{
    
    _NewUserRuleImage = [UIImageView new];
    [self.contentView addSubview:_NewUserRuleImage];
    
    _NewUserRuleLabel = [UILabel new];
    [self.contentView addSubview:_NewUserRuleLabel];
    
    [_NewUserRuleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bargainRuleLabel.mas_left);
        make.top.mas_equalTo(_NewUserRuleImage.mas_top).with.offset(0);
        make.width.mas_equalTo(@(SCAL_GET_WIDTH(200)));
    }];

    [_NewUserRuleImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bargainRuleLabel.mas_bottom).with.offset(5);
        make.left.mas_equalTo(_bargainRuleImage.mas_left);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    _NewUserRuleImage.backgroundColor = [UIColor purpleColor];
    
    _NewUserRuleLabel.numberOfLines = 0;
    [self SetCustomLabel:_NewUserRuleLabel With:UIColorFromRGB(GRAYFONTCOLOR) fontSize:CLNORMALFONTSIZE];
}

- (void)createLineThree
{
    _bargainRuleImage = [UIImageView new];
    [self.contentView addSubview:_bargainRuleImage];
    [_bargainRuleImage makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.bottom.mas_equalTo(_HeadImage.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    _bargainRuleImage.backgroundColor = [UIColor redColor];
    
    _bargainRuleLabel = [UILabel new];
    [self.contentView addSubview:_bargainRuleLabel];
    [_bargainRuleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bargainRuleImage.mas_right).with.offset(5);
        make.top.mas_equalTo(_bargainRuleImage.mas_top);
        make.width.mas_equalTo(@200);
    }];
    _bargainRuleLabel.numberOfLines = 0;
    [self SetCustomLabel:_bargainRuleLabel With:UIColorFromRGB(GRAYFONTCOLOR) fontSize:CLNORMALFONTSIZE];
}

- (void)createLineTwo
{
    _priceLabel = [UILabel new];
    [self.contentView addSubview:_priceLabel];
    [_priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.centerY.mas_equalTo(_HeadImage.mas_centerY).with.offset(3);
    }];
    _priceLabel.font = [UIFont fontWithName:NUMBERFONTNAME size:CLNORMALFONTSIZE];
    _priceLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _priceLabel.backgroundColor = [UIColor clearColor];
    
    _positionLabel = [UILabel new];
    [self.contentView addSubview:_positionLabel];
    [_positionLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_priceLabel.mas_centerY);
        make.left.mas_equalTo(_priceLabel.mas_right).with.offset(10);
    }];
    [self SetCustomLabel:_positionLabel With:UIColorFromRGB(GRAYFONTCOLOR) fontSize:CLNORMALFONTSIZE];
    _positionLabel.backgroundColor = [UIColor clearColor];
    
    _ordersLabel = [UILabel new];
    [self.contentView addSubview:_ordersLabel];
    [_ordersLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-10);
        make.centerY.mas_equalTo(_priceLabel.mas_centerY);
    }];
    [self SetCustomLabel:_ordersLabel With:UIColorFromRGB(GRAYFONTCOLOR) fontSize:CLNORMALFONTSIZE];
}

- (void)createLineOne
{
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_HeadImage.mas_top).with.offset(2);
        make.left.mas_equalTo(_HeadImage.mas_right).with.offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-10);
    }];
    [_titleLabel adjustsFontSizeToFitWidth];
    [self SetCustomLabel:_titleLabel With:UIColorFromRGB(BLACKFONTCOLOR) fontSize:CLTITLEFONTSIZE];
    
    UILabel * line = [UILabel new];
    [self.contentView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 30, 0.5));
    }];
    line.backgroundColor = UIColorFromRGB(SEPARATELINECOLOR);
}

- (void)createHeadImage
{
    _HeadImage = [UIImageView new];
    [self.contentView addSubview:_HeadImage];
    [_HeadImage makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(SCAL_GET_HEIGHT(15));
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(SCAL_GET_WIDTH(10));
        make.size.mas_equalTo(CGSizeMake(SCAL_GET_WIDTH(70), SCAL_GET_WIDTH(70)));
    }];
    _HeadImage.backgroundColor = [UIColor orangeColor];
    _HeadImage.layer.cornerRadius = 5;
    _HeadImage.clipsToBounds = YES;
}

#pragma mark -  通用方法

- (void)SetCustomLabel:(UILabel *)label With:(UIColor *)color fontSize:(CGFloat)fontSize
{
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = color;
}

#pragma mark - 设置参数

-(void)setCellWithCollectionModel:(SCCollectionModel *)model
{
    _titleLabel.text = model.title;
    _priceLabel.text = [NSString stringWithFormat:@"￥%ld/人",(long)[model.money integerValue]];
    _positionLabel.text = model.position;
    _ordersLabel.text = [NSString stringWithFormat:@"%ld单",(long)[model.orders integerValue]];
    _bargainRuleLabel.text = model.bargainRule;
    _NewUserRuleLabel.text = model.NewUserRule;
    
    if (IS_EQUAL_TO_NULL(model.NewUserRule)) {
        
        _NewUserRuleImage.hidden = YES;
        
        _NewUserRuleLabel.hidden = YES;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
