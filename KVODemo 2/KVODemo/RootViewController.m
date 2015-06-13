//
//  RootViewController.m
//  KVODemo
//
//  Created by pfl on 15/1/27.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "RootViewController.h"
#import "KVOTableViewCell.h"
#import "CircleItem.h"
#import "CircleView.h"
#import "FVKViewController.h"
#import "StepViewController.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *MyTableView;
@property (nonatomic, strong) NSDate *now;
@property (nonatomic, strong) UISlider *mySlider;
@property (nonatomic, strong) CircleView *circleView;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemDone) target:self action:@selector(addKVF)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addStep)];
    
    [self updateNow];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateNow) userInfo:nil repeats:YES];
    
    [self addTableView];
    
    [self addCircleView];
    
    [self addSliderView];
    
   
    
}


- (void)addStep
{
    StepViewController *step = [[StepViewController alloc]init];
    [self.navigationController pushViewController:step animated:YES];
}

- (void)addKVF
{
    FVKViewController *fvk = [[FVKViewController alloc]init];
    [self.navigationController pushViewController:fvk animated:YES];
    
    
}


- (void)addSliderView
{
    
    self.mySlider = [[UISlider alloc]initWithFrame:CGRectMake(10, 105, self.view.frame.size.width-20, 34)];
    self.mySlider.layer.cornerRadius = 18;
    self.mySlider.layer.masksToBounds = YES;
    self.mySlider.layer.borderColor = [UIColor whiteColor].CGColor;
    self.mySlider.layer.borderWidth = 1.9f;
    [self.mySlider setThumbImage:[UIImage imageNamed:@"mark3"] forState:(UIControlStateNormal)];
    [self.mySlider setThumbImage:[UIImage imageNamed:@"mark3"] forState:(UIControlStateHighlighted)];
    [self.mySlider setMinimumTrackImage:[UIImage imageNamed:@"sliderBg2"] forState:(UIControlStateNormal)];
    [self.mySlider setMaximumTrackImage:[UIImage imageNamed:@"sliderBg"] forState:(UIControlStateNormal)];
    [self.mySlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:(UIControlEventValueChanged)];
    [self.mySlider addTarget:self action:@selector(sliderValueHadChanged:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.mySlider];
}

- (void)sliderValueChanged:(UISlider*)slider
{
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:5];
    
    for (int i = 0; i < slider.value * 5; i++) {
        
        CircleItem *item = [[CircleItem alloc]init];
        item.itemColor = [self randomColor];
        item.itemNum = @(i + 10);
        [arr addObject:item];
        
    }
    
    self.circleView.layer.itemArr = arr;
}

- (void)sliderValueHadChanged:(UISlider*)slider
{
    self.circleView.layer.radius = 50 + 50*slider.value;
    [self.circleView.layer startAnimation];
}


- (void)addCircleView
{
    self.circleView = [[CircleView alloc]initWithFrame:CGRectMake(0, 205, self.view.frame.size.width, self.view.frame.size.height - 205)];
    [self.view addSubview:self.circleView];
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:5];
    
    for (int i = 0; i < 5; i++) {
        CircleItem *item = [[CircleItem alloc]init];
        item.itemColor = [self randomColor];
        item.itemNum = @(i + 10);
        [arr addObject:item];
    }
    
    self.circleView.layer.itemArr = arr;
   
//    [NSTimer scheduledTimerWithTimeInterval:.65 target:self selector:@selector(startAnima) userInfo:nil repeats:YES];
    [self startAnima];
    
}

- (void)startAnima
{
    
    [self.circleView.layer startAnimation];
}

- (UIColor*)randomColor
{
    UIColor *color = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    return color;
}




- (void)updateNow
{
    self.now = [NSDate date];
}


- (void)addTableView
{
    self.MyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100) style:(UITableViewStylePlain)];
    self.MyTableView.delegate = self;
    self.MyTableView.dataSource  = self;
    self.MyTableView.tableFooterView = [[UIView alloc]init];
    self.MyTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.MyTableView];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"KVOTableViewCell";
    
    KVOTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[KVOTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        
        [cell setKey:@"now"];
        [cell setValue:self];
        [cell update];
    }
    
    return cell;
}


@end
