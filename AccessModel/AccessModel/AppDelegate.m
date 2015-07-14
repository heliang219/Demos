//
//  AppDelegate.m
//  AccessModel
//
//  Created by pfl on 15/7/14.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "AppDelegate.h"
#import "WeChatSDK_1.5_OnlyIphone/WXApi.h"
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [WXApi registerApp:@"wx619d0bd0ae733bea"];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}


#pragma mark WXApiDelegate

- (void) onReq:(BaseReq *)req
{
    NSLog(@"req:%@",req);
}

- (void)onResp:(BaseResp *)resp
{
    
    NSLog(@"resp:%@",resp);
    
}





@end
