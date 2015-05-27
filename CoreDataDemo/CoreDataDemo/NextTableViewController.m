//
//  NextTableViewController.m
//  CoreDataDemo
//
//  Created by pfl on 15/5/26.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

#import "NextTableViewController.h"
#import "ShopIncomeItem.h"
@interface NextTableViewController ()
@property (nonatomic, strong) ShopIncomeItem *shopIcomeItem;

@property (nonatomic, strong) NSArray *arr;

@end

@implementation NextTableViewController

- (instancetype)initWithShopIncomeItem:(ShopIncomeItem *)shopIcomeItem
{
    if (self = [super initWithStyle:(UITableViewStylePlain)]) {
        
        _shopIcomeItem = shopIcomeItem;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ShopIncomeItem"];
//    fetchRequest.predicate = [NSPredicate predicateWithValue:YES];
//    fetchRequest.sortDescriptors = @[[[NSSortDescriptor alloc]initWithKey:@"allrebate" ascending:YES]];
//    
//    self.fetchResultController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.shopIcomeItem.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"ShopIncomeItem"];
    request.predicate = [NSPredicate predicateWithValue:YES];
    NSArray* objects = [self.shopIcomeItem.managedObjectContext executeFetchRequest:request error:NULL];
    self.arr = objects;
    
//    self.fetchResultController = [_shopIcomeItem fetchResultsController];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return self.fetchResultController.sections.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    id<NSFetchedResultsSectionInfo> setionInfo = self.fetchResultController.sections[section];
    
    return _arr.count; 
    return  [setionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    
    ShopIncomeItem *item = _arr[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%0.2f",item.outrebatemover.doubleValue];
   
    return cell;
}



@end


