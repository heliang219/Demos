//
//  main.m
//  存取方法Demo
//
//  Created by pfl on 15/5/20.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>

enum {
    yes = 1,
    no = 0
} UseItTheRightWay;

@interface MONObjectA : NSObject
{
    NSMutableArray * array;
}

@property (nonatomic, retain) NSArray * array;

@end

@implementation MONObjectA

@synthesize array;

- (id)init
{
    self = [super init];
    if (0 != self) {
        NSLog(@"%s, %@",__PRETTY_FUNCTION__, self);
        if (UseItTheRightWay) {
            array = [NSMutableArray new];
        }
        else {
            self.array = [NSMutableArray array];
        }
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%s, %@",__PRETTY_FUNCTION__, self);
    if (UseItTheRightWay) {
        [array release], array = nil;
    }
    else {
        self.array = nil;
    }
    [super dealloc];
}

@end

@interface MONObjectB : MONObjectA
{
    NSMutableSet * set;
}

@end

@implementation MONObjectB

- (id)init
{
    self = [super init];
    if (0 != self) {
        NSLog(@"%s, %@",__PRETTY_FUNCTION__, self);
        set = [NSMutableSet new];
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%s, %@",__PRETTY_FUNCTION__, self);
    [set release], set = nil;
    [super dealloc];
}

- (void)setArray:(NSArray *)arg
{
    NSLog(@"%s, %@",__PRETTY_FUNCTION__, self);
    NSMutableSet * tmp = arg ? [[NSMutableSet alloc] initWithArray:arg] : nil;
    [super setArray:arg];
    [set release];
    set = tmp;
}

@end

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    [[MONObjectB new] release];
    
    /* the tool must be named 'Props' for this to work as expected, or you can just change 'Props' to the executable's name */
    system("sudo leaks Props");
    
    [pool drain];
    return 0;
}





