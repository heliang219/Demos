//
//  Books.m
//  RACDemo2
//
//  Created by pfl on 15/10/9.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import "Book.h"

@implementation Book

//+(void)initialize {
//    [self createDataBase];
//}

+ (NSString*)primaryKey {
    return @"ID";
}

+ (instancetype)bookWithDictionary:(NSDictionary *)dictionary {
    return [[Book alloc]initWithDictionary:dictionary];
}

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
//        [[self class]createDataBase];
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
        self.images = [[Images alloc]init];
        [self.images setValuesForKeysWithDictionary:value];
    }
    else if ([key isEqualToString:@"tags"]) {
        RLMArray<Tags> *arr = [[RLMArray<Tags> alloc]initWithObjectClassName:NSStringFromClass([Tags class])];
        for (NSDictionary *dic in value) {
            Tags *tag = [[Tags alloc]init];
            [tag setValuesForKeysWithDictionary:dic];
            [arr addObject:tag];
        }
        self.tags = arr;
    }
    else if ([key isEqualToString:@"translator"]) {
            if ([value isKindOfClass:[NSArray class]]) {
            NSString *val = @"";
            if ([(NSArray*)value count]) {
                for (NSString *str in value) {
                    val = [val stringByAppendingString:str];
                }
            }
            self.translator = val;
        }
        else
            self.translator = key;
    }
    else if ([key isEqualToString:@"rating"]) {
        self.rating = [[Rating alloc]init];
        [self.rating setValuesForKeysWithDictionary:value];
    }
    else if ([key isEqualToString:@"author"]) {
        if ([value isKindOfClass:[NSArray class]]) {
            NSString *val = @"";
            if ([(NSArray*)value count]) {
                for (NSString *str in value) {
                    val = [val stringByAppendingString:str];
                }
            }
            self.author = val;
        }
        else
            self.author = key;
    }
    else
        [super setValue:value forKey:key];
}

+ (void)createDataBase {
    RLMRealmConfiguration *configuration = [RLMRealmConfiguration defaultConfiguration];
    configuration.path = [[[configuration.path stringByDeletingLastPathComponent]stringByAppendingPathComponent:@"book"] stringByAppendingPathExtension:@"realm"];
    [RLMRealmConfiguration setDefaultConfiguration:configuration];

}


@end

















