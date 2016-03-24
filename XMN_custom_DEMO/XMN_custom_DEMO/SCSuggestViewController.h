//
//  SCSuggestViewController.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/16.
//  Copyright (c) 2015年 soon. All rights reserved.
//

#import "UIBaseViewController.h"

typedef NS_ENUM(NSInteger, suggestType)
{
    kProductManager = 0,
    kProgrammerMonkey,
    kproductDisigner,
    kCEO
};

@interface SCSuggestViewController : UIBaseViewController <UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic) UIImageView * suggestTargetView;

@property (nonatomic) UIImageView * mainSuggetView;

@property (nonatomic) UITextView * contextView;

@property (nonatomic) UITextField * telePhoneNumberTextField;

@end
