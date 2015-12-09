//
//  MyOperation2.h
//  RunLoop&ThreadDemo
//
//  Created by pfl on 15/11/29.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOperation2 : NSOperation

- (void)cancelOperation;

- (instancetype)initWithURL:(NSURL*)url response:(void(^)(id response, NSError*error))response progrss:(void(^)(float progress))progress;

@end
