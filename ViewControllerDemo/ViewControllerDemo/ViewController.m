//
//  ViewController.m
//  ViewControllerDemo
//
//  Created by pfl on 16/1/6.
//  Copyright © 2016年 pfl. All rights reserved.
//

#import "ViewController.h"
#import "PushViewController.h"
#import "PresentViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (void)btnPressed:(UIButton*)btn {
    if (btn.tag == 1) {
        PushViewController *push = [[PushViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:push animated:YES];
    }
    else {
        PresentViewController *present = [[PresentViewController alloc]init];
        
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:present];
        
        [self presentViewController:nav animated:YES completion:nil];
 
        NSLog(@"====presentedViewControlle1:%@",nav);
        NSLog(@"====presentedViewControlle2:%@",self.presentedViewController);
        NSLog(@"====presentedViewControlle2-1:%@",present.presentingViewController);

        NSLog(@"====presentingViewController3:%@",nav.presentingViewController);
        NSLog(@"====presentingViewController4:%@",self.navigationController);


    }
}


@end






















