//
//  AppDelegate.m
//  AccessModel
//
//  Created by pfl on 15/7/14.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"

static  NSString *const appSecret = @"112d520c5b5dcf8117e1270ccb3b5989";
static  NSString *const appID = @"wx619d0bd0ae733bea";

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [WXApi registerApp:appID];
    [self sendMsg];
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

- (void)sendMsg {

    SendAuthReq *req = [[SendAuthReq alloc]init];
    req.scope = @"snsapi_userinfo";
    req.state = @"haha2";
    [WXApi sendReq:req];
    
}




@end

























