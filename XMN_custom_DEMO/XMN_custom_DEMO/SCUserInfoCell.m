//
//  SCUserInfoCell.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/17.
//  Copyright (c) 2015年 soon. All rights reserved.
//

#define USERINFOFONTSIZE 13
#define EQUIVALENTFONTSIZE 12
#define BALANCEFONTSIZE 12
#define BLANCENUMBERFONTSIZE 20
#define BACKGROUNDWIDTH (450/2.0)
#define CLEARCOLOR [UIColor clearColor]

#import "SCUserInfoCell.h"
#import "config_soon.h"

@implementation SCUserInfoCell
{
    UserInfoClickBlock _callBackBlock;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createItem];
    }
    
    return self;
    
}

- (void)createItem
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self createUserInfoView];
    
    [self createEquivalentView];
    
    [self createBalanceView];
}

- (void)createUserInfoView
{
    _userNameLabel = [UILabel new];
    [self.contentView addSubview:_userNameLabel];
    [_userNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).with.offset(0);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
    _userNameLabel.text = @"用户名";
    _userNameLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    _userNameLabel.font = [UIFont systemFontOfSize:USERINFOFONTSIZE];
    _userNameLabel.backgroundColor = CLEARCOLOR;
    
    UITapGestureRecognizer *userNameTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userNameClicked)];
    [_userNameLabel addGestureRecognizer:userNameTap];
    _userNameLabel.userInteractionEnabled = YES;
    
}

- (void)createEquivalentView
{
    UIImageView * backgroundView = [UIImageView new];
    [self.contentView addSubview:backgroundView];
    [backgroundView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userNameLabel.mas_bottom).with.offset(5);
        make.centerX.mas_equalTo(_userNameLabel.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(BACKGROUNDWIDTH, 17));
    }];
    backgroundView.backgroundColor = UIColorFromRGB(MENUPAGENAVIGATIONBG);
    backgroundView.layer.cornerRadius = 17/2.0;
    backgroundView.clipsToBounds = YES;
    
    UILabel * lineUpOne = [UILabel new];
    [backgroundView addSubview:lineUpOne];
    [lineUpOne makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(backgroundView.center);
        make.size.mas_equalTo(CGSizeMake(0.5, 10));
    }];
    lineUpOne.backgroundColor = UIColorFromRGB(SEPARATELINECOLOR);
    
    UILabel * leftLabel = [UILabel new];
    [backgroundView addSubview:leftLabel];
    [leftLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backgroundView.mas_centerY);
        make.left.mas_equalTo(backgroundView.mas_left).with.offset(5);
        make.right.mas_equalTo(lineUpOne.mas_centerX).with.offset(-3);
    }];
    leftLabel.backgroundColor = CLEARCOLOR;
    leftLabel.text = @"共节省了￥0.00";
    leftLabel.font = [UIFont systemFontOfSize:EQUIVALENTFONTSIZE];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.adjustsFontSizeToFitWidth = YES;
    leftLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    
    UILabel * rightLabel = [UILabel new];
    [backgroundView addSubview:rightLabel];
    [rightLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backgroundView.mas_centerY);
        make.right.mas_equalTo(backgroundView.mas_right).with.offset(-5);
        make.left.mas_equalTo(lineUpOne.mas_centerX).with.offset(3);
    }];
    rightLabel.backgroundColor = CLEARCOLOR;
    rightLabel.text = @"相当于一包辣条";
    rightLabel.font = [UIFont systemFontOfSize:EQUIVALENTFONTSIZE];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.adjustsFontSizeToFitWidth = YES;
    rightLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
}

- (void)createBalanceView
{
    
    UIView * leftSectionView = [UIView new];
    [self.contentView addSubview:leftSectionView];
    [leftSectionView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_left).with.offset(SCREEN_WIDTH/4);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2 - 10, 50));
    }];
    leftSectionView.backgroundColor = CLEARCOLOR;
    
    UILabel *leftLabel = [UILabel new];
    [leftSectionView addSubview:leftLabel];
    [leftLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(leftSectionView.mas_bottom).with.offset(-5);
        make.centerX.mas_equalTo(leftSectionView.mas_centerX);
    }];
    leftLabel.text = @"账户余额";
    leftLabel.font = [UIFont systemFontOfSize:BALANCEFONTSIZE];
    leftLabel.backgroundColor = CLEARCOLOR;
    
    _accountBalanceLabel = [UILabel new];
    [leftSectionView addSubview:_accountBalanceLabel];
    [_accountBalanceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(leftLabel.mas_centerX).with.offset(5);
        make.top.mas_equalTo(leftSectionView.mas_top).with.offset(10);

    }];
    _accountBalanceLabel.text = @"0.00";
    _accountBalanceLabel.font = [UIFont fontWithName:NUMBERFONTNAME size:BLANCENUMBERFONTSIZE];
//    _accountBalanceLabel.font = [UIFont systemFontOfSize:BLANCENUMBERFONTSIZE];
    _accountBalanceLabel.backgroundColor = CLEARCOLOR;
    _accountBalanceLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel * sybomOne = [UILabel new];
    [leftSectionView addSubview:sybomOne];
    [sybomOne makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_accountBalanceLabel.mas_bottom);
        make.right.mas_equalTo(_accountBalanceLabel.mas_left);
    }];
    sybomOne.text = @"￥";
    sybomOne.font = [UIFont systemFontOfSize:13];
    
    UIImageView * goOne = [UIImageView new];
    [leftSectionView addSubview:goOne];
    [goOne makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_accountBalanceLabel.mas_bottom);
        make.left.mas_equalTo(_accountBalanceLabel.mas_right).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(5, 8));
    }];
    goOne.backgroundColor = [UIColor clearColor];
    [goOne setImage:[UIImage imageNamed:@"SCMyViewArros"]];
    
    UILabel * lineDownOne = [UILabel new];
    [self.contentView addSubview:lineDownOne];
    [lineDownOne makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.mas_equalTo(leftSectionView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(0.5, 25));
    }];
    lineDownOne.backgroundColor = UIColorFromRGB(SEPARATELINECOLOR);
    
    UIView * rightSectionView = [UIView new];
    [self.contentView addSubview:rightSectionView];
    [rightSectionView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_left).with.offset(SCREEN_WIDTH/4 * 3);
        make.centerY.mas_equalTo(leftSectionView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2 - 10, 50));
    }];
    rightSectionView.backgroundColor = CLEARCOLOR;
    
    UILabel *rightLabel = [UILabel new];
    [rightSectionView addSubview:rightLabel];
    [rightLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(rightSectionView.mas_bottom).with.offset(-5);
        make.centerX.mas_equalTo(rightSectionView.mas_centerX);
    }];
    rightLabel.text = @"待返利";
    rightLabel.font = [UIFont systemFontOfSize:BALANCEFONTSIZE];
    rightLabel.backgroundColor = CLEARCOLOR;
    
    _rebackMoneyLabel = [UILabel new];
    [rightSectionView addSubview:_rebackMoneyLabel];
    [_rebackMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(rightLabel.mas_centerX);
        make.top.mas_equalTo(rightSectionView.mas_top).with.offset(10);
    }];
    _rebackMoneyLabel.text = @"0.00";
    _rebackMoneyLabel.font = [UIFont fontWithName:NUMBERFONTNAME size:BLANCENUMBERFONTSIZE];
    _rebackMoneyLabel.backgroundColor = CLEARCOLOR;
    _rebackMoneyLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel * sybomTwo = [UILabel new];
    [rightSectionView addSubview:sybomTwo];
    [sybomTwo makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_rebackMoneyLabel.mas_bottom);
        make.right.mas_equalTo(_rebackMoneyLabel.mas_left);
    }];
    sybomTwo.text = @"￥";
    sybomTwo.font = [UIFont systemFontOfSize:13];
    
    UIImageView * goTwo = [UIImageView new];
    [rightSectionView addSubview:goTwo];
    [goTwo makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_rebackMoneyLabel.mas_bottom);
        make.left.mas_equalTo(_rebackMoneyLabel.mas_right).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(5, 8));
    }];
    goTwo.backgroundColor = [UIColor clearColor];
    [goTwo setImage:[UIImage imageNamed:@"SCMyViewArros"]];
    /*
        添加事件
     */
    UITapGestureRecognizer * BalanceViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(accountBlanceClicked)];
    [leftSectionView addGestureRecognizer:BalanceViewTap];
    leftSectionView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * RebateViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rebateClicked)];
    [rightSectionView addGestureRecognizer:RebateViewTap];
    rightSectionView.userInteractionEnabled = YES;
}

- (void)updateCustomViewWithBalance:(NSString *)balance rebate:(NSString *)rebate
{
    CGFloat balanceWith = [self sizeForText:balance WithMaxSize:CGSizeMake(1000, BLANCENUMBERFONTSIZE) AndWithFontSize:BLANCENUMBERFONTSIZE].width;
    CGFloat rebateWidth = [self sizeForText:rebate WithMaxSize:CGSizeMake(1000, BLANCENUMBERFONTSIZE) AndWithFontSize:BLANCENUMBERFONTSIZE].width;
    
    [_accountBalanceLabel updateConstraints:^(MASConstraintMaker *make) {

        if (balanceWith < 110) {
            make.width.mas_equalTo(balanceWith + 5);
        }else{
            make.width.mas_equalTo(110);
            _accountBalanceLabel.adjustsFontSizeToFitWidth = YES;
        }
    }];
    
    [_rebackMoneyLabel updateConstraints:^(MASConstraintMaker *make) {

        if (rebateWidth < 110) {
            make.width.mas_equalTo(rebateWidth + 5);
        }else{
            make.width.mas_equalTo(110);
            _rebackMoneyLabel.adjustsFontSizeToFitWidth = YES;
        }
    }];
}

#pragma mark - 事件

- (void)userNameClicked
{
    _callBackBlock(kUserInfoClickName);
}

- (void)accountBlanceClicked
{
    _callBackBlock(kUserInfoClickBalance);
}

- (void)rebateClicked
{
    _callBackBlock(kUserInfoClickRebate);
}

-(void)setUserInfoCellWithModel:(SCUserInfoCellModel *)model callBackBlock:(UserInfoClickBlock)block
{
    _userNameLabel.text = model.userName;
    
    _saveMoneyLabel.text = [NSString stringWithFormat:@"%.2f",[model.saveMoney floatValue]];
    _EquivalentLabel.text = model.equivalent;
    _accountBalanceLabel.text = [NSString stringWithFormat:@"%.2f",[model.balance floatValue]];
    _rebackMoneyLabel.text = [NSString stringWithFormat:@"%.2f",[model.rebate floatValue]];
    
    [self updateCustomViewWithBalance:_accountBalanceLabel.text rebate:_rebackMoneyLabel.text];
    
    _callBackBlock = block;
}

#pragma mark - 公共方法

- (CGSize) sizeForText: (NSString *) text WithMaxSize: (CGSize) maxSize AndWithFontSize: (CGFloat) fontSize
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0){
        CGRect rect = [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize: fontSize]} context:nil];
        
        return rect.size;
    }else{
        return  [text sizeWithFont:[UIFont systemFontOfSize: fontSize] constrainedToSize: maxSize];
        
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
