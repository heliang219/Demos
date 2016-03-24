//
//  SCCollectionModel.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/10/10.
//  Copyright © 2015年 soon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCCollectionModel : NSObject

/**
 *  预览图
 */
@property (nonatomic) NSString * HeadImageName;

/**
 *  餐厅名字
 */
@property (nonatomic) NSString * title;

/**
 *  价格
 */
@property (nonatomic) NSString * money;

/**
 *  位置
 */
@property (nonatomic) NSString * position;

/**
 *  订单量
 */
@property (nonatomic) NSString * orders;

/**
 *  节省规则
 */
@property (nonatomic) NSString * bargainRule;

/**
 *  新用户规则
 */
@property (nonatomic) NSString * NewUserRule;


@end
