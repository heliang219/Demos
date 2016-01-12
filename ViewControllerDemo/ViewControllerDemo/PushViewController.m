//
//  PushViewController.m
//  ViewControllerDemo
//
//  Created by pfl on 16/1/6.
//  Copyright © 2016年 pfl. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];

    NSLog(@"====presentedViewControlle:%@",self.presentedViewController);
    
    NSLog(@"====presentingViewController:%@",self.presentingViewController);

    NSLog(@"====navigationController:%@",self.navigationController);

    NSLog(@"====parentViewController:%@",self.parentViewController);

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

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnPressed:(UIButton*)btn {
    if (btn.tag == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        
        [self dismissViewControllerAnimated:YES completion:nil];

    }
}


@end







