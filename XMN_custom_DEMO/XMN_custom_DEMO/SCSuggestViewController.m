//
//  SCSuggestViewController.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/16.
//  Copyright (c) 2015年 soon. All rights reserved.
//

#import "SCSuggestViewController.h"
#import "config_soon.h"

#define SCTITLEFONTSIZE 14
#define SCDESCRIPTIONFONTSIZE 12
#define ISIPHONE4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

@implementation SCSuggestViewController
{
    UILabel * _pronouncedLabel;
    
    NSMutableArray * _dataSource;
    
    suggestType _selectedType;
    
}

#pragma mark - 测试

-(void)loadParameters
{

    _dataSource = [NSMutableArray array];
    
    NSString * programMonkeysTalk = @"我叫程序猿，英文名programmer monkey。我每天都在啪啪啪...得写代码，我容易吗？！什么？我的产品有bug！有本事给我找出来啊";
    NSString * productDogsTalk = @"我叫产品汪，英文名programmer monkey。我每天都在啪啪啪...得写代码，我容易吗？！什么？我的产品有bug！有本事给我找出来啊";
    NSString * designersTalk = @"我叫设计狮，英文名programmer monkey。我每天都在啪啪啪...得写代码，我容易吗？！什么？我的产品有bug！有本事给我找出来啊";
    NSString * CEOsTalk = @"我叫西衣鸥，英文名programmer monkey。";
    
    NSArray * names = [[NSArray alloc] initWithObjects:@"产品汪",@"程序猿",@"设计狮",@"西衣鸥", nil];
    NSArray * talks = [[NSArray alloc] initWithObjects:productDogsTalk,programMonkeysTalk,designersTalk,CEOsTalk, nil];
    
    for (NSInteger i = 0; i < 4; i++) {
        NSMutableDictionary * tempDictionary = [NSMutableDictionary dictionary];
        [tempDictionary setObject:names[i] forKey:@"name"];
        [tempDictionary setObject:talks[i] forKey:@"pronounce"];
        [_dataSource addObject:tempDictionary];
    }
}

#pragma mark - 视图生命周期

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadParameters];
    
    [self setUpNavigationBar];              //设置导航栏
    
    [self createSuggestTargetView];         //初始化吐槽对象视图
    
    [self createMainSuggestView];           //初始化吐槽输入视图
    
    [self createCommitButton];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - 组装自定义视图

- (void)setUpNavigationBar
{
    self.view.backgroundColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR);
    
    [self setNavigationBarTitle:@"我要吐槽"];
    
    [self setNavigationBarLeftButtonTitle:@"返回"];
}

- (void)createSuggestTargetView
{
    const CGFloat targetWidth = (SCREEN_WIDTH - 20)/4;
    
    _suggestTargetView  = [UIImageView new];
    [self.view addSubview:_suggestTargetView];
    [_suggestTargetView makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.customNavigationBar.mas_bottom);
        make.height.mas_equalTo(@135);
    }];
    _suggestTargetView.backgroundColor = [UIColor clearColor];
    _suggestTargetView.userInteractionEnabled = YES;
    
    UILabel * targetLabel = [UILabel new];
    [_suggestTargetView addSubview:targetLabel];
    [targetLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_suggestTargetView.mas_left).with.offset(10);
        make.top.mas_equalTo(_suggestTargetView.mas_top).with.offset(10);
        make.height.mas_equalTo(@(SCTITLEFONTSIZE));
    }];
    targetLabel.backgroundColor = [UIColor clearColor];
    targetLabel.text = @"请选择吐槽对象";
    targetLabel.font = [UIFont systemFontOfSize:SCTITLEFONTSIZE];
    targetLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    
    for (NSInteger i = 0; i < 4 ; i++) {
        
        UIButton *targetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_suggestTargetView addSubview:targetButton];
        [targetButton makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_suggestTargetView.mas_left).with.offset(10 + i * targetWidth);
            make.top.mas_equalTo(targetLabel.mas_bottom).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(targetWidth, 100));
        }];
        targetButton.tag = 500 + i;
        [targetButton addTarget:self action:@selector(targetDidSelected:) forControlEvents:UIControlEventTouchUpInside];
        [targetButton setImage:[UIImage imageNamed:@"duoladuohead.jpg"] forState:UIControlStateNormal];
        targetButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 25, 5);
        targetButton.backgroundColor = [UIColor clearColor];
        
        UILabel * titleLabel = [UILabel new];
        [targetButton addSubview:titleLabel];
        [titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(targetButton.mas_centerX);
            make.top.mas_equalTo(targetButton.imageView.mas_bottom).with.offset(5);
        }];
        titleLabel.text = [_dataSource[i] objectForKey:@"name"];
        titleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
        titleLabel.font = [UIFont systemFontOfSize:13];
        
        /*
         
         targetButton.titleEdgeInsets = UIEdgeInsetsMake(70, 0, 0, 0);
         [targetButton setTitle:[_dataSource[i] objectForKey:@"name"] forState:UIControlStateNormal];
         [targetButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
         targetButton.titleLabel.font = [UIFont systemFontOfSize: 10];
         
         */
    }
}

- (void)createMainSuggestView
{
    _mainSuggetView = [UIImageView new];
    [self.view addSubview:_mainSuggetView];
    [_mainSuggetView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_suggestTargetView.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left).with.offset(10);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-10);
        make.height.mas_equalTo(@(ISIPHONE4S?220:250));
    }];
    _mainSuggetView.backgroundColor = [UIColor whiteColor];
    _mainSuggetView.layer.cornerRadius = 5;
    _mainSuggetView.clipsToBounds = YES;
    _mainSuggetView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * suggestTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mainSuggestViewTaped)];
    [_mainSuggetView addGestureRecognizer:suggestTap];
    
    
    NSString * pronouce = [_dataSource[0] objectForKey:@"pronounce"];
    CGFloat pronouceHeight = [self sizeForText:pronouce WithMaxSize:CGSizeMake(SCREEN_WIDTH - 60, 1000) AndWithFontSize:12].height;
    _pronouncedLabel = [UILabel new];
    [_mainSuggetView addSubview:_pronouncedLabel];
    [_pronouncedLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_mainSuggetView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 60, pronouceHeight + 1));
        make.top.mas_equalTo(_mainSuggetView.mas_top).with.offset(10);
    }];
    _pronouncedLabel.text = pronouce;
    _pronouncedLabel.font = [UIFont systemFontOfSize:SCDESCRIPTIONFONTSIZE];
    _pronouncedLabel.numberOfLines = 0;
    _pronouncedLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _pronouncedLabel.backgroundColor = [UIColor clearColor];
    
    _contextView = [[UITextView alloc] init];
    [_mainSuggetView addSubview:_contextView];
    [_contextView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pronouncedLabel.mas_bottom).with.offset(10);
        make.left.mas_equalTo(_mainSuggetView.mas_left).with.offset(10);
        make.right.mas_equalTo(_mainSuggetView.mas_right).with.offset(-10);
        make.height.mas_equalTo(@(ISIPHONE4S?95:110));
    }];
    _contextView.backgroundColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR);
    _contextView.layer.cornerRadius = 5;
    _contextView.clipsToBounds = YES;
    _contextView.delegate = self;
    
    _telePhoneNumberTextField = [UITextField new];
    [_mainSuggetView addSubview:_telePhoneNumberTextField];
    [_telePhoneNumberTextField makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(_contextView.width);
        make.centerX.mas_equalTo(_contextView.centerX);
        make.height.mas_equalTo(@(ISIPHONE4S?40:50));
        make.top.mas_equalTo(_contextView.mas_bottom).with.offset(10);
    }];
    _telePhoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    _telePhoneNumberTextField.backgroundColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR);
    _telePhoneNumberTextField.layer.cornerRadius = 5;
    _telePhoneNumberTextField.clipsToBounds = YES;
    _telePhoneNumberTextField.delegate = self;
}

- (void)createCommitButton
{
    UIButton * commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:commitButton];
    [commitButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.centerX);
        make.height.mas_equalTo(@(ISIPHONE4S?35:45));
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-(ISIPHONE4S?10:15));
    }];
    commitButton.backgroundColor = UIColorFromRGB(DOMINANTCOLOR);
    commitButton.layer.cornerRadius = (ISIPHONE4S?35:45)/2.0;
    commitButton.clipsToBounds = YES;
    
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    
    [commitButton addTarget:self action:@selector(commitButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 事件

- (void)targetDidSelected:(UIButton *)sender
{
    suggestType channel = sender.tag % 100;
    
    _pronouncedLabel.text = [_dataSource[channel] objectForKey:@"pronounce"];
    
    _selectedType = channel;
    
}

- (void)commitButtonClick
{
    NSLog(@"提交");
}

- (void)mainSuggestViewTaped
{
    [_contextView resignFirstResponder];
    
    [_telePhoneNumberTextField resignFirstResponder];
}

-(void)navigationLiftButonWasClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextViewDelegate



#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
