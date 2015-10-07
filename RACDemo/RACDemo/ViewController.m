//
//  ViewController.m
//  RACDemo
//
//  Created by pfl on 15/10/4.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveCocoa.h"
#import "RACReturnSignal.h"

#import "ViewModel.h"
#import "Account.h"


@interface ViewController ()
@property (nonatomic, readwrite, strong) ViewModel *viewModel;
@property (nonatomic, readwrite, strong) UITextField *accountTextField;
@property (nonatomic, readwrite, strong) UITextField *passwordTextField;
@property (nonatomic, readwrite, strong) UILabel *statusLabel;
@property (nonatomic, readwrite, strong) UILabel *accountLabel;
@property (nonatomic, readwrite, strong) UILabel *passwordLabel;
@property (nonatomic, readwrite, strong) UIButton *loginBtn;

@end

@implementation ViewController

- (ViewModel*)viewModel {
    if (!_viewModel) {
        _viewModel = [[ViewModel alloc]init];
    }
    return _viewModel;
}

- (void)bindViewModel {
    RAC(self.viewModel.account,account) = self.accountTextField.rac_textSignal;
    RAC(self.viewModel.account,password) = self.passwordTextField.rac_textSignal;
    RAC(self.statusLabel,text) = [[self.accountTextField.rac_textSignal
                                   filter:^BOOL(NSString *value) {
                                       return value.length > 3;
                                   }]
                                  map:^id(NSString *value) {
                                      return [value isEqualToString:@"1234"]?@"pangfuli":value;
                                  }];
    self.loginBtn.rac_command = self.viewModel.loginCommand; // 等价 下面被注释掉的代码段
    
    // 可以多次subscribe
    [self.loginBtn.rac_command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"hahhhhhhhhhhhhh");
    }];
#if 0
    RAC(self.loginBtn, enabled) = self.viewModel.enableLoginSignal;
    @weakify(self)
    [[self.loginBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(id x) {
        NSLog(@"按钮被点击了");
        @strongify(self)
        [self.viewModel.loginCommand execute:nil];
    }];
#endif

//    [[self.accountTextField.rac_textSignal distinctUntilChanged] subscribeNext:^(id x) {
//        NSLog(@"text:%@",x);
//    }];
//
//    [[self.accountTextField.rac_textSignal bind:^RACStreamBindBlock{
//
//        NSLog(@"racstreamBindBlock");
//        return ^RACStream *(id value, BOOL *stop){
//            NSLog(@"Ractream");
//            return [RACReturnSignal return:[NSString stringWithFormat:@"输出:%@",value]];
//        };
//    }]subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
//
//    [[self.accountTextField.rac_textSignal flattenMap:^RACStream *(id value) {
//        return [RACReturnSignal return:[NSString stringWithFormat:@"value:%@",value]];
//    }] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
//
//    [[self.accountTextField.rac_textSignal map:^id(id value) {
//        return [NSString stringWithFormat:@"value:%@",value];
//    }] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    } completed:^{
//        self.accountTextField.text = @"hahha";
//        NSLog(@"complete");
//    }];
}

- (UILabel*)statusLabel {
    if (!_statusLabel) {
        _statusLabel = ({
            UILabel *outLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
            outLabel.textColor = [UIColor brownColor];
            outLabel.textAlignment = NSTextAlignmentCenter;
            outLabel.font = [UIFont boldSystemFontOfSize:20];
            outLabel.backgroundColor = [UIColor greenColor];
            outLabel.center = CGPointMake(self.view.center.x, 100);
            [self.view addSubview:outLabel];
            outLabel;
        });
    }
    return _statusLabel;
}

- (UILabel*)accountLabel {
    if (!_accountLabel) {
        _accountLabel = ({
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 150, 60, 44)];
            nameLabel.text = @"账号:";
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nameLabel.font = [UIFont systemFontOfSize:16];
            [self.view addSubview:nameLabel];
            nameLabel;
        });
    }
    return _accountLabel;
}

- (UILabel*)passwordLabel {
    if (!_passwordLabel) {
        _passwordLabel = ({
            UILabel *passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.accountLabel.frame), CGRectGetMaxY(self.accountLabel.frame)+10, 60, 44)];
            passwordLabel.text = @"密码:";
            passwordLabel.textAlignment = NSTextAlignmentCenter;
            passwordLabel.font = [UIFont systemFontOfSize:16];
            [self.view addSubview:passwordLabel];
            passwordLabel;
        });
    }
    return _passwordLabel;
}


- (UITextField*)accountTextField {
    if (!_accountTextField) {
        _accountTextField = ({
            UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.accountLabel.frame), CGRectGetMinY(self.accountLabel.frame), 200, 44)];
            textField.borderStyle = UITextBorderStyleLine;
            textField;
        });
    }
    
    return _accountTextField;
}

- (UITextField*)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = ({
            UITextField *passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.passwordLabel.frame), CGRectGetMinY(self.passwordLabel.frame), 200, 44)];
            passwordTextField.borderStyle = UITextBorderStyleLine;
            passwordTextField;
        });
    }
    
    return _passwordTextField;
}

- (UIButton*)loginBtn {
    if (!_loginBtn) {
        _loginBtn = ({
            UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
            [loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
            [loginBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
            loginBtn.center = CGPointMake(self.view.center.x, CGRectGetMaxY(self.passwordLabel.frame)+40);
            [loginBtn setBackgroundColor:[UIColor greenColor]];
            loginBtn;
        });
    }
    return _loginBtn;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    RACSignal *signal = [RACSignal createSignal:^RACDisposable* (id<RACSubscriber> subscriber) {
        NSLog(@"%@", subscriber);
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"RACReturnSignal");
        }];
    }];
    
    [[signal take:1] subscribeNext:^(id x) {
        NSLog(@"subscribeNext:%@",x);
        
    }];
    
    [signal subscribeNext:^(id x) {
        
    } completed:^{
        
    }];
    [signal takeLast:1];
    
    RACSubject *subject = [RACSubject subject];
    [[subject takeLast:1]subscribeNext:^(id x) {
        NSLog(@"next2:%@",x);
    } completed:^{
        
    }];
    
    [subject then:^RACSignal *{
        
        NSLog(@"then");
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            return nil;
        }];
    }];

    [subject sendNext:@1];
    [subject sendNext:@2];
    [subject sendNext:@1];
    [subject sendNext:@2];
    [subject sendCompleted];
    
    [self.view addSubview:self.accountTextField];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.loginBtn];
    [self bindViewModel];
    
}


@end
