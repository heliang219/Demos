//
//  SCMessageSettingCell.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/28.
//  Copyright © 2015年 soon. All rights reserved.
//
#define FONT(size) [UIFont systemFontOfSize:(NSInteger)size]
#define TITLEFONTSIZE 16
#define DETAILFONTSIZE 12

#import "SCMessageSettingCell.h"
#import "config_soon.h"

@implementation SCMessageSettingCell
{
    MessageNoticeBlock _block;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createLine];
        
        [self loadCustomContentView];
        
        [self createSymbolImageView];
    }
    
    return self;
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

- (void)loadCustomContentView
{
    _CustomTileLabel = [UILabel new];
    [self addSubview:_CustomTileLabel];
    [_CustomTileLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(10);
        make.bottom.mas_equalTo(self.mas_centerY).with.offset(-SCAL_GET_HEIGHT(0));
        make.height.mas_equalTo(@(TITLEFONTSIZE));
    }];
    _CustomTileLabel.font = FONT(TITLEFONTSIZE);
    _CustomTileLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    
    _CustomDetailLabel = [UILabel new];
    [self addSubview:_CustomDetailLabel];
    [_CustomDetailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).with.offset(self.frame.size.height/4);
        make.left.mas_equalTo(self.contentView.mas_left).with.offset(10);
    }];
    _CustomDetailLabel.font = FONT(DETAILFONTSIZE);
    _CustomDetailLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
}

- (void)createSymbolImageView
{
    _symbolImageView = [UIImageView new];
    [self addSubview:_symbolImageView];
    [_symbolImageView makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).with.offset(-10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(SCAL_GET_WIDTH(40), SCAL_GET_HEIGHT(25)));
    }];
    _symbolImageView.backgroundColor = [UIColor orangeColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ImageTap)];
    _symbolImageView.userInteractionEnabled = YES;
    [_symbolImageView addGestureRecognizer:tap];
}

- (void)ImageTap
{
    _block();
}

- (void)setCellWithTitle:(NSString *)title DetailText:(NSString *)text imageName:(NSString *)imageName NoticeBlock:(MessageNoticeBlock)block
{
    _block = block;
    _CustomTileLabel.text = title;
    _CustomDetailLabel.text = text;
    _symbolImageView.image = [UIImage imageNamed:imageName];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
