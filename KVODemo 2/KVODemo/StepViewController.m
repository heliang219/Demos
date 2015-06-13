//
//  StepViewController.m
//  KVODemo
//
//  Created by pangfuli on 15/1/27.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "StepViewController.h"
#import <CoreMotion/CoreMotion.h>



@interface StepViewController ()
@property (nonatomic, strong) CMPedometer *pedometer;
@property (nonatomic, strong) UILabel *label;
@end

@implementation StepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 44)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor redColor];
    label.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:label];
    self.label = label;
    
    self.pedometer = [[CMPedometer alloc]init];
    

    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(countStep) userInfo:nil repeats:YES];
    
}

- (void)countStep
{
//    if ([CMPedometer isStepCountingAvailable]) {
//        [_pedometer startPedometerUpdatesFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:1] withHandler:^(CMPedometerData *pedometerData, NSError *error) {
//            
//            if (error) {
//                NSLog(@"error :%@",error.localizedDescription);
//            }
//            else
//                
//                _label.text = [NSString stringWithFormat:@"%ld",pedometerData.numberOfSteps.integerValue];
//            
//            NSLog(@"%@",_label.text);
//        }];
//    }
    
    if ([CMPedometer isStepCountingAvailable]) {
        
//        NSTimeInterval timeInterVal = [NSDate da];
        
        [_pedometer queryPedometerDataFromDate:[NSDate date] toDate:[NSDate dateWithTimeInterval:1 sinceDate:[NSDate date]] withHandler:^(CMPedometerData *pedometerData, NSError *error) {
            if (error) {
                NSLog(@"error :%@",error.localizedDescription);
            }
            else
                
                _label.text = [NSString stringWithFormat:@"%ld",pedometerData.numberOfSteps.integerValue];
            
            NSLog(@"%@",_label.text);
        }];
    }
    
    
}



@end
