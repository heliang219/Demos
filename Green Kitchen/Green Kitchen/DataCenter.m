//
//  DataCenter.m
//  Green Kitchen
//
//  Created by pfl on 16/1/13.
//  Copyright © 2016年 pfl. All rights reserved.
//

#import "DataCenter.h"

@interface DataCenter ()
@property (nonatomic, readwrite, strong) NSMutableArray *dataArr;
@property (nonatomic, readwrite, strong) NSURLSessionDataTask *dataTask;
@end

@implementation DataCenter


- (NSArray*)URLArr
{
    return @[@"http://www.wanzhoumo.com/wanzhoumo?UUID=97B42FCB-7D7A-4D41-A80B-24644CBEE429&app_key=800000002&app_v_code=12&app_v_name=2.2.1&format=json&is_near=1&is_valid=1&lat=22.562433&lon=113.904398&method=activity.List&os=iphone&pagesize=30&r=wanzhoumo&sign=0f97295d4c92c73217ff8341fb11b20c&sort=default&timestamp=1409632143&top_session=n8i2d0ie4g77qfb8dmoot08ct7&v=2.0",@"http://www.wanzhoumo.com/wanzhoumo?UUID=97B42FCB-7D7A-4D41-A80B-24644CBEE429&app_key=800000002&app_v_code=12&app_v_name=2.2.1&format=json&is_near=1&is_valid=1&lat=22.535044&lon=113.944849&method=activity.List&offset=30&os=iphone&pagesize=30&r=wanzhoumo&sign=7cf20949bd9c5990598836ba6ef073da&sort=default&timestamp=1410335762&v=2.0",@"http://www.wanzhoumo.com/wanzhoumo?UUID=97B42FCB-7D7A-4D41-A80B-24644CBEE429&app_key=800000002&app_v_code=12&app_v_name=2.2.1&format=json&is_near=1&is_valid=1&lat=22.535044&lon=113.944849&method=activity.List&offset=60&os=iphone&pagesize=30&r=wanzhoumo&sign=de3ff25211b760930bb81433e527b5df&sort=default&timestamp=1410335834&v=2.0",@"http://www.wanzhoumo.com/wanzhoumo?UUID=97B42FCB-7D7A-4D41-A80B-24644CBEE429&app_key=800000002&app_v_code=12&app_v_name=2.2.1&format=json&is_near=1&is_valid=1&lat=22.535044&lon=113.944849&method=activity.List&offset=90&os=iphone&pagesize=30&r=wanzhoumo&sign=8f2e34692044cb173e023e6d5ef6e9f5&sort=default&timestamp=1410335871&v=2.0",@"http://www.wanzhoumo.com/wanzhoumo?UUID=97B42FCB-7D7A-4D41-A80B-24644CBEE429&app_key=800000002&app_v_code=12&app_v_name=2.2.1&format=json&is_near=1&is_valid=1&lat=22.535044&lon=113.944849&method=activity.List&offset=120&os=iphone&pagesize=30&r=wanzhoumo&sign=46db75331082d7beb1c11efac327df23&sort=default&timestamp=1410335913&v=2.0",@"http://www.wanzhoumo.com/wanzhoumo?UUID=97B42FCB-7D7A-4D41-A80B-24644CBEE429&app_key=800000002&app_v_code=12&app_v_name=2.2.1&format=json&is_near=1&is_valid=1&lat=22.535044&lon=113.944849&method=activity.List&offset=150&os=iphone&pagesize=30&r=wanzhoumo&sign=f1f7bb7819db7b4fd36464ef41b9d477&sort=default&timestamp=1410335945&v=2.0"];
}

- (NSMutableArray *)dataArr {
    if (_dataArr) {
        return _dataArr;
    }
    _dataArr = [NSMutableArray arrayWithCapacity:30];
    return _dataArr;
    
}

- (RACSignal *)dataSignal {
    if (!_dataSignal) {
        _dataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            
            if (self.pageIndex >= self.URLArr.count) {
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                return [RACDisposable disposableWithBlock:^{}];
            }
            
            AFEngine *angine = [AFEngine shareEngine];
            self.dataTask = [angine POST:self.URLArr[self.pageIndex] parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                NSLog(@"responseObject:%@",responseObject);
                NSArray *results = [responseObject objectForKey:@"result"][@"list"];
                if (results.count == 0 || !results) {
                    [subscriber sendNext:nil];
                    [subscriber sendCompleted];
                    return;
                }
                
                [self.dataArr removeAllObjects];
                for (NSDictionary *dic in results) {
                    if ([dic isKindOfClass:[NSDictionary class]]) {
                        StoryModel *model = [[StoryModel alloc]init];
                        model.title = dic[@"title"];
                        model.position = dic[@"poi_name_app"];
                        model.address  = dic[@"address"];
                        model.cost = dic[@"cost"];
                        model.tel = dic[@"tel"];
                        model.showTime = dic[@"time_txt"];
                        [model.picShowArray addObjectsFromArray:dic[@"pic_show"]];
                        model.introdution = dic[@"intro"];
                        model.introdution_show = dic[@"intro_show"];
                        model.genre_main_show = dic[@"genre_main_show"];
                        model.genre_name = dic[@"genre_name"];
                        model.distance_show = dic[@"distance_show"];
                        model.sID = dic[@"id"];
                        model.latitude = dic[@"lat"];
                        model.longitude = dic[@"lon"];
                        model.follow_num = dic[@"statis.follow_num"];
                        model.title_vice = dic[@"title_vice"];
                        model.isFollow = dic[@"is_follow"];
                        model.face = dic[@"pic_show"][0];
                        [self.dataArr addObject:model];
                    }
                }        
              self.pageIndex++;
              [subscriber sendNext:_dataArr.copy];
              [subscriber sendCompleted];
              
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self setIsRefresh:NO];
                [subscriber sendNext:error];
                [subscriber sendCompleted];
            }];

            return [RACDisposable disposableWithBlock:^{
                [_dataTask cancel];
            }];
        }];
    }
    
    
    return _dataSignal;
}







@end
