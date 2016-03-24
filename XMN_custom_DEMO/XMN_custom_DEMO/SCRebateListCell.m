//
//  SCRebateListCell.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/22.
//  Copyright (c) 2015年 soon. All rights reserved.
//

#define FONT(fontsize) [UIFont systemFontOfSize:(CGFloat)fontsize]
#define CELLTITLEFONTSIZE 15
#define CELLDETAILFONTSIZE 14
#define CELLNUMBERFONTSIZE 18
#define CELLSMALLFONTSIZE 14

#import "SCRebateListCell.h"

@implementation SCRebateListCell

#pragma mark - 方法

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createCustomContentView];
        
    }
    
    return self;
}

-(void)setCellWithRebateListModel:(SCRebateListModel *)model
{
    _TitleLabel.text = model.title;
    _detailLabel.text = model.detail;
    _moneyLabel.text = model.money;
    _timeLabel.text = model.time;
    _stageLabel.text = model.stage;
    
    if ([model.orderNumber isEqualToString:@""] || model.orderNumber == nil) {
        _orderNumberLabel.hidden = YES;
    }else{
        _orderNumberLabel.text = model.orderNumber;
    }
}

#pragma mark - 装在自定义视图

- (void)createCustomContentView
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self createLine];
    
    [self createItemLineOne];
    
    [self createItemLineTwo];
    
}

- (void)createItemLineOne
{
    _TitleLabel = [UILabel new];
    [self addSubview:_TitleLabel];
    [_TitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.offset(15);
        make.left.mas_equalTo(self.mas_left).with.offset(10);
    }];
    _TitleLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    _TitleLabel.font = FONT(CELLTITLEFONTSIZE);
    
    UIView * line = [UIView new];
    [self addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_TitleLabel.mas_right).with.offset(10);
        make.centerY.mas_equalTo(_TitleLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(1, 15));
    }];
    line.backgroundColor = UIColorFromRGB(SEPARATELINECOLOR);
    
    _moneyLabel = [UILabel new];
    [self addSubview:_moneyLabel];
    [_moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_TitleLabel.centerY);
        make.right.mas_equalTo(self.mas_right).with.offset(-10);
    }];
    _moneyLabel.textColor = [UIColor greenColor];
    _moneyLabel.font = [UIFont fontWithName:NUMBERFONTNAME size:CELLNUMBERFONTSIZE];
    
    _detailLabel = [UILabel new];
    [self addSubview:_detailLabel];
    [_detailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_TitleLabel.mas_centerY);
        make.left.mas_equalTo(line.mas_right).with.offset(10);
    }];
    _detailLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _detailLabel.font = FONT(CELLDETAILFONTSIZE);
}

- (void)createItemLineTwo
{
    _timeLabel = [UILabel new];
    [self addSubview:_timeLabel];
    [_timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    _timeLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _timeLabel.font = FONT(CELLSMALLFONTSIZE);
    
    _orderNumberLabel = [UILabel new];
    [self addSubview:_orderNumberLabel];
    [_orderNumberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).with.offset(-10);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    _orderNumberLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _orderNumberLabel.font = FONT(CELLSMALLFONTSIZE);
    
    _stageLabel = [UILabel new];
    [self addSubview:_stageLabel];
    [_stageLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_timeLabel.mas_left);
        make.top.mas_equalTo(_timeLabel.mas_bottom).with.offset(5);
    }];
    _stageLabel.font = FONT(CELLSMALLFONTSIZE);
    _stageLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
}

- (void)createLine
{
    UILabel * lineUp = [UILabel new];
    [self addSubview:lineUp];
    [lineUp makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    lineUp.backgroundColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR);
    
    UILabel * lineDown = [UILabel new];
    [self addSubview:lineDown];
    [lineDown makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    lineDown.backgroundColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR);
}

#pragma mark -

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
