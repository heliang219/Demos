//
//  UGView.m
//  UIGraphicsDemo
//
//  Created by pfl on 15/10/23.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import "UGView.h"

@implementation UGView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setNeedsDisplay];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(ctx);
    [[UIColor redColor]set];
    CGContextSaveGState(ctx);
    [[UIColor yellowColor]set];
    UIRectFill(CGRectMake(10, 20, 100, 200));
    
    [[UIColor greenColor]setFill];
    UIRectFill(CGRectMake(10, 230, 100, 200));

    
    [[UIColor blueColor] setFill];
    UIRectFill(CGRectMake(130, 20, 100, 200));

    [[UIColor purpleColor] setFill];
    UIRectFill(CGRectMake(130, 230, 100, 200));

    [[UIColor greenColor]setFill];
    CGContextRestoreGState(ctx);
    
    UIGraphicsPopContext();


}


@end
