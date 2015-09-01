//
//  ViewController.m
//  NOTiFICATIONDEMO
//
//  Created by pfl on 15/9/1.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#pragma mark - Poster


#pragma mark - ViewController

#import "ViewController.h"


@interface ViewController()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __autoreleasing Observer *observer = [[Observer alloc] init];
}

@end


@implementation Observer

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _poster = [[Poster alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:TEST_NOTIFICATION object:nil];
    }
    
    return self;
}

- (void)handleNotification:(NSNotification *)notification
{
    NSLog(@"handle notification begin");
    sleep(1);
    NSLog(@"handle notification end");
    
    self.i = 10;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSLog(@"Observer dealloc");
}

@end


@implementation Poster

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self performSelectorInBackground:@selector(postNotification) withObject:nil];
    }
    
    return self;
}

- (void)postNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TEST_NOTIFICATION object:nil];
}

@end




