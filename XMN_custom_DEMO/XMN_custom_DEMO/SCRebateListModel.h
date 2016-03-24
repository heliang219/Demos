//
//  SCRebateListModel.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/23.
//  Copyright (c) 2015年 soon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCRebateListModel : NSObject

/**
 *  标题
 */

@property (nonatomic) NSString * title ;

/**
 *  详细
 */

@property (nonatomic) NSString * detail ;

/**
 *  金额
 */

@property (nonatomic) NSString * money ;

/**
 *  时间
 */

@property (nonatomic) NSString * time ;

/**
 *  订单号
 */

@property (nonatomic) NSString * orderNumber ;

/**
 *  状态
 */

@property (nonatomic) NSString * stage ;

@end
