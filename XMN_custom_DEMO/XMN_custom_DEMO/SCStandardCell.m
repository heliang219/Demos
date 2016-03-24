//
//  SCStandardCell.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/24.
//  Copyright © 2015年 soon. All rights reserved.
//

#define FONT(size) [UIFont systemFontOfSize:(NSInteger)size]
#define TITLEFONTSIZI 14

#import "SCStandardCell.h"
#import "config_soon.h"

@implementation SCStandardCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createCustomContentView];
        
    }
    
    return self;
}

-(void)setCellWithTitle:(NSString *)title DetailText:(NSString *)text imageName:(NSString *)imageName
{
    _CustomTileLabel.text = title;
    
    _symbolImageView.image = [UIImage imageNamed:imageName];
    
    if (text) {

        _rightLabel.text = text;
        _rightLabel.hidden = NO;
        
        [_rightLabel updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).with.offset(- 10);
        }];
    }
    
        [_symbolImageView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            if (_rightLabel.hidden == YES) {
                make.right.mas_equalTo(self.mas_right).with.offset(-10);
            }else{
                make.right.mas_equalTo(_rightLabel.mas_left).with.offset(-5);
            }
            make.size.mas_equalTo(CGSizeMake(7, 13));
        }];
    
}

#pragma mark - 自定义视图

- (void)createCustomContentView
{
    [self createLine];
    
    [self createCustomLabel];
    
    [self createSymbolImageView];
}


- (void)createCustomLabel
{
    _CustomTileLabel = [UILabel new];
    [self addSubview:_CustomTileLabel];
    [_CustomTileLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    _CustomTileLabel.font = FONT(TITLEFONTSIZI);
    _CustomTileLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    
    _rightLabel = [UILabel new];
    [self addSubview:_rightLabel];
    [_rightLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    _rightLabel.font = [UIFont fontWithName:NUMBERFONTNAME size:TITLEFONTSIZI];
    _rightLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    _rightLabel.hidden = YES;
}

- (void)createSymbolImageView
{
    _symbolImageView = [UIImageView new];
    [self addSubview:_symbolImageView];
    _symbolImageView.backgroundColor = [UIColor clearColor];
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
