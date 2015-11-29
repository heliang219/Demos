//
//  ViewModel.m
//  RACDemo
//
//  Created by pfl on 15/10/6.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import "ViewModel.h"
#import "Account.h"

@interface ViewModel ()
@property (nonatomic, readwrite, assign) NSNumber *isLogining;
@end

@implementation ViewModel
@synthesize enableLoginSignal = _enableLoginSignal;
@synthesize loginCommand = _loginCommand;

- (Account*)account {
    if (!_account) {
        _account = [[Account alloc]init];
    }
    return _account;
}

- (RACSignal*)enableLoginSignal {
    if (!_enableLoginSignal) {
        _enableLoginSignal = [RACSignal combineLatest:@[RACObserve(self.account,account),RACObserve(self.account,password),RACObserve(self, isLogining)] reduce:^id(NSString *account, NSString *password, NSNumber *isLogining){
            return @(account.length && password.length && !isLogining.boolValue);
        }];
    }
    return _enableLoginSignal;
}

- (RACCommand*)loginCommand {
    _isLogining = @YES;
    if (!_loginCommand) {
        _loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            NSLog(@"点击了登录按钮");
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSLog(@"正在登录......");
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [subscriber sendNext:@"登录成功"];
                    [subscriber sendCompleted];
                });
                
                return nil;
            }];
        }];
        [_loginCommand.executionSignals.switchToLatest subscribeNext:^(NSString *x) {
            if ([x isEqualToString:@"登录成功"]) {
                NSLog(@"登录成功");
                _isLogining = @NO;
            }
        }];
    }
    return _loginCommand;
}


@end
















