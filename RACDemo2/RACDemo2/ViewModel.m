//
//  ViewModel.m
//  RACDemo2
//
//  Created by pfl on 15/10/7.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import "ViewModel.h"
#import <AFNetworking/AFNetworking.h>
#import "Book.h"

@implementation ViewModel
@synthesize models = _models;

- (instancetype)init {
    self = [super init];
    if (!self) {return nil;}
    
    return self;
}

- (RACSignal*)getDatasFromWeb {
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
        NSString *url = @"https://api.douban.com/v2/book/search";
        [manager GET:url parameters:@{@"q":@"基础"} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            [subscriber sendError:error];
        }];
        
        return nil;
    }];
    @weakify(self);
   return [requestSignal map:^id(NSDictionary *value) {
    @strongify(self)
        if ([value isKindOfClass:[NSDictionary class]]) {
            self->_models = [value objectForKey:@"books"];
            NSArray *arr = [[self->_models.rac_sequence map:^id(NSDictionary *value) {
                Book *book = [Book bookWithDictionary:value];
                return book;
            }] array];
            return arr;
        }
        if ([value isKindOfClass:[NSError class]]) {
            NSError *er = (NSError*)value;
            return er.localizedDescription;
        }
        return nil;
    }];
    
}


@end






