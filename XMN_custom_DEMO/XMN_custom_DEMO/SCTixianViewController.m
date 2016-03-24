//
//  SCTixianViewController.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/10/15.
//  Copyright © 2015年 soon. All rights reserved.
//

#import "SCTixianViewController.h"
#import "config_soon.h"

@interface SCTixianViewController ()
{
    NSArray * _cellHeights;
    
    CGFloat _height;
}

@end

@implementation SCTixianViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setParameters];
    
    [self setUpCustomNavigationBar];
    
    [self loadMainTableView];

}

#pragma mark - 自定义视图

- (void)setParameters
{
    _cellHeights = [NSArray arrayWithObjects:@"130",@"150",@"95",@"125", nil];
}

- (void)setUpCustomNavigationBar
{
    [self setNavigationBarTitle:@"提现"];
    
    [self setNavigationBarLeftButtonImage:@"utility_back"];
    
    self.view.backgroundColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR);
}

- (void)loadMainTableView
{
    _mainTableView = [UITableView new];
    [self.view addSubview:_mainTableView];
    [_mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavigationBar.mas_bottom);
        make.right.left.and.bottom.mas_equalTo(self.view);
    }];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableView.backgroundColor = SC_BACKGROUND_COLOR;
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    CGFloat height = [_cellHeights[indexPath.section] floatValue];
    
    return height;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _height = _mainTableView.contentOffset.y;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _mainTableView.contentOffset = CGPointMake(0, ISIPHONE4S?120:iPhone5?30:0);

    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    [UIView animateWithDuration:0.3 animations:^{
       
        _mainTableView.contentOffset = CGPointMake(0, 0);
        
    } completion:^(BOOL finished) {

    }];
    
    if (IS_EQUAL_TO_NULL(_accountNumberTextField.text) || IS_EQUAL_TO_NULL(_nameTextField.text) || IS_EQUAL_TO_NULL(_exportMoneyTextField.text)) {
        
        [self resetConfirmButtonTypeWithType:kConfirmButtonTypeDisable];
        
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:_accountNumberTextField]) {
        [_nameTextField becomeFirstResponder];
    }
    else if ([textField isEqual:_nameTextField]){
        [_exportMoneyTextField becomeFirstResponder];
    }
    else{
        [_exportMoneyTextField resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (!IS_EQUAL_TO_NULL(_accountNumberTextField.text) && !IS_EQUAL_TO_NULL(_nameTextField.text) && !IS_EQUAL_TO_NULL(_exportMoneyTextField.text)) {
        
        [self resetConfirmButtonTypeWithType:kConfirmButtonTypeEnable];
        
    }
    
    if ([textField isEqual:_exportMoneyTextField]) {
        if (!IS_EQUAL_TO_NULL(string) && ![self isPureInt:string] && ![string isEqualToString:@"."]) {
            
            return NO;
        }
    }
    
    return YES;
}

- (void)hideKeyBoard
{
    [_exportMoneyTextField resignFirstResponder];
    
    [_nameTextField resignFirstResponder];
    
    [_accountNumberTextField resignFirstResponder];
}

#pragma mark - 自定义contentview

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    for (id subView in cell.contentView.subviews) {
        
        if ([subView isKindOfClass:[UIView class]]) {
            
            UIView *vie = (UIView *)subView;
            [vie removeFromSuperview];
        }
    }
    
    switch (indexPath.section) {
            
        case 0:
            [cell.contentView addSubview:[self createHeaderViewWithIndexPath:indexPath]];
            break;
            
        case 1:
            [cell.contentView addSubview:[self createInputViewWithIndexPath:indexPath]];
            break;
            
        case 2:
            [cell.contentView addSubview:[self createConfirmButtonViewWithIndexPath:indexPath]];
            break;
            
        case 3:
            [cell.contentView addSubview:[self createNoticeViewWithIndexPath:indexPath]];
            break;
            
        default:

            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (UIView *)createNoticeViewWithIndexPath:(NSIndexPath *)indexpath
{
    UIView *contentView = [[UIView alloc] init];
    contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [_cellHeights[indexpath.section] floatValue]);
    contentView.backgroundColor = SC_BACKGROUND_COLOR;
//    contentView.backgroundColor = [UIColor greenColor];
    
    UILabel * titleLab = [UILabel new];
    [contentView addSubview:titleLab];
    [titleLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView.mas_left).with.offset(10);
        make.top.mas_equalTo(contentView.mas_top);
    }];
    titleLab.text = @"提现须知";
    titleLab.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    titleLab.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    
    UILabel * noticeLab = [UILabel new];
    [contentView addSubview:noticeLab];
    [noticeLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentView.mas_top).with.offset(20);
        make.left.mas_equalTo(titleLab.mas_left);
        make.right.mas_equalTo(contentView.mas_right).with.offset(-10);
        make.bottom.mas_equalTo(contentView.mas_bottom).with.offset(0);
    }];
    
    noticeLab.numberOfLines = 0;
    noticeLab.backgroundColor = [UIColor clearColor];
    noticeLab.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    noticeLab.font = [UIFont systemFontOfSize:12];
    noticeLab.text = @"1，提现每日最高限额为50000.00元，最低2.00元。\n2，每笔提现的手续费为2.00元，从转出金额中扣除。\n3，转账仅支持实名认证的支付宝账户。\n4，可提现金额为商家返利的金额；平台赠送的补贴返利和活动返利不予提现。";

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:noticeLab.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:5];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [noticeLab.text length])];
    noticeLab.attributedText = attributedString;
    [noticeLab sizeToFit];
    
    return contentView;
}

- (UIView *)createConfirmButtonViewWithIndexPath:(NSIndexPath *)indexpath
{
    UIView *contentView = [[UIView alloc] init];
    contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [_cellHeights[indexpath.section] floatValue]);
    contentView.backgroundColor = SC_BACKGROUND_COLOR;
    
    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addSubview:_confirmButton];
    [_confirmButton makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(25, 25,25,25));
    }];
    _confirmButton.layer.cornerRadius = 45/2.0;
    _confirmButton.clipsToBounds = YES;
    [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    _confirmButton.titleLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    [_confirmButton addTarget:self action:@selector(confirmButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self resetConfirmButtonTypeWithType:kConfirmButtonTypeDisable];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    [contentView addGestureRecognizer:tap];
    
    return contentView;
}

- (void)resetConfirmButtonTypeWithType:(confirmButtonType)type
{
    switch (type) {
            
        case kConfirmButtonTypeDisable:
            _confirmButton.backgroundColor = UIColorFromRGB(AUXILIARYSPECIALFUNC);
            [_confirmButton setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
            break;

        case kConfirmButtonTypeEnable:
            _confirmButton.backgroundColor = UIColorFromRGB(MAINCOLOR);
            [_confirmButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

- (UIView *)createInputViewWithIndexPath:(NSIndexPath *)indexpath
{
    UIView *contentView = [[UIView alloc] init];
    contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [_cellHeights[indexpath.section] floatValue]);
    contentView.backgroundColor = SC_BACKGROUND_COLOR;
    
    UIImageView * background = [UIImageView new];
    [contentView addSubview:background];
    [background makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    background.backgroundColor = UIColorFromRGB(WHITECOLOR);
    background.layer.cornerRadius = 5;
    background.clipsToBounds = YES;
    background.userInteractionEnabled = YES;
    
    [self createLinesWithSuperView:background];
    
    UILabel * accountLab = [UILabel new];
    [background addSubview:accountLab];
    [accountLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(background.mas_left).with.offset(10);
        make.centerY.mas_equalTo(background.mas_centerY).with.offset(-50);
    }];
    accountLab.text = @"支付宝账号";
    accountLab.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    accountLab.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    
    UILabel * nameLab = [UILabel new];
    [background addSubview:nameLab];
    [nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(background.mas_left).with.offset(10);
        make.centerY.mas_equalTo(background.mas_centerY).with.offset(0);
    }];
    nameLab.text = @"姓名";
    nameLab.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    nameLab.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    
    UILabel * exportMoneyLab = [UILabel new];
    [background addSubview:exportMoneyLab];
    [exportMoneyLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(background.mas_left).with.offset(10);
        make.centerY.mas_equalTo(background.mas_centerY).with.offset(50);
    }];
    exportMoneyLab.text = @"转出金额";
    exportMoneyLab.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    exportMoneyLab.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    
    _accountNumberTextField = [UITextField new];
    [background addSubview:_accountNumberTextField];
    [_accountNumberTextField makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(background.mas_right).with.offset(-10);
        make.centerY.mas_equalTo(accountLab.mas_centerY);
        make.left.mas_equalTo(accountLab.mas_right).with.offset(10);
        make.height.mas_equalTo(@45);
        make.width.mas_equalTo(@200);
    }];
    _accountNumberTextField.placeholder = @"请输入";
    _accountNumberTextField.textAlignment = NSTextAlignmentRight;
    _accountNumberTextField.font = [UIFont fontWithName:NUMBERFONTNAME size:NORMALFONTSIZE];
    
    _nameTextField = [UITextField new];
    [background addSubview:_nameTextField];
    [_nameTextField makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(background.mas_right).with.offset(-10);
        make.centerY.mas_equalTo(nameLab.mas_centerY);
        make.left.mas_equalTo(nameLab.mas_right).with.offset(10);
        make.height.mas_equalTo(@45);
        make.width.mas_equalTo(@200);
    }];
    _nameTextField.placeholder = @"请输入";
    _nameTextField.textAlignment = NSTextAlignmentRight;
    _nameTextField.font = [UIFont fontWithName:NUMBERFONTNAME size:NORMALFONTSIZE];
    
    _exportMoneyTextField = [UITextField new];
    [background addSubview:_exportMoneyTextField];
    [_exportMoneyTextField makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(background.mas_right).with.offset(-10);
        make.centerY.mas_equalTo(exportMoneyLab.mas_centerY);
        make.left.mas_equalTo(exportMoneyLab.mas_right).with.offset(10);
        make.height.mas_equalTo(@45);
        make.width.mas_equalTo(@200);
    }];
    _exportMoneyTextField.placeholder = @"请输入";
    _exportMoneyTextField.textAlignment = NSTextAlignmentRight;
    _exportMoneyTextField.font = [UIFont fontWithName:NUMBERFONTNAME size:NORMALFONTSIZE];
    
    _accountNumberTextField.delegate = self;
    _nameTextField.delegate = self;
    _exportMoneyTextField.delegate = self;
    
    _exportMoneyTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    return contentView;
}

- (UIView *)createHeaderViewWithIndexPath:(NSIndexPath *)indexpath
{
    UIView *contentView = [[UIView alloc] init];
    contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [_cellHeights[indexpath.section] floatValue]);
    contentView.backgroundColor = SC_BACKGROUND_COLOR;
    
    UIImageView * background = [UIImageView new];
    [contentView addSubview:background];
    [background makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(2, 5, 20, 5));
    }];
    background.backgroundColor = UIColorFromRGB(WHITECOLOR);
    
    UILabel * titleLabel = [UILabel new];
    [background addSubview:titleLabel];
    
    _rebateLabel = [UILabel new];
    [background addSubview:_rebateLabel];
    
    UILabel * noticeLabel = [UILabel new];
    [background addSubview:noticeLabel];
    
    UILabel * symbolLab = [UILabel new];
    [background addSubview:symbolLab];
    [symbolLab makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_rebateLabel.mas_bottom);
        make.right.mas_equalTo(_rebateLabel.mas_left);
    }];
    symbolLab.text = @"￥";
    symbolLab.font = [UIFont systemFontOfSize:16];
    
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_rebateLabel.mas_top).with.offset(-SCAL_GET_HEIGHT(10));
        make.centerX.mas_equalTo(background.mas_centerX);
    }];
    
    [_rebateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(background.mas_centerY);
        make.centerX.mas_equalTo(background.mas_centerX);
    }];
    
    [noticeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_rebateLabel.mas_bottom).with.offset(SCAL_GET_HEIGHT(10));
        make.centerX.mas_equalTo(background.mas_centerX);
    }];
    
    _rebateLabel.text = @"314.69";
    _rebateLabel.font = [UIFont fontWithName:NUMBERFONTNAME size:30];
    _rebateLabel.textColor = UIColorFromRGB(BLACKCOLOR);
    titleLabel.text = @"可提现金额";
    titleLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    titleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    noticeLabel.text = @"仅商家返利可用";
    noticeLabel.font = [UIFont systemFontOfSize:12];
    noticeLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    
    UITapGestureRecognizer * hideKeyBoard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    [contentView addGestureRecognizer:hideKeyBoard];
    
    return contentView;
}

- (void)createLinesWithSuperView:(UIView *)superView
{
    UILabel * line_1 = [UILabel new];
    [superView addSubview:line_1];
    [line_1 makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
        make.centerX.mas_equalTo(superView.mas_centerX);
        make.centerY.mas_equalTo(superView.mas_centerY).with.offset(- 25);
    }];
    line_1.backgroundColor = SC_BACKGROUND_COLOR;
    
    UILabel * line_2 = [UILabel new];
    [superView addSubview:line_2];
    [line_2 makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
        make.centerX.mas_equalTo(superView.mas_centerX);
        make.centerY.mas_equalTo(superView.mas_centerY).with.offset(25);
    }];
    line_2.backgroundColor = SC_BACKGROUND_COLOR;
    
}

#pragma mark - 事件

- (void)confirmButtonClick
{
    NSLog(@"确认");
}

- (void)navigationLiftButonWasClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - separate

//判断是否为整形
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

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
