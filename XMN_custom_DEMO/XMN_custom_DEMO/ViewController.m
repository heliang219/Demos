//
//  ViewController.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/16.
//  Copyright (c) 2015年 soon. All rights reserved.
//

#import "ViewController.h"
#import "config_soon.h"
#import "SCSuggestViewController.h"
#import "SCTixianViewController.h"
#import "MyViewController.h"
#import "SCRebateListViewController.h"
#import "SCIdentifyingCodeViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewAccessibilityDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setUpMainTableview];
    
    [self loadDataSource];

}

#pragma mark - MainTableView

- (void)setUpMainTableview
{
    self.mainTableView = [UITableView new];
    self.mainTableView.frame = self.view.frame;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.mainTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    cell.textLabel.text = [_dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            SCSuggestViewController *PushVC = [[SCSuggestViewController alloc] init];
            [self.navigationController pushViewController:PushVC animated:YES];
        }
            break;
            
        case 1:
        {
            MyViewController *PushVC = [[MyViewController alloc] init];
            
            [self.navigationController pushViewController:PushVC animated:YES];
        }
            break;
            
        case 2:
        {
            SCRebateListViewController * pushVC = [[SCRebateListViewController alloc] init];
            
            [self.navigationController pushViewController:pushVC animated:YES];
        }
            break;
            
        case 3:
        {
            SCIdentifyingCodeViewController * pushVC = [[SCIdentifyingCodeViewController alloc] init];
            
            [self.navigationController pushViewController:pushVC animated:YES];
        }
            break;
            
        case 4:
        {
            SCTixianViewController * VC = [[SCTixianViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - LoadDataSource

-(void)loadDataSource
{
    self.dataSource = [NSMutableArray array];

    [_dataSource addObject:@"我要吐槽"];
    
    [_dataSource addObject:@"我的"];
    
    [_dataSource addObject:@"返利记录"];
    
    [_dataSource addObject:@"设置提现密码"];
    
    [_dataSource addObject:@"提现"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
