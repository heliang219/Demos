//
//  AppDelegate.m
//  CoreTextDemo
//
//  Created by pfl on 15/1/7.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    RootViewController *root = [[RootViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:root];
    self.window.rootViewController = nav;
    
    
    
    
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*

- (void)drawTextInRect:(CGRect)rect
{
    if (_characterSpacing)
    {
        // Drawing code
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGFloat size = self.font.pointSize;
        
        CGContextSelectFont (context, [self.font.fontName UTF8String], size, kCGEncodingMacRoman);
        CGContextSetCharacterSpacing (context, _characterSpacing);
        CGContextSetTextDrawingMode (context, kCGTextFill);
        
        
        CGFontRef font_ref =CGFontCreateWithFontName((CFStringRef)@"STHeitiTC-Medium");
        CGContextSetFont(context, font_ref);
        
        //        CGGlyph glyphs[self.text.length];
        //        size_t glyphCount;
        //        unichar textChars[self.text.length];
        
        CGGlyph glyphs[[self.text length]];
        
        unichar textChars[[self.text length]];
        [self.text getCharacters:textChars range:NSMakeRange(0, self.text.length)];
        //        mapCharactersToGlyphsInFont(currentTable, textChars, text.length, glyphs, &glyphCount);
        CGAffineTransform textTransform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0);
        CGContextSetTextMatrix(context, textTransform);
        CGContextShowGlyphsAtPoint(context, 20, 30, glyphs, [self.text length]);
        
        
        
        
        
        // Rotate text to not be upside down
        CGAffineTransform xform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0);
        CGContextSetTextMatrix(context, xform);
        const char *cStr = [self.text UTF8String];
        CGContextShowTextAtPoint (context, rect.origin.x, rect.origin.y + size, cStr, strlen(cStr));
    }
    else
    {
        // no character spacing provided so do normal drawing
        [super drawTextInRect:rect];
    }
    
    
    
}

- (void)drawRect:(CGRect)rect
{
    long number = self.text.length-1;
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:@"0000000"];
    
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &number);
    [att addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0, att.length)];
    CFRelease(num);
}
 
 */
@end
