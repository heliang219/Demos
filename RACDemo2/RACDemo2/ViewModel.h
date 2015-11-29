//
//  ViewModel.h
//  RACDemo2
//
//  Created by pfl on 15/10/7.
//  Copyright © 2015年 pfl. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
@interface ViewModel : NSObject
@property (nonatomic, readonly, strong) NSArray *models;

- (RACSignal*)getDatasFromWeb;

@end
