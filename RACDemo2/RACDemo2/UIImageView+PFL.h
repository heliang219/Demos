//
//  UIImage+PFL.h
//  RACDemo2
//
//  Created by pfl on 15/10/10.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (PFL)
- (void)pfl_image:(NSString*)imageStr placeholderImage:(NSString*)placeholder;
@end
