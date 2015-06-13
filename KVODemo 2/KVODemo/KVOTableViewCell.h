//
//  KVOTableViewCell.h
//  KVODemo
//
//  Created by pfl on 15/1/27.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KVOTableViewCell : UITableViewCell

@property (nonatomic, strong) id value;
@property (nonatomic, copy) NSString *key;

- (void)update;


@end
