//
//  MyOperation2.m
//  RunLoop&ThreadDemo
//
//  Created by pfl on 15/11/29.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import "MyOperation2.h"

@interface MyOperation2 ()<NSURLConnectionDataDelegate>
@property (nonatomic, readwrite, strong) NSURL *url;
@property (nonatomic, readwrite, strong) NSURLConnection *connection;
@property (nonatomic, readwrite, assign) CFRunLoopRef runloop;
@property (nonatomic, readwrite, copy) void (^response)(id response, NSError *error);
@property (nonatomic, readwrite, copy) void (^progress)(float progress);
@property (nonatomic, readwrite, assign) long long expectLength;
@property (nonatomic, readwrite, assign) float currentLength;
@property (nonatomic, readwrite, strong) NSMutableData *data;
@end

@implementation MyOperation2

- (instancetype)initWithURL:(NSURL *)url response:(void (^)(id response, NSError *error))response progrss:(void (^)(float progress))progress {
    self = [super init];
    if (self) {
        _response = response;
        _progress = progress;
        _url = url;
    }
    return self;
}


- (void)start {
    
    [self willChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isExecuting"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    self.connection = [[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:NO];
    BOOL backgroundThread = [NSOperationQueue mainQueue] != [NSOperationQueue currentQueue];
    NSRunLoop *currentLoop = backgroundThread?[NSRunLoop currentRunLoop]:[NSRunLoop mainRunLoop];
    [self.connection scheduleInRunLoop:currentLoop forMode:NSRunLoopCommonModes];
    [self.connection start];
    
    if (backgroundThread) {
        self.runloop = CFRunLoopGetCurrent();
        CFRunLoopRun();
    }
    
}

- (BOOL)isConcurrent {
    return YES;
}

- (void)finish {
    CFRunLoopStop(self.runloop);
    self.connection = nil;
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];

}

- (void)cancel {
    if (!self.isExecuting) {
        return;
    }
    
    [super cancel];
    [self finish];
}

- (void)dealloc {
    [self.connection cancel];
    self.connection = nil;
}

#pragma mark NSURLConnectionDataDelegate 

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.data = [NSMutableData data];
    self.expectLength = response.expectedContentLength;
    self.currentLength = 0;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.data appendData:data];
    self.currentLength = self.data.length * 1.0  / self.expectLength * 1.0;
    dispatch_async(dispatch_get_main_queue(), ^{
        !self.progress ?: self.progress(self.currentLength);
    });

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    dispatch_async(dispatch_get_main_queue(), ^{
        !self.response ?: self.response(self.data, nil);
    });

    [self finish];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        !self.response ?: self.response(nil, error);
    });

    [self finish];
}





@end









