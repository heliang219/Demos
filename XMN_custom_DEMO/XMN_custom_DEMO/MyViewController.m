//
//  MyViewController.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/17.
//  Copyright (c) 2015年 soon. All rights reserved.
//

#import "MyViewController.h"
#import "SCUserInfoCell.h"
#import "SCUserNormalCell.h"
#import "SCUserInfoUnLoginCell.h"
#import "SCSettingViewController.h"
#import "SCCollectionViewController.h"
#import "SCWaitRebateViewController.h"
#import "config_soon.h"

#define HEADERVIEWHEIGHT 150
#define HEADIMAGEWIDTH 80
#define SYSTEMFONT(size) [UIFont systemFontOfSize:(float)size]

@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UITableView * _mainTableView;
    UIButton * _customLeftNavigationButton;
    UIButton * _customRightNavigationButton;
    UILabel * _customTitleLabel;
    UIImageView * _headerImageView;
    UIImageView *headIMG;
    
    NSArray * _imageNames;
    NSArray * _titles;
    
    BOOL isLogin;
}

@end

@implementation MyViewController

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.customNavigationBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    isLogin = YES;
    
    [self loadCustomView];      //组装自定义视图
    
}

#pragma mark - TEST XXXXXXXXXXXXX

-(SCUserInfoCellModel *)testModel
{
    
    _titles = [NSArray arrayWithObjects:@[@"我的订单",@"我的优惠券",@"我的收藏"],@[@"寻蜜客专区"],@[@"我要吐槽",@"关于我们",@"联系客服"], nil];
    _imageNames = [NSArray arrayWithObjects:@[@"SCMyView_order",@"SCMyView_ticket",@"SCMyView_collection"],@[@"SCMyView_XNN"],@[@"SCMyView_advice",@"SCMyView_about",@"SCMyView_tel"], nil];
    
    SCUserInfoCellModel * model = [[SCUserInfoCellModel alloc] init];
    
    model.isLogin = YES;
    model.userName = @"哆啦沫喵";
    model.saveMoney = @"1.30";
    model.equivalent = @"相当于一包辣条";
    model.balance = @"2093.3";
    model.rebate = @"76.3";
    
    return model;
}

#pragma mark - 组装视图控件

- (void)loadCustomView;
{

    [self configCustomNavigationBar];       //配置导航栏参数
    
    [self loadMainTableView];               //组装maintableview
    
    [self loadLeftCustomButton];
    
    [self loadRightCustomButton];
    
    [self loadHeaderView];
    
}

- (void)configCustomNavigationBar
{
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColorFromRGB(DOMINANTCOLOR) colorWithAlphaComponent:0]] forBarMetrics:UIBarMetricsDefault];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)loadMainTableView
{
    _mainTableView = [UITableView new];
    _mainTableView.frame = [[UIScreen mainScreen] bounds];
    _mainTableView.contentInset = UIEdgeInsetsMake(HEADERVIEWHEIGHT, 0, 0, 0);
    _mainTableView.backgroundColor = UIColorFromRGB(MENUPAGENAVIGATIONBG);
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [_mainTableView registerClass:[SCUserInfoCell class] forCellReuseIdentifier:@"userInfoCell"];
    [_mainTableView registerClass:[SCUserNormalCell class] forCellReuseIdentifier:@"userInfoNormalCell"];
    [_mainTableView registerClass:[SCUserInfoUnLoginCell class] forCellReuseIdentifier:@"SCUserInfoUnLoginCell"];
    [self.view addSubview:_mainTableView];
}

- (void)loadLeftCustomButton
{
    _customLeftNavigationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _customLeftNavigationButton.frame = CGRectMake(0, 0, 30, 30);
    [_customLeftNavigationButton setImage:[UIImage imageNamed:@"SCMyViewNavLeftImage"] forState:UIControlStateNormal];
    [_customLeftNavigationButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:_customLeftNavigationButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)loadRightCustomButton
{
    _customRightNavigationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _customRightNavigationButton.frame = CGRectMake(0, 0, 30, 30);
    [_customRightNavigationButton setImage:[UIImage imageNamed:@"SCMyViewNavRightImage"] forState:UIControlStateNormal];
    [_customRightNavigationButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:_customRightNavigationButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)loadHeaderView
{
    _headerImageView = [UIImageView new];
    [_mainTableView addSubview:_headerImageView];
    _headerImageView.frame = CGRectMake(0, - HEADERVIEWHEIGHT , SCREEN_WIDTH, HEADERVIEWHEIGHT);
        _headerImageView.image = [UIImage imageNamed:@"myinfo_newbg"];
    _headerImageView.backgroundColor = [UIColor greenColor];
    
    headIMG = [UIImageView new];
    [_headerImageView addSubview:headIMG];
    [headIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_mainTableView.mas_centerX).with.offset(0);
        make.bottom.mas_equalTo(_headerImageView.mas_bottom).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(HEADIMAGEWIDTH, HEADIMAGEWIDTH));
    }];
    headIMG.image = [UIImage imageNamed:@"duoladuohead.jpg"];
    headIMG.clipsToBounds = YES;
    headIMG.layer.cornerRadius =  HEADIMAGEWIDTH/2;
    headIMG.layer.borderWidth = 3;
    headIMG.layer.borderColor = [UIColor whiteColor].CGColor;
    
    if (isLogin) {
        headIMG.hidden = NO;
    }else{
        headIMG.hidden = YES;
    }
}

#pragma mark - mainTableView

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    backgroundView.backgroundColor = UIColorFromRGB(MENUPAGENAVIGATIONBG);
    
    return backgroundView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section >= 2) {
        return 0;
    }
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    NSInteger lines = 0;
    
    switch (section) {
        case 0:
            lines = 1;
            break;
        case 1:
            lines = 3;
            break;
            
        case 2:
            lines = 0;
            break;
            
        case 3:
            lines = 3;
            break;
            
        default:
            break;
    }
    
    return lines;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    
    switch (indexPath.section) {
        case 0:
            height = SCAL_GET_HEIGHT(100);
            break;
            
        default:
            return SCAL_GET_HEIGHT(45);
            break;
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        if (isLogin) {
            SCUserInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"userInfoCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setUserInfoCellWithModel:[self testModel] callBackBlock:^(UserInfoClickType clickType) {
                
                switch (clickType) {
                    case kUserInfoClickName:
                        NSLog(@"哆啦沫喵");
                        break;
                        
                    case kUserInfoClickBalance:
                        NSLog(@"账户余额");
                        break;
                        
                    case kUserInfoClickRebate:
                    {
                        NSLog(@"待返利");
                        SCWaitRebateViewController *VC = [[SCWaitRebateViewController alloc] init];
                        [self.navigationController pushViewController:VC animated:YES];
                    }
                        break;
                        
                    default:
                        break;
                }
                
            }];
            
            return cell;
        }else{
            SCUserInfoUnLoginCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SCUserInfoUnLoginCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell callBackWithBlock:^{
                NSLog(@"登录");
            }];
            return cell;
        }
        
        
    }
    else if (indexPath.section >0)
    {
        SCUserNormalCell * cell = [tableView dequeueReusableCellWithIdentifier:@"userInfoNormalCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setCellWithHeadimageNames:_imageNames Titles:_titles indexPath:indexPath isLogin:YES];
        return cell;

    }
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] init];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            
            break;
            
        case 1:
            
            break;
            
        case 2:
        {
            SCCollectionViewController * VC = [[SCCollectionViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
            
        case 3:
            
            break;
            
        case 4:
            
            break;
            
        default:
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset_y = scrollView.contentOffset.y;
    CGFloat offset_x = (offset_y + HEADERVIEWHEIGHT)/2;
    
    if (offset_y < - HEADERVIEWHEIGHT) {
        
        CGRect transFram = _headerImageView.frame;
        transFram.origin.y = offset_y;
        transFram.size.height = - offset_y;
        transFram.origin.x = offset_x;
        transFram.size.width = SCREEN_WIDTH + fabs(offset_x)*2;
        
        _headerImageView.frame = transFram;
        
    }
    
    /*
     
    CGFloat alpha = (offset_y + HEADERVIEWHEIGHT)/(HEADERVIEWHEIGHT - 20);
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor orangeColor] colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
    */
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *catchImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return catchImage;
}

#pragma mark - interface

-(void)leftButtonClick
{
    SCSettingViewController * settingVC = [[SCSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

-(void)rightButtonClick
{

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
