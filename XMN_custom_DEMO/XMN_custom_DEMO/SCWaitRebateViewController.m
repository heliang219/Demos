//
//  SCWaitRebateViewController.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/29.
//  Copyright © 2015年 soon. All rights reserved.
//

#define WAITREBATENUMBERFONTSIZE 23
#define DECRIPTIONFONTSIZE 14

#import "SCWaitRebateViewController.h"
#import "SCWaitRebateCell.h"
#import "SCWaitRebateModel.h"
#import "SCEmptyWaitingView.h"
#import "config_soon.h"

@interface SCWaitRebateViewController ()
{
    NSMutableArray * _dataSource;
    
    SCEmptyWaitingView * _emptyWaitingView;
}

@end

@implementation SCWaitRebateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadParameters];              //初始化数据源
    
    [self setUpCustomNavigationBar];    //装载自定义导航栏
    
    [self loadMaintableView];           //装载主列表视图
    
    [self loadEmptyWatingView];
    
    [self createHeaderView];            //创建表头视图
}

- (void)test:(NSInteger)times
{
    
    for (NSInteger i = 0; i < times ; i++) {

        SCWaitRebateModel * model = [[SCWaitRebateModel alloc] init];
        model.title = @"骑士堡-返利支付";
        model.money = @"30";
        model.orderNumber = @"123456789012";
        model.status = @"待返利";
        model.date = @"8月5日 19:30";
        
        [_dataSource addObject:model];
    }
}

#pragma mark - 装载视图

- (void)loadParameters
{
    _dataSource = [NSMutableArray array];
    
    [self test:5];
}

- (void)setUpCustomNavigationBar
{
    [self setNavigationBarTitle:@"待返利"];
    
    [self setNavigationBarLeftButtonTitle:@"返回"];
    
    self.view.backgroundColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR);
}

-(void)loadEmptyWatingView
{
    _emptyWaitingView = [[SCEmptyWaitingView alloc] initWithCallBackBlock:^(BOOL isClick) {
        
        if (isClick) {
            
            NSLog(@"click");
        }
        
    } mainTableView:_mainTableView];
    
    [_emptyWaitingView updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_mainTableView.center);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 200));
    }];
    
    [_emptyWaitingView setImageWithName:nil TitleText:@"暂时没有待返利哦~！" noticeText:@"您可以查看历史返利记录"];
    
    [_emptyWaitingView reloadEmptyViewWithDataSource:_dataSource];
}

-(void)loadMaintableView
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
    [_mainTableView registerClass:[SCWaitRebateCell class] forCellReuseIdentifier:@"SCWaitRebateCell"];
}

-(void)createHeaderView
{
    _headerView = [UIView new];
    _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCAL_GET_HEIGHT(80));
    [self.view addSubview:_headerView];
    _headerView.backgroundColor = [UIColor whiteColor];
    _mainTableView.tableHeaderView = _headerView;
    
    UILabel * line = [UILabel new];
    [_headerView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headerView.mas_top);
        make.centerX.mas_equalTo(_headerView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line.backgroundColor = UIColorFromRGB(SEPARATELINECOLOR);
    
    UILabel * titleLabel = [UILabel new];
    [_headerView addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_headerView.mas_centerY).with.offset(- (_headerView.frame.size.height/4));
        make.centerX.mas_equalTo(_headerView.mas_centerX);
    }];
    titleLabel.text = @"待返利金额";
    titleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    titleLabel.font = [UIFont systemFontOfSize:DESCRIPTIONFONTSIZE];
    
    UILabel * waitRebateMoneyLabel = [UILabel new];
    [_headerView addSubview:waitRebateMoneyLabel];
    [waitRebateMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(titleLabel.mas_centerX).with.offset(SCAL_GET_WIDTH(5));
        make.bottom.mas_equalTo(_headerView.mas_bottom).with.offset(-(SCAL_GET_HEIGHT(13)));
        make.height.mas_equalTo(@(WAITREBATENUMBERFONTSIZE));
    }];
    waitRebateMoneyLabel.text = @"30.00";
    waitRebateMoneyLabel.font = [UIFont fontWithName:NUMBERFONTNAME size:WAITREBATENUMBERFONTSIZE];
    waitRebateMoneyLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    
    UILabel * symbol = [UILabel new];
    [_headerView addSubview:symbol];
    [symbol makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(waitRebateMoneyLabel.mas_bottom);
        make.right.mas_equalTo(waitRebateMoneyLabel.mas_left).with.offset(-0);
    }];
    symbol.text = @"￥";
    symbol.font = [UIFont systemFontOfSize:DESCRIPTIONFONTSIZE];
}

#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SCWaitRebateCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SCWaitRebateCell"];
    
    if (_dataSource.count >= indexPath.row) {
        
        SCWaitRebateModel * model = [_dataSource objectAtIndex:indexPath.row];
        
        [cell setCellWithModel:model];

    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCAL_GET_HEIGHT(100);
}

#pragma mark - 事件

-(void)navigationLiftButonWasClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
