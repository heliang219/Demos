//
//  MyCoreTextView.h
//  CoreTextDemo
//
//  Created by pfl on 15/1/7.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface MyCoreTextView : UIView

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) CGFloat font;
@property (nonatomic, assign) CGFloat character;
@property (nonatomic, assign) CGFloat paragraph;
@property (nonatomic, assign) CGFloat line;
@property (nonatomic, assign) CTFramesetterRef framesetter;
@end
