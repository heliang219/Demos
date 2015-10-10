//
//  UIImage+PFL.m
//  RACDemo2
//
//  Created by pfl on 15/10/10.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import "UIImageView+PFL.h"

@implementation UIImageView (PFL)
- (void)pfl_image:(NSString *)imageStr placeholderImage:(NSString *)placeholder {
    
    UIImage *image = [UIImage imageNamed:placeholder];
    self.image = image;
    if (imageStr) {
        if ([imageStr hasPrefix:@"http"]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *image1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]]];
                    self.image = image1;
                });
            });
        }
        else {
            image = [UIImage imageNamed:imageStr];
            self.image = image;
        }
    }
    return;
}
@end
