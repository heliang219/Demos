//
//  SCUserInfoCellModel.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/18.
//  Copyright (c) 2015年 soon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCUserInfoCellModel : NSObject

/**
 *  是否登录
 */

@property (nonatomic) BOOL isLogin;

/**
 *  用户名
 */
@property (nonatomic) NSString * userName;

/**
 *  节省金额
 */
@property (nonatomic) NSString * saveMoney;

/**
 *  等价物
 */
@property (nonatomic) NSString * equivalent;

/**
 *  账户余额
 */
@property (nonatomic) NSString * balance;

/**
 *  待返利
 */
@property (nonatomic) NSString * rebate;

@end
