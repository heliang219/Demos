//
//  Book.m
//  RACDemo2
//
//  Created by pfl on 15/10/7.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import "Book.h"

@implementation Book
+ (instancetype)bookWithDictionary:(NSDictionary *)dictionary {
    return [[Book alloc]initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"images"]) {
        self.images = @"images";
    }
    else
        [super setValue:value forKey:key];
}



@end
