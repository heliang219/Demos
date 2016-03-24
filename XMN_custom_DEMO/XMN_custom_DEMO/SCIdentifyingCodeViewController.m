//
//  SCIdentifyingCodeViewController.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/10/13.
//  Copyright © 2015年 soon. All rights reserved.
//

#import "SCIdentifyingCodeViewController.h"
#import "config_soon.h"

@interface SCIdentifyingCodeViewController ()
{
    UIView * _finalBackgroundView;
}

@end

@implementation SCIdentifyingCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpCustomNavigationItem];
    
    [self setUpCustomView];
}

#pragma mark - 自定义视图

- (void)setUpCustomNavigationItem
{
    [self setNavigationBarTitle:@"设置提现密码"];
    
    [self setNavigationBarLeftButtonImage:@"utility_back"];
}

- (void)setUpCustomView
{
    [self setUpSelfView];
    
    [self createHeaderView];
    
    [self createMidderView];
    
    [self createBottomView];
    
    [self createConfirmButton];
    
    [self createFinalView];
}

- (void)createFinalView
{
    _finalBackgroundView = [UIView new];
    [self.view addSubview:_finalBackgroundView];
    [_finalBackgroundView makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCAL_GET_HEIGHT(30)));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(_confirmButton.mas_bottom).with.offset(ISIPHONE4S?5:10);
    }];
    _finalBackgroundView.backgroundColor = [UIColor clearColor];
    
    UILabel * noticeLabel = [UILabel new];
    [_finalBackgroundView addSubview:noticeLabel];
    [noticeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_finalBackgroundView.mas_centerY);
        make.centerX.mas_equalTo(_finalBackgroundView.mas_centerX).with.offset(- 40);
    }];
    noticeLabel.text = @"收不到短信？使用";
    noticeLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    noticeLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    
    UIButton * voiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_finalBackgroundView addSubview:voiceButton];
    [voiceButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_finalBackgroundView.mas_centerY);
        make.left.mas_equalTo(noticeLabel.mas_right).with.offset(5);
    }];
    [voiceButton setTitle:@"语音验证码" forState:UIControlStateNormal];
    [voiceButton setTitleColor:UIColorFromRGB(DOMINANTCOLOR) forState:UIControlStateNormal];
    voiceButton.titleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    [voiceButton addTarget:self action:@selector(voiceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    _finalBackgroundView.hidden = YES;
}

- (void)setUpSelfView
{
    self.view.backgroundColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR);
    UITapGestureRecognizer * tapToHideKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:tapToHideKeyboard];
}

- (void)createConfirmButton
{
    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_confirmButton];
    [_confirmButton makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCAL_GET_WIDTH(270), SCAL_GET_HEIGHT(45)));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(_identifyTextField.mas_bottom).with.offset(ISIPHONE4S?20:25);
    }];
    _confirmButton.backgroundColor = UIColorFromRGB(AUXILIARYSPECIALFUNC);
    _confirmButton.layer.cornerRadius = SCAL_GET_HEIGHT(45)/2.0;
    _confirmButton.clipsToBounds = YES;
    [_confirmButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_confirmButton setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
    [_confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)createBottomView
{
    UIView * bottomView = [UIView new];
    [self.view addSubview:bottomView];
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.customNavigationBar.mas_bottom).with.offset(SCAL_GET_HEIGHT(90));
        make.height.mas_equalTo(SCAL_GET_HEIGHT(50));
    }];
    bottomView.backgroundColor = UIColorFromRGB(WHITECOLOR);
    
    _identifyTextField = [UITextField new];
    [bottomView addSubview:_identifyTextField];
    [_identifyTextField makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 10, 5, 10));
    }];
    _identifyTextField.backgroundColor = [UIColor clearColor];
    _identifyTextField.placeholder = @"请输入验证码";
    _identifyTextField.keyboardType = UIKeyboardTypeNumberPad;
    _identifyTextField.delegate = self;
}

- (void)createMidderView
{
    UIView * middleBG = [UIView new];
    [self.view addSubview:middleBG];
    [middleBG makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.customNavigationBar.mas_bottom).with.offset(SCAL_GET_HEIGHT(40));
        make.height.mas_equalTo(SCAL_GET_HEIGHT(50));
    }];
    
    _telephoneNumberLabel = [UILabel new];
    [middleBG addSubview:_telephoneNumberLabel];
    [_telephoneNumberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(middleBG.mas_centerY);
        make.left.mas_equalTo(middleBG.mas_left).with.offset(10);
    }];
    _telephoneNumberLabel.text = @"手机号 18617105521";
    _telephoneNumberLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _telephoneNumberLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    
    _getIdentifyCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [middleBG addSubview:_getIdentifyCodeButton];
    [_getIdentifyCodeButton makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCAL_GET_WIDTH(80), SCAL_GET_WIDTH(30)));
        make.centerY.mas_equalTo(middleBG.mas_centerY);
        make.right.mas_equalTo(middleBG.mas_right).with.offset(-10);
    }];
    _getIdentifyCodeButton.backgroundColor = UIColorFromRGB(MAINCOLOR);
    [_getIdentifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _getIdentifyCodeButton.titleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    _getIdentifyCodeButton.layer.cornerRadius = 5;
    _getIdentifyCodeButton.clipsToBounds = YES;
    [_getIdentifyCodeButton addTarget:self action:@selector(getIdentifyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * line = [UILabel new];
    [middleBG addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_getIdentifyCodeButton.mas_left).with.offset(-5);
        make.centerY.mas_equalTo(_getIdentifyCodeButton.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(0.5, SCAL_GET_HEIGHT(15)));
    }];
    line.backgroundColor = UIColorFromRGB(SEPARATELINECOLOR);
    
    middleBG.backgroundColor = [UIColor clearColor];
}

- (void)createHeaderView
{
    UIView * noticeBackGroudView = [UIView new];
    [self.view addSubview:noticeBackGroudView];
    [noticeBackGroudView makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.customNavigationBar.mas_bottom);
        make.height.mas_equalTo(SCAL_GET_HEIGHT(40));
    }];
    noticeBackGroudView.backgroundColor = [UIColor colorWithRed:255/255.0 green:246/255.0 blue:213/255.0 alpha:1];
    
    UILabel * textLabel = [UILabel new];
    [noticeBackGroudView addSubview:textLabel];
    [textLabel makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(noticeBackGroudView.center);
    }];
    textLabel.text = @"第一步：手机验证 >> 第二步：重置提现密码";
    textLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    textLabel.textColor = UIColorFromRGB(BUTTON_DISABLEBG);
}

#pragma mark - 事件

- (void)hideKeyBoard
{
    [_identifyTextField resignFirstResponder];
}

- (void)getIdentifyButtonClick
{
    NSLog(@"clicked");
}

- (void)confirmButtonClick
{
    NSLog(@"confirm");
    
    [_identifyTextField resignFirstResponder];
}

- (void)voiceButtonClick
{
    NSLog(@"语音验证");
    
    [_identifyTextField resignFirstResponder];
}

- (void)navigationLiftButonWasClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -  UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger count = textField.text.length;
    
    if (count >= 5) {
        
        if (count == 5 && !IS_EQUAL_TO_NULL(string)) {
            [self setConfirmStageWithType:kConfirmEnabel];
        }
        else if (count == 6 && IS_EQUAL_TO_NULL(string)) {
            [self setConfirmStageWithType:kConfirmUNEnabel];
        }
        else if (count == 6) {
            
            if (IS_EQUAL_TO_NULL(string)) {
                
                return YES;
            }
            else {
                
                return NO;
            }
        }
    }
    
    return YES;
}

- (void)setConfirmStageWithType:(confirmEnableType)type
{
    switch (type) {
        case kConfirmEnabel:
            _finalBackgroundView.hidden = NO;
            [_confirmButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
            _confirmButton.backgroundColor = UIColorFromRGB(MAINCOLOR);
            break;
            
        case kConfirmUNEnabel:
            _finalBackgroundView.hidden = YES;
            [_confirmButton setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
            _confirmButton.backgroundColor = UIColorFromRGB(AUXILIARYSPECIALFUNC);
            break;
            
        default:
            break;
    }
}
#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
