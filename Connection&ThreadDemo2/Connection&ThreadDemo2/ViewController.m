//
//  ViewController.m
//  Connection&ThreadDemo2
//
//  Created by pfl on 15/11/20.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *post = [NSString stringWithFormat:@"key1=%@&key2=%@&key3=%f&key4=%@", @"", @"", 12.0, @""];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.domain.com/demo/name/file.php?%@", post]]];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"did fail");
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"did receive data");
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"did receive response ");
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"did finish loading");
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
