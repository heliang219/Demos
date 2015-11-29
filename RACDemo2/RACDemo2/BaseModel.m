//
//  BaseModel.m
//  RACDemo2
//
//  Created by pfl on 15/10/10.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (void)setValuesForKeysWithDic:(NSDictionary *)dic {
    [self setValuesForKeysWithDictionary:dic];
}
// Specify default values for properties

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end
