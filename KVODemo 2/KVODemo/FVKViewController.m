//
//  FVKViewController.m
//  KVODemo
//
//  Created by pfl on 15/1/27.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "FVKViewController.h"
#import <CoreMotion/CoreMotion.h>



@interface FVKViewController ()

@property (nonatomic, strong) CMMotionActivityManager *motionActivityManager;

@end

@implementation FVKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.motionActivityManager = [[CMMotionActivityManager alloc]init];
    BOOL isAvailable =  [CMMotionActivityManager isActivityAvailable];
    if (isAvailable)
    {
        
        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
        
        [self.motionActivityManager startActivityUpdatesToQueue:queue withHandler:^(CMMotionActivity *activity) {
            
            if (activity.walking) {
                NSLog(@"支持步行");
            }
            
        }];
        
    }
   
    
    

}



@end
