//
//  SCMessageSettingViewController.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/28.
//  Copyright © 2015年 soon. All rights reserved.
//

#import "SCMessageSettingViewController.h"
#import "SCMessageSettingCell.h"

@interface SCMessageSettingViewController ()
{
    UITableView * _mainTabelView;
}

@end

@implementation SCMessageSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpCustomNavigationBar];
    
    [self loadMainTableView];
}

-(void)loadMainTableView
{
    _mainTabelView = [UITableView new];
    [self.view addSubview:_mainTabelView];
    [_mainTabelView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavigationBar.mas_bottom);
        make.left.right.and.bottom.mas_equalTo(self.view);
    }];
    _mainTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTabelView.backgroundColor = [UIColor greenColor];
    _mainTabelView.delegate = self;
    _mainTabelView.dataSource = self;
    [_mainTabelView registerClass:[SCMessageSettingCell class] forCellReuseIdentifier:@"SCMessageSettingCell"];
}

-(void)setUpCustomNavigationBar
{
    [self setNavigationBarTitle:@"消息设置提醒"];
    
    [self setNavigationBarLeftButtonTitle:@"返回"];
    
    [self.view setBackgroundColor:UIColorFromRGB(GRAYBACKGROUNDCOLOR)];

}

#pragma mark - tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCAL_GET_HEIGHT(50);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCMessageSettingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SCMessageSettingCell"];
    
    [cell setCellWithTitle:@"活动推送" DetailText:@"促销活动和精选内容" imageName:nil NoticeBlock:^{
        
        NSLog(@"%ld",indexPath.row);
        
    }];
    
    return cell;
}

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
