//
//  ViewController.m
//  DropBoxDemo
//
//  Created by pfl on 15/5/18.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "ViewController.h"
#import <DropboxSDK/DropboxSDK.h>

@interface ViewController ()<DBRestClientDelegate>
@property (nonatomic, strong) UILabel *bbiConnect;
@property (nonatomic, strong) DBRestClient *dbRestClient;
@end

@implementation ViewController
@synthesize bbiConnect,dbRestClient;
- (void)viewDidLoad {
    [super viewDidLoad];
    

    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemAction) target:self action:@selector(performAction)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemRefresh) target:self action:@selector(connectToDropBox)];
    self.navigationItem.rightBarButtonItems = @[item1,item2];;
    
    
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithRed:0.980f green:0.604f blue:0.000f alpha:1.00f]};
    
    bbiConnect = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:bbiConnect];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:dic forState:(UIControlStateNormal)];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:dic forState:(UIControlStateNormal)];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDidLinkNotification:) name:@"didLinkToDropboxAccountNotification" object:nil];
    
    if ([[DBSession sharedSession]isLinked]) {
        bbiConnect.text = @"Disconnect";
        [self initDropboxRestClient];
    }else
    {
        bbiConnect.text = @"Connect";
    }
    
}

- (void)performAction
{
    if (![[DBSession sharedSession]isLinked]) {
        NSLog(@"You're not connected to Dropbox");
        return;
    }
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Upload file" message:@"select file to upload" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *uploadFieldAction = [UIAlertAction actionWithTitle:@"Upload text file" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {}];
    UIAlertAction *uploadImageFileAction = [UIAlertAction actionWithTitle:@"Upload image" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {}];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {}];
    [actionSheet addAction:uploadFieldAction];
    [actionSheet addAction:uploadImageFileAction];
    [actionSheet addAction:cancelAction];
    [self.navigationController presentViewController:actionSheet animated:YES completion:nil];
    
}

- (void)connectToDropBox
{
    if (![[DBSession sharedSession]isLinked]) {
        [[DBSession sharedSession]linkFromController:self];
    }else
    {
        [[DBSession sharedSession]unlinkAll];
        dbRestClient = nil;
    }
}



- (void)initDropboxRestClient
{
    dbRestClient = [[DBRestClient alloc]initWithSession:[DBSession sharedSession]];
    dbRestClient.delegate = self;
    
}

- (void)handleDidLinkNotification:(NSNotification*)notification
{
    [self initDropboxRestClient];
    bbiConnect.text = @"Disconnect";
}

@end














