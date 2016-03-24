//
//  SCRebateListViewController.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/18.
//  Copyright (c) 2015年 soon. All rights reserved.
//

#import "SCRebateListViewController.h"
#import "SCExpansionView.h"
#import "SCEmptyWaitingView.h"
#import "SCRebateListCell.h"
#import "SCRebateListModel.h"
#import "config_soon.h"

@interface SCRebateListViewController ()
{
    SCEmptyWaitingView *waitingView;
}

@end

@implementation SCRebateListViewController
{
    NSMutableArray * _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadParameters];
    
    [self setUpNavigationBar];
    
    [self loadCustomMainTableView];
    
    [self loadWaitingView];
    
    [self loadCustomExpansionView];
}

- (void)loadParameters
{
    _dataSource = [NSMutableArray array];
}

#pragma mark - 装载自定义视图

- (void)setUpNavigationBar
{
    self.view.backgroundColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR);
    
    [self setNavigationBarTitle:@"我的返利记录"];
    
    [self setNavigationBarLeftButtonTitle:@"返回"];
}

- (void)loadCustomMainTableView
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
    [_mainTableView registerClass:[SCRebateListCell class] forCellReuseIdentifier:@"SCRebateListCell"];
}

- (void)loadWaitingView
{
    
    waitingView = [[SCEmptyWaitingView alloc] initWithCallBackBlock:^(BOOL isClick) {
        if (isClick) {
            
            NSLog(@"返回");
        }
    } mainTableView:_mainTableView];
    
    [waitingView updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_mainTableView.center);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 200));
    }];
    
    [waitingView setImageWithName:nil TitleText:@"您暂时没有返利记录哦~" noticeText:@"回首页逛逛"];
    
    [waitingView reloadEmptyViewWithDataSource:_dataSource];
}

- (void)loadCustomExpansionView
{
    _expansionView = [[SCExpansionView alloc] initWithHeight:(250/2) Parameters:nil];

    _mainTableView.tableHeaderView = _expansionView;
    
    [_expansionView changeButtonClickWithCallBackBlock:^(RebateClickType type) {
        
        switch (type) {
            case kRebateClickLeft:
                NSLog(@"全部类型");
                [_dataSource addObject:@"fg"];
                [waitingView reloadEmptyViewWithDataSource:_dataSource];
                break;
                
            case kRebateClickRight:
                NSLog(@"全部时间");
                [_dataSource removeAllObjects];
                [waitingView reloadEmptyViewWithDataSource:_dataSource];
                break;
                
            default:
                break;
        }
    }];
}

#pragma mark - UITableViewDelegate UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCRebateListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SCRebateListCell"];
    
    if (cell == nil) {
        cell = [[SCRebateListCell alloc] init];
    }
    
    [cell setCellWithRebateListModel:[self LoadModel]];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count + 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count + 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

#pragma mark - 响应事件

-(void)navigationLiftButonWasClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TEST 

-(SCRebateListModel *)LoadModel
{
    SCRebateListModel * model = [[SCRebateListModel alloc] init];
    
    model.title = @"支付使用余额";
    model.detail = @"心诗牛排 心悦餐厅";
    model.money = @"-￥12.5";
    model.time = @"09-10 19:00";
    model.orderNumber = @"订单：123456789012";
    model.stage = @"退款成功";
    
    return model;
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
