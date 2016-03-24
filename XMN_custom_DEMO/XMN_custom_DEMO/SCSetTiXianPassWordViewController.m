//
//  SCSetTiXianPassWordViewController.m
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/24.
//  Copyright © 2015年 soon. All rights reserved.
//

#import "SCSetTiXianPassWordViewController.h"
#import "SCPassWordCharView.h"

@interface SCSetTiXianPassWordViewController ()

@end

@implementation SCSetTiXianPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpCustomNavigationBar];
    
    [self loadPassWordCharView];
    
}

- (void)setUpCustomNavigationBar
{
    self.customNavigationBar.backgroundColor = [UIColor whiteColor];
    
    [self setNavigationBarTitle:@"设置提现密码"];
    
    [self setNavigationBarLeftButtonTitle:@"取消"];
    
    self.view.backgroundColor = UIColorFromRGB(GRAYBACKGROUNDCOLOR);
    
}

-(void)loadPassWordCharView
{
    SCPassWordCharView * view = [[SCPassWordCharView alloc] initWithConfirmButtonClickBlock:^{
       
        NSLog(@"ns");
        
    }];
    [self.view addSubview:view];
    [view makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.customNavigationBar.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 80));
    }];
    
    [view.passWordTextField becomeFirstResponder];
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
