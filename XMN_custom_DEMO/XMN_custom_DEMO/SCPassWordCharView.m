//
//  SCPassWordCharView.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/25.
//  Copyright © 2015年 soon. All rights reserved.
//

#define SCAL_GET_WIDTH(customSize) ([UIScreen mainScreen].bounds.size.width/320.0 * (CGFloat)customSize)
#define SCAL_GET_HEIGHT(customSize) ([UIScreen mainScreen].bounds.size.height/568 * (CGFloat)customSize)

#import "SCPassWordCharView.h"

@implementation SCPassWordCharView
{
    //输入密码数量
    NSInteger _pwdNum;
    
    PSCCallBackBlock _callbackblock;
}

-(instancetype)initWithConfirmButtonClickBlock:(PSCCallBackBlock)block{
    
    self = [super init];
    
    if (self) {
        
        _callbackblock = block;
        
        [self loadCustomView];
    }
    
    return self;
}

- (UIView *)loadCustomView
{
    CGFloat padding_Y = 10;
    
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    
    UILabel *titleLab = [UILabel new];
    [self addSubview:titleLab];
    [titleLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).with.offset(ISIPHONE4S?40:70);
    }];
    titleLab.text = @"输入提现密码";
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    
    UIImageView *grayBG = [UIImageView new];
    [self addSubview:grayBG];
    [grayBG makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(SCAL_GET_WIDTH(250)));
        make.height.mas_equalTo(@(SCAL_GET_HEIGHT(45)));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(titleLab.mas_bottom).with.offset(padding_Y);
    }];
    grayBG.backgroundColor = UIColorFromRGB(WHITECOLOR);
    grayBG.layer.cornerRadius = 5;
    grayBG.clipsToBounds = YES;
    grayBG.userInteractionEnabled = YES;
    grayBG.layer.borderWidth = 1;
    grayBG.layer.borderColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR).CGColor;
    
    _passWordTextField = [UITextField new];
    [grayBG addSubview:_passWordTextField];
    [_passWordTextField makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(grayBG.centerX).with.offset(10);
        make.centerY.mas_equalTo(grayBG.centerY);
        make.width.mas_equalTo(@(SCAL_GET_WIDTH(250)));
        make.height.mas_equalTo(@(SCAL_GET_HEIGHT(45)));
    }];
    _passWordTextField.placeholder = @"请输入6位数字密码";
    _passWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    _passWordTextField.delegate = self;
    _passWordTextField.secureTextEntry = YES;
    _passWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    _passWordTextField.textAlignment = NSTextAlignmentCenter;
    _passWordTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    _inputView = [UIImageView new];
    [grayBG addSubview:_inputView];
    [_inputView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.and.bottom.mas_equalTo(grayBG);
    }];
    _inputView.backgroundColor = UIColorFromRGB(WHITECOLOR);
    _inputView.layer.borderColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR).CGColor;
    _inputView.layer.borderWidth = 1;
    
    CGFloat pointPosition =SCAL_GET_WIDTH(250) / 12.0;
    CGFloat pointWidth = pointPosition * 2;
    
    for (NSInteger i = 0; i< 6; i++) {
        
        UIImageView *number = [UIImageView new];
        [_inputView addSubview:number];
        [number makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_inputView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(10, 10));
            make.centerX.mas_equalTo(_inputView.mas_left).with.offset(pointPosition + pointWidth * i);
        }];
        number.backgroundColor = [UIColor blackColor];
        number.layer.cornerRadius = 5;
        number.clipsToBounds = YES;
        number.tag = 500 + i;
        number.hidden = YES;
        
        if (i > 0) {
            UILabel *line = [UILabel new];
            [_inputView addSubview:line];
            [line makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(_inputView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(1, 30));
                make.centerX.mas_equalTo(_inputView.mas_left).with.offset(pointWidth * i);
            }];
            line.backgroundColor = UIColorFromRGB(SEPARATELINECOLOR);
        }
    }
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_confirmBtn];
    [_confirmBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(grayBG.mas_bottom).with.offset(25);
        make.size.mas_equalTo(CGSizeMake(SCAL_GET_WIDTH(270), SCAL_GET_HEIGHT(45)));
    }];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    _confirmBtn.backgroundColor = UIColorFromRGB(YELLOWCOLOR);
    [_confirmBtn setTitleColor:UIColorFromRGB(BLACKFONTCOLOR) forState:UIControlStateNormal];
    _confirmBtn.layer.cornerRadius = SCAL_GET_HEIGHT(45)/2.0;
    _confirmBtn.clipsToBounds = YES;
    [_confirmBtn addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    _confirmBtn.hidden = YES;
    
    return self;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _passWordTextField) {
        
        if ([self isPureInt:string])
        {
            _pwdNum ++;
        }
        else if ([string isEqualToString:@""]) {
            _pwdNum --;
        }
        
        for (NSInteger i=0; i<_pwdNum; i++) {
            UIImageView *number = (UIImageView *)[_inputView viewWithTag:(500 + i)];
            number.hidden = NO;
        }
        
        if (_pwdNum == 6)
        {
            _confirmBtn.hidden = NO;
        }
        else if (_pwdNum < 6)
        {
            for (NSInteger i = _pwdNum; i < 6; i ++) {
                UIImageView *number = (UIImageView *)[_inputView viewWithTag:(500 + i)];
                number.hidden = YES;
            }
            
            _confirmBtn.hidden = YES;
        }
        else
        {
            _pwdNum = 6;
            return NO;
        }
    }
    
    return YES;
}

- (void)confirmButtonClick
{
    _callbackblock();
}

//判断是否为整形
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
