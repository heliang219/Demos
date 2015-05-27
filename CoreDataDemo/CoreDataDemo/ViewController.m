//
//  ViewController.m
//  CoreDataDemo
//
//  Created by pfl on 15/5/26.
//  Copyright (c) 2015年 pfl. All rights reserved.
//
#define BASEURL             @"http://192.168.50.116:8080/sellerService/"      // 商家app内网测试接口
#define EARNINGS        @"earnings"                                    // 显示当前及昨天的收益状态

#define  AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//App端版本号 范围1.0.0-9.9.9       尾号0001：为App store 渠道编号
//#define  IosAppVersion @"1.2.0.0001"
#define  IosAppVersion    [NSString stringWithFormat:@"%@.0001",AppVersion]

//app端系统版本，如android 4.3或ios 7.1
#define  IOS_VERSION [[UIDevice currentDevice].systemVersion floatValue]

//API版本，默认版本1 范围1-99
#define  API_Version   @"2"

// API版本3, 修改该商家的介绍信息
#define  API_Version3   @"3"

#import "ViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "ShopIncomeItem.h"
#import "NextTableViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSString *token;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"next" style:(UIBarButtonItemStylePlain) target:self action:@selector(next)];
  

}

- (void)next
{
    NextTableViewController *next = [[NextTableViewController alloc]initWithShopIncomeItem:_shopIncomeItem];
    [self.navigationController pushViewController:next animated:YES];
    next.fetchResultController = _shopIncomeItem.fetchResultsController;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    NSString *password = [self transforToCCMD5:@"123456"];
    
    NSString *urlString = [NSString stringWithFormat:@"account=%@&password=%@&iostoken=%@&appversion=%@&systemversion=%@&apiversion=%@",@"18600000009",password,@"ios", IosAppVersion,[NSString stringWithFormat:@"%0.1f",IOS_VERSION],API_Version3];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL, @"login"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSData *data = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
                NSLog(@"dic%@",dic);
        
        NSDictionary *respones = [dic objectForKey:@"response"];
        self.token = [respones objectForKey:@"sessiontoken"];
        
        [self sendRequestForEarning];
    }];
    [task resume];
}

- (void)sendRequestForEarning
{
    NSString *urlString = [NSString stringWithFormat:@"sessiontoken=%@&appversion=%@&systemversion=%@&apiversion=%@",self.token, IosAppVersion,[NSString stringWithFormat:@"%0.1f",IOS_VERSION],API_Version3];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASEURL, EARNINGS]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSData *data = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSLog(@"dic%@",dic);
        
        [self paresData:dic[@"response"]];
        
        
        
    }];
    [task resume];
}

- (void)paresData:(NSDictionary*)dic
{
    
    self.shopIncomeItem.adcommision = [dic[@"adcommision"] doubleValue];
    self.shopIncomeItem.adincome = [[dic objectForKey:@"adincome"] doubleValue];
    self.shopIncomeItem.allmember = [[dic objectForKey:@"allmember"] doubleValue];
    self.shopIncomeItem.allorder =[[dic objectForKey:@"allorder"] doubleValue];
    self.shopIncomeItem.allrebate = [[dic objectForKey:@"allrebate"] doubleValue];
    self.shopIncomeItem.allturnover = [[dic objectForKey:@"allturnover"] doubleValue];
    self.shopIncomeItem.availablerebate = [[dic objectForKey:@"availablerebate"] doubleValue];
    self.shopIncomeItem.availbleturnover = [[dic objectForKey:@"availableturnover"] doubleValue];
    self.shopIncomeItem.sncommision = [[dic objectForKey:@"sncommision"]doubleValue];
    self.shopIncomeItem.snincome = [[dic objectForKey:@"snincome"]doubleValue];
    self.shopIncomeItem.todayorder = [[dic objectForKey:@"todayorder"] doubleValue];
    self.shopIncomeItem.todayoutsidemover = [[dic objectForKey:@"todayoutsidemover"] doubleValue];
    self.shopIncomeItem.todayrebate = [[dic objectForKey:@"todayrebate"] doubleValue];
    self.shopIncomeItem.todayturnover = [[dic objectForKey:@"todayturnover"]doubleValue];
    self.shopIncomeItem.nacommision = [[dic objectForKey:@"nacommision"] doubleValue];
    self.shopIncomeItem.naincome = [[dic objectForKey:@"naincome"] doubleValue];
    self.shopIncomeItem.newmember = [[dic objectForKey:@"newmember"]doubleValue];
    self.shopIncomeItem.orderrebate = [[dic objectForKey:@"orderrebate"] doubleValue];
    self.shopIncomeItem.outrebatemover = [[dic objectForKey:@"outrebatemover"] doubleValue];
    self.shopIncomeItem.outsidemover = [[dic objectForKey:@"outsidemover"] doubleValue];
    self.shopIncomeItem.ystdayrebate = [[dic objectForKey:@"ystdayrebate"]doubleValue];
    self.shopIncomeItem.ystdayturnover = [[dic objectForKey:@"ystdayturnover"] doubleValue];
    self.shopIncomeItem.giverebate = [[dic objectForKey:@"giverebate"]doubleValue];
    [ShopIncomeItem insertShopIncomeItem:self.shopIncomeItem inManagedObjectContext:self.shopIncomeItem.managedObjectContext];
}



- (NSString *)transforToCCMD5:(NSString *)password
{
    const char *cStr = [password UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++) {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.shopIncomeItem.managedObjectContext save:NULL];
    
    
}


@end











