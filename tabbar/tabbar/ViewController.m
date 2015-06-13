//
//  ViewController.m
//  tabbar
//
//  Created by pangfuli on 14-10-9.
//  Copyright (c) 2014年 pflnh. All rights reserved.
//

#import "ViewController.h"
#import "OneController.h"
#import "TwoController.h"
#import "ThreeController.h"
#import "FourController.h"
#import "MainController.h"
#import "TabbarView.h"

#define kHeight 44

@interface ViewController ()<btnClickDelegate>
{
    TabbarView *tabbar;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllers];
    self.view.backgroundColor = [UIColor grayColor];
    tabbar = [[TabbarView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - kHeight, self.view.frame.size.width, kHeight)];
    self.title = [tabbar.subviews[0] currentTitle];
    tabbar.delegate = self;
    tabbar.backgroundColor = [UIColor redColor];
    [self.view addSubview:tabbar];
}






- (void)addChildViewControllers
{
    OneController *one = [[OneController alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:one];
    nav1.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:nav1];
    
    TwoController *two = [[TwoController alloc]init];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:two];
    nav2.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:nav2];
    
    ThreeController *three = [[ThreeController alloc]init];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:three];
    nav3.view.backgroundColor = [UIColor brownColor];
    [self addChildViewController:nav3];
    
    FourController *four = [[FourController alloc]init];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:four];
    nav4.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:nav4];
    
    MainController *five = [[MainController alloc]init];
    UINavigationController *nav5 = [[UINavigationController alloc]initWithRootViewController:five];
    nav5.view.backgroundColor = [UIColor purpleColor];
    [self addChildViewController:nav5];
    
}

#pragma mark btnClickDelegate
- (void)btnClickFrom:(NSInteger)from to:(NSInteger)to
{
  
    UIViewController *old = self.childViewControllers[from];
    [old.view removeFromSuperview];
    
    UIViewController *new = self.childViewControllers[to];
    new.view.frame = self.view.frame;
    UIButton *btn = (UIButton*)tabbar.subviews[to];
    NSString *title = [btn currentTitle];
    self.title = title;
    [self.view insertSubview:new.view belowSubview:tabbar];
    
}


@end
