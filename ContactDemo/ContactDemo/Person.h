//
//  Person.h
//  ContactDemo
//
//  Created by pfl on 15/12/15.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic, readwrite, strong) NSString *personname;
@property (nonatomic, readwrite, copy) NSString *telephone;
@property (nonatomic, readwrite, copy) NSString *email;
@end
