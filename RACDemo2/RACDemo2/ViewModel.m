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
#import "DataBase.h"

@implementation ViewModel
@synthesize models = _models;

- (instancetype)init {
    self = [super init];
    if (!self) {return nil;}
    
    return self;
}

- (RACSignal*)getDatasFromWeb {
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           
            NSString *url = @"https://api.douban.com/v2/book/search";
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
            NSURLSessionDataTask *task = [manager GET:url parameters:@{@"q":@"基础"/*高级*/} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                
                // 请求失败,获取数据库中的数据
                RLMRealm *realm = [RLMRealm shareDataBase];
                self.models = (NSArray*)[Book allObjectsInRealm:realm];
                NSLog(@"models:%@",self.models);
                
                [subscriber sendError:error];
     
            }];
            
            return [RACDisposable disposableWithBlock:^{
                [task cancel];
            }];
    }];
    
    @weakify(self);
   return [requestSignal map:^id(NSDictionary *value) {
    @strongify(self)
        if ([value isKindOfClass:[NSDictionary class]]) {
            NSArray *books = [value objectForKey:@"books"];
            NSArray *arr = [[books.rac_sequence map:^id(NSDictionary *value) {
                Book *book = [Book bookWithDictionary:value];
                return book;
            }] array];
            self.models = arr;
            // 获取数据库
            RLMRealm *realm = [RLMRealm shareDataBase];
            // 开始写入数据库事务
            [realm beginWriteTransaction];
            NSLog(@"startTime1:%f",CFAbsoluteTimeGetCurrent());
            // 删除所有数据
            [realm deleteAllObjects];
            NSLog(@"endTime1:%f",CFAbsoluteTimeGetCurrent());
            for (Book *book in arr) {
                // 写入数据库
                [Book createInDefaultRealmWithValue:book];
            }
            // 提交写入事务
            [realm commitWriteTransaction];
            return arr;
        }
        if ([value isKindOfClass:[NSError class]]) {
            NSError *er = (NSError*)value;
            return er.localizedDescription;
        }
        return nil;
    }];
    
}

- (void)setModels:(NSArray *)models {
    _models = models;
}


@end






