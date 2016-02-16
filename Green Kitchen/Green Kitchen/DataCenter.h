//
//  DataCenter.h
//  Green Kitchen
//
//  Created by pfl on 16/1/13.
//  Copyright © 2016年 pfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoryModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface DataCenter : NSObject
@property (nonatomic, readwrite, assign) NSInteger pageIndex;
@property (nonatomic, readwrite, assign) BOOL isRefresh;
@property (nonatomic, readonly, strong) NSMutableArray *dataArr;
@property (nonatomic, readwrite, strong) RACSignal *dataSignal;

@end
