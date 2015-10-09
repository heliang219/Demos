//
//  ViewController.m
//  RACDemo2
//
//  Created by pfl on 15/10/7.
//  Copyright © 2015年 pfl. All rights reserved.
//
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ViewController.h"
#import "ViewModel.h"
#import "Book.h"
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, readwrite, strong) UITableView *tabelView;
@property (nonatomic, readwrite, strong) ViewModel *viewModel;
@property (nonatomic, readwrite, strong) NSArray *arr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tabelView];
    
   RACSignal *requestSignal = [self.viewModel getDatasFromWeb];
    @weakify(self);
    [requestSignal subscribeNext:^(NSArray *models) {
        @strongify(self);
        self.arr = models;
        [self.tabelView reloadData];
    }];
}

- (ViewModel*)viewModel {
    if (!_viewModel) {
        _viewModel = [[ViewModel alloc]init];
    }
    return _viewModel;
}

- (UITableView*)tabelView {
    if (!_tabelView) {
        _tabelView = ({
            UITableView *tabelView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
            tabelView.delegate = self;
            tabelView.dataSource = self;
            tabelView.rowHeight = 80;
            tabelView;
        });
    }
    return _tabelView;
}
#pragma mark UITableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
    return self.viewModel.models.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    Book *book = self.arr[indexPath.row];
    cell.textLabel.text = book.title;
    cell.detailTextLabel.text = book.price;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:book.image]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = image;
            cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        });
    });
    return cell;
}

@end
























