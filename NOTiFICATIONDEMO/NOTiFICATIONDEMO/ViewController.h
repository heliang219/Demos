//
//  ViewController.h
//  NOTiFICATIONDEMO
//
//  Created by pfl on 15/9/1.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TEST_NOTIFICATION @"hklhdaskjfjsaldkfj"

@interface ViewController : UIViewController

@end

@interface Poster : NSObject

@end


#pragma mark - Observer
@interface Observer : NSObject
{
    Poster  *_poster;
}

@property (nonatomic, assign) NSInteger i;

@end





