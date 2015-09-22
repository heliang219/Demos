//
//  ViewController.m
//  JSLoveOC
//
//  Created by pfl on 15/9/22.
//  Copyright © 2015年 pfl. All rights reserved.
//

#import "ViewController.h"

#import "NSData+Base64.h"

@interface ViewController ()<UIWebViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    NSString *callback;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"camera" ofType:@"html"];
    NSString *fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.view addSubview:self.webView];
    [self.webView loadHTMLString:fileContent baseURL:nil];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [[request URL] absoluteString];
    NSString *protocol = @"js-call://";
    if ([requestString hasPrefix:protocol]) {
        NSString *requestContent = [requestString substringFromIndex:[protocol length]];
        NSArray *vals = [requestContent componentsSeparatedByString:@"/"];
        if ([[vals objectAtIndex:0] isEqualToString:@"camera"]) {
            callback = [vals objectAtIndex:1];
            [self doAction:UIImagePickerControllerSourceTypeCamera];
        } else if([[vals objectAtIndex:0] isEqualToString:@"photolibrary"]) {
            callback = [vals objectAtIndex:1];
            [self doAction:UIImagePickerControllerSourceTypePhotoLibrary];
        } else if([[vals objectAtIndex:0] isEqualToString:@"album"]) {
            callback = [vals objectAtIndex:1];
            [self doAction:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        }
        else {
            [webView stringByEvaluatingJavaScriptFromString:@"alert('未定义/lwme.cnblogs.com');"];
        }
        return NO;
    }
    return YES;
}

- (void)doAction:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        imagePicker.sourceType = sourceType;
    } else {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"照片获取失败" message:@"没有可用的照片来源" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return;
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        [popover presentPopoverFromRect:CGRectMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 3, 10, 10) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
        UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"正在处理图片..." message:@"\n\n"
                                                    delegate:self
                                           cancelButtonTitle:nil
                                           otherButtonTitles:nil, nil];
        
        UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc]
                                            initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        loading.center = CGPointMake(139.5, 75.5);
        [av addSubview:loading];
        [loading startAnimating];
        [av show];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            NSString *base64 = [UIImagePNGRepresentation(originalImage) base64Encoding];
            [self performSelectorOnMainThread:@selector(doCallback:) withObject:base64 waitUntilDone:NO];
            [av dismissWithClickedButtonIndex:0 animated:YES];
        });
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)doCallback:(NSString *)data
{
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@('%@');", callback, data]];
}
@end
