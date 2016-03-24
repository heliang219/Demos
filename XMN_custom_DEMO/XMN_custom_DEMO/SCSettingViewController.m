//
//  SCSettingViewController.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/24.
//  Copyright © 2015年 soon. All rights reserved.
//

#define SCAL_GET_WIDTH(customSize) ([UIScreen mainScreen].bounds.size.width/320.0 * (CGFloat)customSize)

#import "SCSettingViewController.h"
#import "SCStandardCell.h"
#import "SCSetTiXianPassWordViewController.h"
#import "SCMessageSettingViewController.h"
#import "config_soon.h"

@interface SCSettingViewController ()
{
    NSArray * titles;
}

@end

@implementation SCSettingViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self loadParameters];
    
    [self setUpCustomTabBar];
    
    [self loadMainTableView];
    
    [self loadHeaderView];
    
    [self loadFooterView];
}

- (void)loadParameters
{
    titles = [NSArray arrayWithObjects:@[@"修改登录密码",@"设置提现密码",@"消息提醒设置"],@[@"清除缓存",@"版本信息"],@[@"服务协议",@"联系客服"], nil];
}

#pragma mark - 装载自定义视图

- (void)setUpCustomTabBar
{
    self.customNavigationBar.backgroundColor = UIColorFromRGB(WHITECOLOR);
    self.view.backgroundColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR);
}

- (void)loadMainTableView
{
    _mainTableView = [UITableView new];
    [self.view addSubview:_mainTableView];
    [_mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavigationBar.mas_bottom);
        make.left.right.and.bottom.mas_equalTo(self.view);
    }];
    _mainTableView.backgroundColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR);
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableView.scrollEnabled = NO;
    [_mainTableView registerClass:[SCStandardCell class] forCellReuseIdentifier:@"SCStandardCell"];
}


- (void)loadHeaderView
{
    UIImageView * headerView = [UIImageView new];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, ISIPHONE4S?40:50);
    headerView.backgroundColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR);
    _mainTableView.tableHeaderView = headerView;
    
    UILabel * titleLabel = [UILabel new];
    [headerView addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerView.mas_left).with.offset(10);
        make.centerY.mas_equalTo(headerView.mas_centerY);
    }];
    titleLabel.text = @"手机号";
    titleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    titleLabel.font = [UIFont systemFontOfSize:16];
    
    UILabel * telephoneLabel = [UILabel new];
    [headerView addSubview:telephoneLabel];
    [telephoneLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headerView.mas_right).with.offset(-10);
        make.centerY.mas_equalTo(headerView.mas_centerY);
    }];
    telephoneLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    telephoneLabel.font = [UIFont fontWithName:NUMBERFONTNAME size:17];
    telephoneLabel.text = [self telePhoneNumberPassWordChar:@"18559268927"];
}

- (void)loadFooterView
{
    UIImageView * footerView = [UIImageView new];
    footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 65);
    footerView.backgroundColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR);
    footerView.userInteractionEnabled = YES;
    _mainTableView.tableFooterView = footerView;
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerView addSubview:button];
    [button makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footerView.mas_centerX);
        make.bottom.mas_equalTo(footerView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCAL_GET_WIDTH(270), 45));
    }];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 45/2.0;
    button.clipsToBounds = YES;
    button.layer.borderWidth = 0.2;
    button.layer.borderColor = UIColorFromRGB(GRAYFONTCOLOR).CGColor;
    
    [button setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [button addTarget:self action:@selector(logOutButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - UITableViewDataSource  UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SCStandardCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SCStandardCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 2 && indexPath.row == 1) {
        
        [cell setCellWithTitle:titles[indexPath.section][indexPath.row] DetailText:@"400-776-6333" imageName:nil];
    }else{
        
        [cell setCellWithTitle:titles[indexPath.section][indexPath.row]  DetailText:nil imageName:@"SCMyViewBigArros"];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        
        return 3;
    }
    
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (ISIPHONE4S) {
        return 40;
    }
    
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 0;
    }
    
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            SCSetTiXianPassWordViewController *VC = [[SCSetTiXianPassWordViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
        else if (indexPath.row == 2){
            SCMessageSettingViewController *VC = [[SCMessageSettingViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
}

#pragma mark - 通用方法

- (NSString *)telePhoneNumberPassWordChar:(NSString *)phoneNumber
{
    return [phoneNumber stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
}

#pragma mark - 响应事件

- (void)logOutButtonClick
{
    NSLog(@"登出");
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
