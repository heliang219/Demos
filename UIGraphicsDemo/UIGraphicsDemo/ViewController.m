//
//  ViewController.m
//  UIGraphicsDemo
//
//  Created by pfl on 15/10/23.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import "ViewController.h"
#import "UGView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UGView *view = [[UGView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
