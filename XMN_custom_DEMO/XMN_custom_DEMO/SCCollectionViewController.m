//
//  SCCollectionViewController.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/10/9.
//  Copyright © 2015年 soon. All rights reserved.
//

#define CLNORMALFONTSIZE 15

#import "SCCollectionViewController.h"
#import "SCCollectionCell.h"
#import "SCCollectionModel.h"
#import "config_soon.h"

@interface SCCollectionViewController ()

@end

@implementation SCCollectionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUpCustomNavigaionBar];
    
    [self loadMainTableView];
    
}

#pragma mark - 

- (void)test
{
    
    for (NSInteger i = 0; i < 5; i++) {
        SCCollectionModel * model = [[SCCollectionModel alloc] init];
        model.title = @"超级辣条";
        model.money = @"128";
        model.position = @"石牌";
        model.orders = @"1920";
        model.bargainRule = @"全单9折、全单返1.2全单9折、全单返1.2全单9折、全单返1.2全单9折、全单返1.2";
        model.NewUserRule = @"新用户白吃新用户sdfadfasdfasdasdfasdfasdff saf白吃新用户白吃";
        
        [_dataSource addObject:model];
    }

}

#pragma mark - 装载自定义视图

- (void)setUpCustomNavigaionBar
{
    [self setNavigationBarTitle:@"我的收藏"];
    
    [self setNavigationBarLeftButtonTitle:@"返回"];

}

- (void)loadMainTableView
{
    _mainTableView = [UITableView new];
    [self.view addSubview:_mainTableView];
    [_mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.customNavigationBar.mas_bottom).with.offset(0);
    }];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableView.backgroundColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR);
    [_mainTableView registerClass:[SCCollectionCell class] forCellReuseIdentifier:@"SCCollectionCell"];
    
    _dataSource = [NSMutableArray array];
    
    [self test];
}

#pragma mark - UITableViewDataSource UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCCollectionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SCCollectionCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_dataSource.count > 0) {
        
        SCCollectionModel * model = [_dataSource objectAtIndex:indexPath.row];
        [cell setCellWithCollectionModel:model];

    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCCollectionModel * model = [_dataSource objectAtIndex:indexPath.row];
    
    CGFloat height = (ISIPHONE4S?85:SCAL_GET_HEIGHT(85)) + [self sizeForText:model.bargainRule WithMaxSize:CGSizeMake(SCAL_GET_WIDTH(200), 1000) AndWithFontSize:CLNORMALFONTSIZE].height + [self sizeForText:model.NewUserRule WithMaxSize:CGSizeMake(SCAL_GET_WIDTH(200), 1000) AndWithFontSize:CLNORMALFONTSIZE].height;
    
    return height;
}

#pragma mark -

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
