//
//  UIWebView+SNFoundation.m
//  SNFoundation
//
//  Created by liukun on 14-3-2.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import "UIWebView+SNFoundation.h"
#import "NSArray+SNFoundation.h"

@implementation UIWebView (SNFoundation)

- (NSString *)documentTitle // 获取webview的标题
{
   	return [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)fixViewPort//网页content自适应
{
    //适应客户端页面
    NSString* js =
    @"var meta = document.createElement('meta'); "
    "meta.setAttribute( 'name', 'viewport' ); "
    "meta.setAttribute( 'content', 'width = device-width' ); "
    "document.getElementsByTagName('head')[0].appendChild(meta)";
    
    [self stringByEvaluatingJavaScriptFromString: js];
}

- (void)cleanBackground  //清除默认的背景高光
{
    self.backgroundColor = [UIColor clearColor];
    for (UIView *view in [[[self subviews] safeObjectAtIndex:0] subviews])
    {
        if ([view isKindOfClass:[UIImageView class]]) view.hidden = YES;
    }
}

@end
