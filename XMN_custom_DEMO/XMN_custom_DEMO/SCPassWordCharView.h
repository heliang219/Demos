//
//  SCPassWordCharView.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/25.
//  Copyright © 2015年 soon. All rights reserved.
//

typedef void(^PSCCallBackBlock)(void);

#import <UIKit/UIKit.h>
#import "config_soon.h"

@interface SCPassWordCharView : UIView <UITextFieldDelegate>

@property (nonatomic) UIImageView *inputView;

@property (nonatomic) UITextField *passWordTextField;

@property (nonatomic) UIButton *confirmBtn;

- (instancetype)initWithConfirmButtonClickBlock:(PSCCallBackBlock)block;

@end
