//
//  AFEngine.h
//  Green Kitchen
//
//  Created by pfl on 16/1/5.
//  Copyright © 2016年 pfl. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFEngine : AFHTTPSessionManager

+ (instancetype)shareEngine;

@end
