//
//  AFEngine.m
//  Green Kitchen
//
//  Created by pfl on 16/1/5.
//  Copyright © 2016年 pfl. All rights reserved.
//

#import "AFEngine.h"

@implementation AFEngine

+ (instancetype)shareEngine {
    static AFEngine *shareEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareEngine = [AFEngine manager];
        shareEngine.requestSerializer.timeoutInterval = 30;
        shareEngine.requestSerializer = [AFJSONRequestSerializer serializer];
        shareEngine.responseSerializer = [AFJSONResponseSerializer serializer];
        shareEngine.responseSerializer.acceptableContentTypes = [shareEngine.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"text/html", nil]];
    });
    return shareEngine;
}



@end
