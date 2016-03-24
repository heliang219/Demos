//
//  SCIdentifyingCodeViewController.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/10/13.
//  Copyright © 2015年 soon. All rights reserved.
//

#import "UIBaseViewController.h"

typedef NS_ENUM(NSInteger,confirmEnableType) {

    kConfirmEnabel = 1,
    kConfirmUNEnabel,
};

@interface SCIdentifyingCodeViewController : UIBaseViewController<UITextFieldDelegate>

@property(nonatomic) UILabel * telephoneNumberLabel;

@property(nonatomic) UIButton * getIdentifyCodeButton;

@property(nonatomic) UITextField * identifyTextField;

@property(nonatomic) UIButton * confirmButton;

@end
