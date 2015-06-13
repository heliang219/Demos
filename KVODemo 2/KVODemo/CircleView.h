//
//  CircleView.h
//  KVODemo
//
//  Created by pfl on 15/1/27.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleLayer.h"

@interface CircleView : UIView

@end
@interface CircleView (ex)

@property (nonatomic, strong, readwrite) CircleLayer *layer;

@end



