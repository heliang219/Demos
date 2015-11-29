//
//  Account.h
//  RACDemo
//
//  Created by pfl on 15/10/6.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject
@property (nonatomic, readwrite, copy) NSString *account;
@property (nonatomic, readwrite, copy) NSString *password;
@end
