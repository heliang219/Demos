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
        [array release];
        array = nil;
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


int getSum(int arr[],int n);

void test()
{
    int arr[5] = {1,2,43,4,5};// arr存放的是整个数组的起始地址,即第一个元素的地址
    int (*p)[5];
    p = &arr;// p 指向的是存放数组变量的地址
    printf("========p[1]=====%d",(*p)[1]);
    printf("\n");
    
    int *px[5] = {arr,arr+1,arr+2,arr+3,arr+4};
//    px[0] = arr;
//    px[2] = &arr[2];
//    for (int i = 0; i < sizeof(arr)/sizeof(arr[1]); i++) {
//        px[i] = &arr[i];
//    }
    NSLog(@"========p[2]=====%d",*px[3]);
    
    if (&arr[0] == arr) {
        NSLog(@"=================");
    }
    
}

void test2();
void test3(int (*)(int a, int b));
int sum(int a1, int b1);
int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    [[MONObjectB new] release];
    void test4();
    /* the tool must be named 'Props' for this to work as expected, or you can just change 'Props' to the executable's name */
    system("sudo leaks Props");
    
    [pool drain];
    
    
    @autoreleasepool {
        
//        test();
//        test2();
//        test3(sum);
        test4();
    }
    
    
    return 0;
}


void test4()
{
    NSString *aa = @"hh";
    
    NSString *aa1 = aa;
    NSString *aa2 = [@"hh" mutableCopy];

    if (aa1 == aa2) {
        NSLog(@"a1 = a2");
    }
    else {
        NSLog(@"a1 != a2");
    }
    
    
    if ([aa1 isEqual:aa2]) {
       
        NSLog(@"a1 = a2");
    }
    else {
        NSLog(@"a1 != a2");
    }
    if ([aa1 isEqualTo:aa2]) {
        
        NSLog(@"a1 = a2");
    }
    else {
        NSLog(@"a1 != a2");
    }
    
    
    
}


void test3(int (*sum)(int, int))
{
    int asum = sum(12,12);
    NSLog(@"sum = %d",asum);
}

int sum(int a1, int b1)
{
    return a1 + b1;
}

void test2()
{
    int a = 2;
    __unused int *p = &a;
    
    int arr[] = {1,9,3,4,5,6,7,8,9,0};
    int *pt = arr;
    //        NSLog(@"a = %p",&a);
    //        NSLog(@"p = %p",p);
    //        NSLog(@"p+1 = %p",(++p));
    
    NSLog(@"arr = %p",arr);
    NSLog(@"pt = %p",pt);
    NSLog(@"pt+1 = %p",(pt+1));
    NSLog(@"*(pt+1) = %d",*(pt+2));
    //        NSLog(@"*(pt++) = %d",*(pt++));
    NSLog(@"*(pt++) = %d",*pt++);
    NSLog(@"*(pt++) = %d",(*pt));
    NSLog(@"*(pt++) = %d",arr[0]);
    printf("sum = %d",getSum(arr,sizeof(arr)/sizeof(arr[1])));
    printf("\n");
    NSLog(@"sizeof(arr) = %lu",sizeof(arr));
}


int getSum(int *arr,int n)
{
    int i = 0;
    __unused int *p = arr;
    int sum = 0;
    while (i<n) {
        sum += *(arr++);
        i++;
    }
    printf("arr = %lu",sizeof(arr));
    printf("\n");
    printf("arr = %lu",sizeof(arr[0]));
    printf("\n");
    return sum;
}


























