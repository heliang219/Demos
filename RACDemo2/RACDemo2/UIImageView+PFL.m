//
//  UIImage+PFL.m
//  RACDemo2
//
//  Created by pfl on 15/10/10.
//  Copyright © 2015年 pfl. All rights reserved.
//

#define imagePath  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

#import "UIImageView+PFL.h"
#import "CacheSingleton.h"

@implementation UIImageView (PFL)
- (void)pfl_image:(NSString *)imageStr placeholderImage:(NSString *)placeholder {
    
    UIImage *image = [UIImage imageNamed:placeholder];
    self.image = image;
        if (imageStr) {
           __block UIImage *cacheImage = [[CacheSingleton defaultCache]objectForKey:imageStr];
            if (cacheImage) {
                self.image = cacheImage;
            }
            else if ([self pfl_getImageForKey:imageStr]){
                NSLog(@"image:%@",[self pfl_getImageForKey:imageStr]);
                self.image = [self pfl_getImageForKey:imageStr];
            }
            else {
                if ([imageStr hasPrefix:@"http"]) {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            cacheImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]]];
                            self.image = cacheImage;
                            [[CacheSingleton defaultCache]setObject:cacheImage forKey:imageStr];
                            [self saveImage:cacheImage toFilePathForKey:imageStr];
                        });
                    });
                }
                else {
                    image = [UIImage imageNamed:imageStr];
                    self.image = image;
                }
            }
    }
    return;
}


- (void)saveImage:(UIImage*)image toFilePathForKey:(NSString*)key {
    NSString *path = imagePath;
    path = [path stringByAppendingPathComponent:@"images"];
    NSString *lastComponent = [key componentsSeparatedByString:@"/"].lastObject;
    if (!lastComponent) {
        return;
    }
    path = [path stringByAppendingPathComponent:lastComponent];
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [imageData writeToFile:path atomically:YES];
    });
}


- (UIImage*)pfl_getImageForKey:(NSString*)key {
    
    NSString *path = imagePath;
    path = [path stringByAppendingPathComponent:@"images"];
    NSString *lastComponent = [key componentsSeparatedByString:@"/"].lastObject;
    if (!lastComponent) {
        return nil;
    }
    path = [path stringByAppendingPathComponent:lastComponent];
    return  [UIImage imageWithData:[NSData dataWithContentsOfFile:path]];
}

@end









