//
//  SCWaitRebateCell.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/10/8.
//  Copyright © 2015年 soon. All rights reserved.
//

#define TITLEFONTSIZE 15
#define SUBFONTSIZE 13

#import "SCWaitRebateCell.h"
#import "config_soon.h"

@implementation SCWaitRebateCell
{
    UILabel * symbol;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self loadCustomView];
    }
    
    return self;
}

- (void)loadCustomView
{
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(10);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(SCAL_GET_HEIGHT(10));
    }];
    [self SetCustomLabel:_titleLabel With:UIColorFromRGB(BLACKFONTCOLOR) fontSize:TITLEFONTSIZE];
    
    _moneyLabel = [UILabel new];
    [self.contentView addSubview:_moneyLabel];
    [_moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-10);
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(SCAL_GET_HEIGHT(10));
    }];
    [self SetCustomLabel:_moneyLabel With:UIColorFromRGB(BLACKFONTCOLOR) fontSize:TITLEFONTSIZE];
    
    _orderNumberLabel = [UILabel new];
    [self.contentView addSubview:_orderNumberLabel];
    [_orderNumberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(SCAL_GET_HEIGHT(10));
    }];
    [self SetCustomLabel:_orderNumberLabel With:UIColorFromRGB(GRAYFONTCOLOR) fontSize:SUBFONTSIZE];
    
    UILabel * line = [UILabel new];
    [self.contentView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    line.backgroundColor = UIColorFromRGB(SEPARATELINECOLOR);
    
    _statusLabel = [UILabel new];
    [self.contentView addSubview:_statusLabel];
    [_statusLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_orderNumberLabel.mas_centerY);
        make.right.mas_equalTo(_moneyLabel.mas_right);
    }];
    
    [self SetCustomLabel:_statusLabel With:UIColorFromRGB(GRAYFONTCOLOR) fontSize:SUBFONTSIZE];
    
    _dateLabel = [UILabel new];
    [self.contentView addSubview:_dateLabel];
    [_dateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_statusLabel.mas_right);
        make.bottom.mas_equalTo(line.mas_bottom).with.offset(- SCAL_GET_HEIGHT(10));
    }];
    [self SetCustomLabel:_dateLabel With:UIColorFromRGB(GRAYFONTCOLOR) fontSize:SUBFONTSIZE];
    
    UIImageView * imageLine = [UIImageView new];
    [self.contentView addSubview:imageLine];
    [imageLine makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
        make.centerY.mas_equalTo(self.contentView.mas_bottom).with.offset(-SCAL_GET_HEIGHT(35));
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
    imageLine.backgroundColor = UIColorFromRGB(SEPARATELINECOLOR);
    
    symbol = [UILabel new];
    [self.contentView addSubview:symbol];
    [symbol makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_moneyLabel.mas_bottom);
    }];
    symbol.text = @"￥";
    [self SetCustomLabel:symbol With:UIColorFromRGB(BLACKCOLOR) fontSize:10];
}

- (void)SetCustomLabel:(UILabel *)label With:(UIColor *)color fontSize:(CGFloat)fontSize
{
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = color;
}

-(void)setCellWithModel:(SCWaitRebateModel *)model
{
    _titleLabel.text = model.title;
    _moneyLabel.text = [NSString stringWithFormat:@"%.2f",[model.money floatValue]];
    _orderNumberLabel.text = [NSString stringWithFormat:@"订单号:%@",model.orderNumber];
    _statusLabel.text = model.status;
    _dateLabel.text = model.date;
    
    [symbol updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_moneyLabel.mas_left);
    }];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
