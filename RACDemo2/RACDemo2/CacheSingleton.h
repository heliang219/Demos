//
//  CacheSingleton.h
//  RACDemo2
//
//  Created by pfl on 15/10/10.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheSingleton : NSCache<NSCopying>
+ (instancetype)defaultCache;
@end
