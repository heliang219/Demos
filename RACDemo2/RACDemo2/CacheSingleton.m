//
//  CacheSingleton.m
//  RACDemo2
//
//  Created by pfl on 15/10/10.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import "CacheSingleton.h"

static CacheSingleton *defaultCache = nil;
@implementation CacheSingleton
+ (instancetype)defaultCache {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultCache = [[self alloc]init];
        defaultCache.countLimit = 50;
    });
    return defaultCache;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultCache = [super allocWithZone:zone];
    });
    return defaultCache;
}

- (id)copyWithZone:(NSZone *)zone {
    return defaultCache;
}



@end
