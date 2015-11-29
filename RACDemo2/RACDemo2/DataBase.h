//
//  DataBase.h
//  RACDemo2
//
//  Created by pfl on 15/10/31.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface RLMRealm (Extension)
+ (instancetype)shareDataBase;
@end
