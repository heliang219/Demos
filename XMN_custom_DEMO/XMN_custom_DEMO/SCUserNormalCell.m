//
//  SCUserNormalCell.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/18.
//  Copyright (c) 2015年 soon. All rights reserved.
//

#import "SCUserNormalCell.h"
#import "config_soon.h"

@implementation SCUserNormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createItem];
    }
    
    return self;
    
}

- (void)setImageView:(UIImageView *)imageView WithImageName:(NSString *)imageName
{
    imageView.image = [UIImage imageNamed:imageName];
}

- (void)createItem
{
    _headImageView = [UIImageView new];
    [self.contentView addSubview:_headImageView];
    [_headImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    _headImageView.backgroundColor = [UIColor clearColor];
    
    _customTitleLabel = [UILabel new];
    [self.contentView addSubview:_customTitleLabel];
    [_customTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headImageView.mas_right).with.offset(10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    _customTitleLabel.text = @"我的订单";
    _customTitleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    _customTitleLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    
    _symbolImageView = [UIImageView new];
    [self.contentView addSubview:_symbolImageView];
    [_symbolImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(5, 10));
    }];
    _symbolImageView.backgroundColor = [UIColor clearColor];
    _symbolImageView.image = [UIImage imageNamed:@"SCMyViewArros"];
    
    _noticeImageView = [UIImageView new];
    [self.contentView addSubview:_noticeImageView];
    [_noticeImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(_symbolImageView.mas_left).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(7, 7));
    }];
    _noticeImageView.backgroundColor = [UIColor redColor];
    _noticeImageView.layer.cornerRadius = 7/2.0;
    _noticeImageView.clipsToBounds = YES;
    _noticeImageView.hidden = YES;
    
    _line = [UILabel new];
    [self.contentView addSubview:_line];
    [_line makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    _line.backgroundColor = UIColorFromRGB(SEPARATELINECOLOR);
    
    _rightLabel = [UILabel new];
    [self.contentView addSubview:_rightLabel];
    [_rightLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).with.offset(-10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    _rightLabel.text = @"400-776-6333";
    _rightLabel.font = [UIFont fontWithName:NUMBERFONTNAME size:NORMALFONTSIZE];
    _rightLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _rightLabel.hidden = YES;
}

-(void)setCellWithHeadimageNames:(NSArray *)imageNames Titles:(NSArray *)titles indexPath:(NSIndexPath *)indexPath isLogin:(BOOL)isLogin
{
    if (imageNames.count > 0) {
        _headImageView.image = [UIImage imageNamed:imageNames[indexPath.section - 1][indexPath.row]];
    }
    if (titles.count > 0) {
        _customTitleLabel.text = titles[indexPath.section - 1][indexPath.row];
    }
    
    if (indexPath.section == 1) {
        _noticeImageView.hidden = NO;
    }
    if (indexPath.section == 3 && indexPath.row == 2) {
        _symbolImageView.hidden = YES;
        _rightLabel.hidden = NO;
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
