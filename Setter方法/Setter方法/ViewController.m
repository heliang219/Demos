//
//  ViewController.m
//  Setter方法
//
//  Created by pfl on 15/12/25.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic, readwrite, copy) NSString *name;
@end

@implementation Person

- (instancetype)init {
    if (self = [super init]) {
        _name = @"庞富利";
    }
    return self;
}

@end



@interface Son : Person

@end

@implementation Son

- (void)setName:(NSString *)name {
    if ([name isEqualToString:@"庞富利"]) {
//        NSAssert(0, @"error");
        NSLog(name);
    }

}





@end




#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Son *son = [[Son alloc]init];
    son.name = @"庞富利";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}

@end
