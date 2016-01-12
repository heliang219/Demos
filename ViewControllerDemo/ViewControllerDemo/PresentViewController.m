//
//  PresentViewController.m
//  ViewControllerDemo
//
//  Created by pfl on 16/1/6.
//  Copyright © 2016年 pfl. All rights reserved.
//

#import "PresentViewController.h"
#import "SubPushViewController.h"
#import "PushViewController.h"


@interface PresentViewController ()

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];

    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    btn.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds)-20);
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 1;
    [btn setBackgroundColor:[UIColor orangeColor]];
    
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    btn2.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds)+20);
    [btn2 setTitle:@"present" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 2;
    [btn2 setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:btn];
    [self.view addSubview:btn2];

    
    
    NSLog(@"====presentedViewControlle:%@",self.presentedViewController);
    
    NSLog(@"====presentingViewController:%@",self.presentingViewController);
    
    NSLog(@"====navigationController:%@",self.navigationController);

    
    NSLog(@"====parentViewController:%@",self.parentViewController);
    
    

}

- (void)btnPressed:(UIButton*)btn {
    if (btn.tag == 2) {
        SubPushViewController *push = [[SubPushViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:push animated:YES];
    }
    else {
        SubPushViewController *present = [[SubPushViewController alloc]init];
        
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:present];
        
        [self presentViewController:nav animated:YES completion:nil];
    }
}


@end
