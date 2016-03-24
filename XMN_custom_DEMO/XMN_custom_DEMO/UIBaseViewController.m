//
//  UIBaseViewController.m
//  XMNiao_Customer
//
//  Created by Esc on 14/10/21.
//  Copyright (c) 2014年 Luo. All rights reserved.
//

#import "UIBaseViewController.h"
#import "sys/utsname.h"
#import <CommonCrypto/CommonDigest.h>
#import "config_soon.h"
#define NavBarFrame self.navigationController.navigationBar.frame

@interface UIBaseViewController ()<UIGestureRecognizerDelegate>


@property (weak, nonatomic) UIView *scrollView;
@property (retain, nonatomic)UIPanGestureRecognizer *panGesture;
@property (retain, nonatomic)UIView *overLay;
@property (assign, nonatomic)BOOL isHidden;
@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, assign) NSInteger countL;
@property (nonatomic, assign) NSInteger countR;

@end

@implementation UIBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
  
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    
    if (self.navigationController.viewControllers[0] == self) {
        [self showTabBar];
    }
    else {
        
        [self hideTabBar];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad{
    [super viewDidLoad];
     self.navigationController.navigationBar.hidden = YES;
    [self setCustomNavigationBar];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (!IOS7) {
        self.hidesBottomBarWhenPushed = YES;
    }
   
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

    _countL = 1;
    _countR = 1;
}

- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [self MD5EncipherWhitMD5Str:[hash lowercaseString]];
}


#pragma mark---为titleView添加手势
- (void) addTitleViewTapGesture
{
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(tapTitleTextClick)];
    _titleLabel.userInteractionEnabled = YES;
    [_titleLabel addGestureRecognizer: tapOne];
    
}

#pragma mark---titleView的点击事件
- (void) tapTitleTextClick
{
    
}


#pragma mark -
#pragma mark Set Self Attribute
- (void)hideNavigationBarLeftButton{
    
    _leftButton.hidden = YES;
}

- (void)showNavigationBarLeftButton{
    _leftButton.hidden = NO;
    
}

//- (void)setNavigationBarIsSilde:(BOOL)isSilde{
//    
//    _isSilde = isSilde;
//    
//}

- (void)setNavigationBarLeftButtonImage:(NSString *)leftButtonImageStr{
    [self addLeftButtonTarget];
    [_leftButton setImage:[UIImage imageNamed:leftButtonImageStr] forState:UIControlStateNormal];
}



- (void) addLeftButtonTarget {
    
    if (_countL != 1) {
        return;
    }
    _countL++;
    [_leftButton  addTarget: self action:@selector(navigationLiftButonWasClick:) forControlEvents: UIControlEventTouchUpInside];
 
}

- (void) addRightButtonTarget {
    if (_countR != 1) {
        return;
    }
    _countR++;
    [_rightButton  addTarget: self action:@selector(navigationRightButtonWasClick:) forControlEvents: UIControlEventTouchUpInside];
}


- (void) setNavigationBarLeftButtonTitle: (NSString *)leftButtonTitleStr
{
    [self addLeftButtonTarget];
    [_leftButton setTitle: leftButtonTitleStr forState: UIControlStateNormal];
    [_leftButton setTitleColor: [UIColor lightGrayColor] forState: UIControlStateHighlighted];
}

- (void)setNavigationBarRightButtonImage:(NSString *)rightButtonImageStr{
    [self addRightButtonTarget];
    [_rightButton setImage:[UIImage imageNamed:rightButtonImageStr] forState:UIControlStateNormal];
}

- (void) setNavigationBarRightButtonTitle: (NSString *)rightButtonTitleStr
{
    [self addRightButtonTarget];
    [_rightButton setTitle: rightButtonTitleStr forState: UIControlStateNormal];
    [_rightButton setTitleColor: UIColorFromRGB(BLACKFONTCOLOR) forState: UIControlStateNormal];
    [_rightButton setTitleColor: UIColorFromRGB(GRAYFONTCOLOR) forState: UIControlStateHighlighted];
}

- (void)setNavigationBarTitle:(NSString *)title{
    [_titleLabel setText:title];
}


#pragma mark -
#pragma mark NavigationBarButton Delegate
- (void)navigationLiftButonWasClick:(UIButton *)sender{
    
    
}

- (void)navigationRightButtonWasClick:(UIButton *)sender{
    
    
}

#pragma mark - 兼容其他手势
//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}

//#pragma mark - 手势调用函数
//-(void)handlePanGesture:(UIPanGestureRecognizer *)panGesture
//{
//    
//    if (!_isSilde) {
//        
//        return;
//    }
//    CGPoint translation = [panGesture translationInView:[self.scrollView superview]];
//    //显示
//    if (translation.y >= 5) {
//        if (self.isHidden) {
//            
//            self.overLay.alpha=0;
//
//            CGRect navBarFrame=NavBarFrame;
////            NSLog(@"%s--navBarFrame--%@",__FUNCTION__,NSStringFromCGRect(navBarFrame));
//            CGRect scrollViewFrame=self.scrollView.frame;
////             NSLog(@"%s--+self.scrollView.frame+--%@",__FUNCTION__,NSStringFromCGRect(self.scrollView.frame));
//            navBarFrame.origin.y = 0;
//            if (IOS7) {
//                
//                navBarFrame.origin.y = 20;
//            }
//            
//            scrollViewFrame.origin.y += 44;
//            scrollViewFrame.size.height -= 44;
//            
//            [UIView animateWithDuration:0.2 animations:^{
//                NavBarFrame = navBarFrame;
//                self.scrollView.frame=scrollViewFrame;
//
//            }];
//            self.isHidden= NO;
//        }
//    }
//    
//    //隐藏
//    if (translation.y <= -20) {
//        if (!self.isHidden) {
//            CGRect frame =NavBarFrame;
//            CGRect scrollViewFrame=self.scrollView.frame;
//            frame.origin.y = -44;
//            scrollViewFrame.origin.y -= 44;
//            scrollViewFrame.size.height += 44;
//            
//            [UIView animateWithDuration:0.2 animations:^{
//                NavBarFrame = frame;
//                self.scrollView.frame=scrollViewFrame;
//
//            } completion:^(BOOL finished) {
//                self.overLay.alpha=1;
//            }];
//            self.isHidden=YES;
//        }
//    }
//}

- (BOOL)isInteger:(NSNumber *)number{
    float numberF = [number floatValue];
    int numberI = [number intValue];
    
    if ((numberF * 100) - (numberI * 100) == 0) {
        
        return YES;
    }
    return NO;
}


//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [self.navigationController.navigationBar bringSubviewToFront:self.overLay];
//}

//提示框
- (void)showMyMessage:(NSString*)aInfo {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:aInfo
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
    
    
    [alertView show];
    
}

- (void)showTabBar
{
    if (self.tabBarController) {
        [[NSNotificationCenter defaultCenter] postNotificationName: SHOW_TAB_BAR object: nil];
    }
   
}
- (void)hideTabBar
{
    if (self.tabBarController) {
        [[NSNotificationCenter defaultCenter] postNotificationName: HIDE_TAB_BAR object: nil];
    }
    
}

// 展示progressView
- (void) showProgressView
{
    [_progressView removeFromSuperview];
    _progressView = [[UIView alloc] initWithFrame: CGRectMake((SCREEN_WIDTH - 100) / 2, (SCREEN_HEIGHT - 100) / 2, 100, 100)];
    _progressView.layer.masksToBounds = YES;
    _progressView.layer.cornerRadius = 10;
    _progressView.backgroundColor = [UIColor blackColor];
    _progressView.alpha = 0.85;
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame: CGRectMake(30, 30, 40, 40)];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    indicator.color = [UIColor whiteColor];
    indicator.tag = 1;
    [_progressView addSubview: indicator];
    [indicator startAnimating];
    self.view.userInteractionEnabled = NO;
    [self.view addSubview: _progressView];
}

// 隐藏progressView
- (void) hideProgressView
{
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)[_progressView viewWithTag: 1];
    
    // 隐藏动画
    [UIView animateWithDuration: 0.15 delay: 0.6 options: UIViewAnimationOptionCurveEaseIn animations:^{
        _progressView.transform = CGAffineTransformScale(_progressView.transform, 0.5, 0.5);
    } completion:^(BOOL finished) {
        [indicator stopAnimating];
        self.view.userInteractionEnabled = YES;
        [_progressView removeFromSuperview];
    }];
}

- (void) closeKeyboardWithSuperView: (UIView*) superView;
{
    for (UIView *subView in superView.subviews)
    {
        // 遵守文本输入协议的类的对象通通放弃第一响应
        if ([subView conformsToProtocol: @protocol(UITextInput)])
        {
            [subView resignFirstResponder];
        }
    }
}




#pragma MD5
- (NSString *)MD5EncipherWhitMD5Str:(NSString *)MD5Str{
    NSMutableString *resultStr = [[NSMutableString alloc] initWithCapacity:1];
    if ([MD5Str isKindOfClass:[NSString class]]) {
        if (MD5Str.length == 32) {
            NSString *lastStr = [MD5Str substringFromIndex:32 - 6];
            
            NSString *firstStr = [MD5Str substringToIndex:6];
            NSString *middleStr = [MD5Str substringWithRange:NSMakeRange(6,20)];
            [resultStr appendString:lastStr];
            [resultStr appendString:middleStr];
            [resultStr appendString:firstStr];
            return resultStr;
        }
    }
    return nil;
}

/**
 * @brief  获取设备型号
 * @param  无
 * @return 当前设备型号 string
 */
- (NSString *)getCurrentDeviceModel
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSArray *modelArray = @[
                            
                            @"i386", @"x86_64",
                            
                            @"iPhone1,1",
                            @"iPhone1,2",
                            @"iPhone2,1",
                            @"iPhone3,1",
                            @"iPhone3,2",
                            @"iPhone3,3",
                            @"iPhone4,1",
                            @"iPhone5,1",
                            @"iPhone5,2",
                            @"iPhone5,3",
                            @"iPhone5,4",
                            @"iPhone6,1",
                            @"iPhone6,2",
                            @"iPhone7,1",
                            @"iPhone7,2",
                            
                            @"iPod1,1",
                            @"iPod2,1",
                            @"iPod3,1",
                            @"iPod4,1",
                            @"iPod5,1",
                            
                            @"iPad1,1",
                            @"iPad2,1",
                            @"iPad2,2",
                            @"iPad2,3",
                            @"iPad2,4",
                            @"iPad3,1",
                            @"iPad3,2",
                            @"iPad3,3",
                            @"iPad3,4",
                            @"iPad3,5",
                            @"iPad3,6",
                            
                            @"iPad2,5",
                            @"iPad2,6",
                            @"iPad2,7",
                            ];
    NSArray *modelNameArray = @[
                                
                                @"iPhone Simulator", @"iPhone Simulator",
                                
                                @"iPhone 2G",
                                @"iPhone 3G",
                                @"iPhone 3GS",
                                @"iPhone 4",
                                @"iPhone 4",
                                @"iPhone 4",
                                @"iPhone 4S",
                                @"iPhone 5",
                                @"iPhone 5",
                                @"iPhone 5c",
                                @"iPhone 5c",
                                @"iphone 5s",
                                @"iphone 5s",
                                @"iphone 6 plus",
                                @"iphone 6",
                                
                                @"iPod Touch 1G",
                                @"iPod Touch 2G",
                                @"iPod Touch 3G",
                                @"iPod Touch 4G",
                                @"iPod Touch 5G",
                                
                                @"iPad",
                                @"iPad 2(WiFi)",
                                @"iPad 2(GSM)",
                                @"iPad 2(CDMA)",
                                @"iPad 2(WiFi + New Chip)",
                                @"iPad 3(WiFi)",
                                @"iPad 3(GSM+CDMA)",
                                @"iPad 3(GSM)",
                                @"iPad 4(WiFi)",
                                @"iPad 4(GSM)",
                                @"iPad 4(GSM+CDMA)",
                                
                                @"iPad mini (WiFi)",
                                @"iPad mini (GSM)",
                                @"ipad mini (GSM+CDMA)"
                                ];
    NSInteger modelIndex = - 1;
    NSString *modelNameString = nil;
    modelIndex = [modelArray indexOfObject:deviceString];
    if (modelIndex >= 0 && modelIndex < [modelNameArray count]) {
        modelNameString = [modelNameArray objectAtIndex:modelIndex];
    }
    if (modelNameString == nil) {
        
        modelNameString = deviceString;
        
    }
    if (modelNameString == nil) {
        modelNameString = @"iOS Devices";
    }
    return modelNameString;
}


// 用于求高度或宽度
- (CGSize) sizeForText: (NSString *) text WithMaxSize: (CGSize) maxSize AndWithFontSize: (CGFloat) fontSize
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0){
        CGRect rect = [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize: fontSize]} context:nil];
        
        return rect.size;
    }else{
        return  [text sizeWithFont:[UIFont systemFontOfSize: fontSize] constrainedToSize: maxSize];
        
    }
}

- (void) setCustomNavigationBar {
    
    if (_customNavigationBar) {
        return;
    }
    
    _customNavigationBar = [[UIView alloc] init];
    [self.view addSubview: _customNavigationBar];
    _customNavigationBar.userInteractionEnabled = YES;
    _customNavigationBar.backgroundColor = UIColorFromRGB(WHITECOLOR);
    [_customNavigationBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        
        if (!IOS7) {
            make.height.equalTo(@44);
        }
        else {
            make.height.equalTo(@64);
        }
        
    }];
    
    _leftButton = [UIButton buttonWithType: UIButtonTypeCustom];
    _rightButton = [UIButton buttonWithType: UIButtonTypeCustom];
    _titleLabel = [[UILabel alloc] init];
    [_customNavigationBar addSubview: _leftButton];
    [_customNavigationBar addSubview: _rightButton];
    [_customNavigationBar addSubview: _titleLabel];
    
    [_leftButton makeConstraints:^(MASConstraintMaker *make) {
        
        if (!IOS7) {
            make.top.equalTo(_customNavigationBar.top);
        }
        else {
            make.top.equalTo(_customNavigationBar.top).offset(20);
        }
        
        make.left.equalTo(_customNavigationBar.left);
        make.bottom.equalTo(_customNavigationBar.bottom);
        make.width.equalTo(@44);
    }];
    
    [_rightButton makeConstraints:^(MASConstraintMaker *make) {
        if (!IOS7) {
            make.top.equalTo(_customNavigationBar.top);
        }
        else {
            make.top.equalTo(_customNavigationBar.top).offset(20);
        }
        make.right.equalTo(_customNavigationBar.right);
        make.bottom.equalTo(_customNavigationBar.bottom);
        make.width.equalTo(@44);
    }];
    
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_customNavigationBar.centerX);
        make.left.greaterThanOrEqualTo(_leftButton.right);
        make.right.lessThanOrEqualTo(_rightButton.left);
        make.centerY.equalTo(_leftButton
                             .centerY);
    }];
    
    _leftButton.tag = CUSTOM_LEFT_TAG;
    _rightButton.tag = CUSTOM_RIGHT_TAG;
    _titleLabel.tag = CUSTOM_TITLE_TAG;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont systemFontOfSize: NAVIGATIONBARTITLEFONTSIZE];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void) hidenCustomNavigationBar {
    _customNavigationBar.hidden = YES;
}

- (void) showCustonNavigationBar {
    _customNavigationBar.hidden = NO;
}

- (void) hideViewAnimationWith: (UIView *) hideView {
    CGFloat height = hideView.frame.size.height;
    
    if (IOS7) {
        [UIView animateWithDuration: 0.1 delay: 0.1 options: UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            hideView.transform = CGAffineTransformTranslate(hideView.transform, 1, - height / 2);
            hideView.transform = CGAffineTransformScale(hideView.transform, 1.0,  1 / height);
            
        } completion:^(BOOL finished) {
            
        }];
    }
    else {
        [hideView removeFromSuperview];
    }
   
}

- (NSString *) stringFromInteger:(NSInteger)integerValue {
    return [NSString stringWithFormat: @"%ld", (long) integerValue];
}
- (NSString *) stringFromFloat:(CGFloat)floatValue {
    return [NSString stringWithFormat: @"%lf", (double) floatValue];
}


@end
