//
//  DataBase.m
//  RACDemo2
//
//  Created by pfl on 15/10/31.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import "DataBase.h"

@implementation RLMRealm (Extension)

+ (instancetype)shareDataBase {
    static RLMRealm *currentDataBase = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        RLMRealmConfiguration *configuration = [RLMRealmConfiguration defaultConfiguration];
        configuration.path = [[[configuration.path stringByDeletingLastPathComponent]stringByAppendingPathComponent:@"book"] stringByAppendingPathExtension:@"realm"];
        [RLMRealmConfiguration setDefaultConfiguration:configuration];
        currentDataBase = [RLMRealm defaultRealm];
    });
    return currentDataBase;
}


@end
