//
//  ViewController.m
//  UIViewDemo
//
//  Created by pfl on 15/12/9.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"self:%@",self);
    id nextResponder = [self.view nextResponder];
    NSLog(@"nextResponder:%@",nextResponder);
    
    if (self == nextResponder) {
        NSLog(@"self == nextResponder");
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
