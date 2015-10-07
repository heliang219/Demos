//
//  ViewModel.h
//  RACDemo
//
//  Created by pfl on 15/10/6.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import "ReactiveCocoa.h"
#import "RACReturnSignal.h"

#import <Foundation/Foundation.h>
@class Account;
@interface ViewModel : NSObject
@property (nonatomic, readwrite, strong) Account *account;
@property (nonatomic, readonly, strong) RACSignal *enableLoginSignal;
@property (nonatomic, readonly, strong) RACCommand *loginCommand;
@end
