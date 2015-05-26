//
//  AppDelegate.m
//  CoreDataDemo
//
//  Created by pfl on 15/5/26.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "AppDelegate.h"
#import "ShopIncomeItem.h"
#import "Store.h"
#import "PersistentStack.h"
#import "ViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) Store *store;
@property (nonatomic,strong) PersistentStack *persistentStack;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    UINavigationController *nac = (UINavigationController*)self.window.rootViewController;
    ViewController *rootViewController = (ViewController*)nac.topViewController;
    self.persistentStack = [[PersistentStack alloc]initWithStoreURL:self.storeURL modelURL:self.modelURL];
    self.store = [[Store alloc]init];
    self.store.managedContext = self.persistentStack.managedContext;
    rootViewController.shopIncomeItem = self.store.shopIcomeItem;
    
    
    return YES;
}


- (NSURL*)storeURL
{
    NSURL *documentDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
    return [documentDirectory URLByAppendingPathComponent:@"db.sqlite"];
}

- (NSURL*)modelURL
{
    return [[NSBundle mainBundle] URLForResource:@"ShopIncomeDetail" withExtension:@"momd"];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   
    [self.store.managedContext save:NULL];
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

@end
