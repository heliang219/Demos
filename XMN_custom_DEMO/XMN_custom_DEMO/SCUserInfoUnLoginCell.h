//
//  SCUserInfoUnLoginCell.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/18.
//  Copyright (c) 2015年 soon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginBlock)(void);

@interface SCUserInfoUnLoginCell : UITableViewCell

- (void)callBackWithBlock:(LoginBlock)block;

@end
