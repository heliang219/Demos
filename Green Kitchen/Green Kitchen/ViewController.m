//
//  ViewController.m
//  Green Kitchen
//
//  Created by pfl on 16/1/4.
//  Copyright © 2016年 pfl. All rights reserved.
//

#import "ViewController.h"
#import "StoryModel.h"
#import "TableViewCell.h"
#import "CollectionViewLayout.h"
#import "ImageTableView.h"
#import <YYKit/YYKit.h>
#import "DataCenter.h"

#define kScreen_width  [[UIScreen mainScreen]bounds].size.width
#define kScreen_height  [[UIScreen mainScreen]bounds].size.height
#define kRefreshHeight  84

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, CollectionViewLayoutDelegate>
@property (nonatomic, readwrite, strong) UICollectionView *collectionView;
@property (nonatomic, readwrite, strong) NSArray *URLArr;
@property (nonatomic, readwrite, strong) NSMutableArray *dataArr;
@property (nonatomic, readwrite, strong) NSOperationQueue *operationQueue;
@property (nonatomic, readwrite, strong) NSMutableDictionary *operationStack;
@property (nonatomic, readwrite, strong) NSCache *imageCache;
@property (nonatomic, readwrite, strong) UILabel *refreshLabel;
@property (nonatomic, readwrite, strong) UIActivityIndicatorView *refreshControl;
@property (nonatomic, readwrite, assign) BOOL isRefresh;
@property (nonatomic, readwrite, assign) NSInteger pageIndex;
@property (nonatomic, readwrite, assign) BOOL isFirst;
@property (nonatomic, readwrite, strong) OperationManager *operationManager;
@property (nonatomic, readwrite, strong) DataCenter *dataCenter;
@property (nonatomic, readwrite, assign) CGPoint tapPoint;
@property (nonatomic, readwrite, assign) CGPoint originPoint;

@end

@implementation ViewController



@synthesize operationQueue,operationStack,imageCache;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"周末去哪"];
    operationQueue = [[NSOperationQueue alloc]init];
    operationStack = [NSMutableDictionary dictionary];
    imageCache = [[NSCache alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self sendRequestForDataRefresh: YES];
    [self setupSegmemtView];
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self.collectionView addSubview:self.refreshLabel];
    [self.refreshLabel addSubview:self.refreshControl];

}

- (OperationManager *)operationManager {
    if (!_operationManager) {
        _operationManager = [[OperationManager alloc]init];
    }
    return _operationManager;
}

- (DataCenter *)dataCenter {
    if (!_dataCenter) {
        _dataCenter = [[DataCenter alloc]init];
    }
    return _dataCenter;
}

- (void)getData:(NSInteger)pageIndex isRefresh:(BOOL)isRefresh {
    __weak typeof(self) weakself = self;
    [self.dataCenter.dataSignal subscribeNext:^(id x) {
       
        if ([x isKindOfClass:[NSArray class]]) {
            if (isRefresh) {
                [weakself.dataArr removeAllObjects];
            }
            [weakself.dataArr addObjectsFromArray:(NSArray*)x];
            NSLog(@"count:%d",self.dataArr.count);
            [weakself.collectionView reloadData];
        }
        weakself.isRefresh = NO;
    }];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if (!self.isFirst) {
        self.isFirst = YES;
        return;
    }
    
    [self.refreshControl startAnimating];

    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if (self.collectionView.contentOffset.y < -150 ) {
            if (!self.isRefresh) {
                self.isRefresh = YES;
            }

            [UIView animateWithDuration:0.5 animations:^{
                [self.collectionView setContentInset:UIEdgeInsetsMake(64*2, 0, 0, 0)];
            }];
        }
        if (6 ==  self.dataCenter.pageIndex) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.isRefresh = NO;
            });
        }
        
    }
}

- (void)setIsRefresh:(BOOL)isRefresh {
    _isRefresh = isRefresh;
    if (isRefresh) {
        self.refreshLabel.text = @"正在加载...";
        [self sendRequestForDataRefresh:NO];
    }
    else {
        [self.refreshControl stopAnimating];
        self.refreshLabel.text = @"加载完成";
        [UIView animateWithDuration:1.0 animations:^{
            [self.collectionView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
        } completion:^(BOOL finished) {
            self.refreshLabel.text = @"正在加载...";
        }];

    }
}

- (UILabel *)refreshLabel {
    if (!_refreshLabel) {
        _refreshLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, -kRefreshHeight, kScreen_width, kRefreshHeight)];
        _refreshLabel.backgroundColor = [UIColor clearColor];
        self.refreshLabel.bottom = self.collectionView.top;
        _refreshLabel.textAlignment = NSTextAlignmentCenter;
        _refreshLabel.text = @"正在加载...";
    }
    return _refreshLabel;
}

- (UIActivityIndicatorView *)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, 39)];
        _refreshControl.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _refreshControl.bottom = self.refreshLabel.height;
        _refreshControl.centerX = self.refreshLabel.width/2;
    }
    return _refreshControl;
}


- (void)setupSegmemtView {
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    backView.layer.borderColor = [UIColor colorWithRed:0.275 green:0.886 blue:0.333 alpha:1.00].CGColor;
    backView.layer.borderWidth = 0.5;
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, backView.width/2, backView.height)];
    btn.tag = 1;
    [btn setTitle:@"Line" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0.275 green:0.886 blue:0.333 alpha:1.00] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btn];
    
    
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(btn.right, 0, backView.width/2, backView.height)];
    
    RACSignal *enableSignal = [RACSignal combineLatest:@[RACObserve(self, self.dataArr)] reduce:^id(NSArray *arr){
        return @(arr.count > 30);
    }];

    btn2.rac_command = [[RACCommand alloc]initWithEnabled:nil signalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"btn2被点击了"];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{}];
        }];
    }];
    
    
    [[btn2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self btnClicked:btn2];
        [btn2.rac_command.executionSignals.switchToLatest subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
    }];
    
    btn2.tag = 2;
    [btn2 setTitle:@"Grid" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithRed:0.275 green:0.886 blue:0.333 alpha:1.00] forState:UIControlStateNormal];
//    [btn2 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btn2];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 1, backView.height-10)];
    line.centerX = btn.width-0.5;
    line.backgroundColor = [UIColor colorWithRed:0.275 green:0.886 blue:0.333 alpha:1.00];
    [backView addSubview:line];
    
    self.navigationItem.titleView = backView;
}

- (void)btnClicked:(UIButton*)btn {
    CollectionViewLayout *layout = (CollectionViewLayout*)self.collectionView.collectionViewLayout;
    if (btn.tag == 1) {
        layout.numberOfColumns = 1;
        layout.interItemSpacing = 0;
    }
    else {
        layout.numberOfColumns = 3;
        layout.interItemSpacing = 5;
    }
    [self.collectionView scrollToTopAnimated:YES];
    self.dataCenter.pageIndex = 0;
    self.isFirst = NO;
    [self.imageCache removeAllObjects];
    [self sendRequestForDataRefresh:YES];
    [self.collectionView reloadData];
}


- (NSMutableArray*)dataArr {
    if (_dataArr) {
        return _dataArr;
    }
    _dataArr = [NSMutableArray arrayWithCapacity:30];
    return _dataArr;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self scrollViewDidScroll:self.collectionView];
}




- (void)sendRequestForDataRefresh:(BOOL)refresh {
    
    [self getData:self.pageIndex isRefresh:refresh];
#if 0
    AFEngine *angine = [AFEngine shareEngine];
    [angine POST:self.URLArr[self.pageIndex++] parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.isRefresh = NO;

        NSLog(@"responseObject:%@",responseObject);
        
        NSArray *results = [responseObject objectForKey:@"result"][@"list"];
        
        if (results.count == 0 || !results) {

            return;
        }
        
        for (NSDictionary *dic in results) {
            if ([dic isKindOfClass:[NSDictionary class]]) {
                StoryModel *model = [[StoryModel alloc]init];
                model.title = dic[@"title"];
                model.position = dic[@"poi_name_app"];
                model.address  = dic[@"address"];
                model.cost = dic[@"cost"];
                model.tel = dic[@"tel"];
                model.showTime = dic[@"time_txt"];
                [model.picShowArray addObjectsFromArray:dic[@"pic_show"]];
                model.introdution = dic[@"intro"];
                model.introdution_show = dic[@"intro_show"];
                model.genre_main_show = dic[@"genre_main_show"];
                model.genre_name = dic[@"genre_name"];
                model.distance_show = dic[@"distance_show"];
                model.sID = dic[@"id"];
                model.latitude = dic[@"lat"];
                model.longitude = dic[@"lon"];
                model.follow_num = dic[@"statis.follow_num"];
                model.title_vice = dic[@"title_vice"];
                model.isFollow = dic[@"is_follow"];
                model.face = dic[@"pic_show"][0];
                [_dataArr addObject:model];
            }
        }
        [self.collectionView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self setIsRefresh:NO];
    }];
#endif
    
}



- (UICollectionView*)collectionView {
    if (!_collectionView) {
        CollectionViewLayout *layout = [[CollectionViewLayout alloc]init];
        layout.interItemSpacing = 0;
        layout.numberOfColumns = 1;
        layout.delegate = self;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([TableViewCell class])];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addLongGestrue:_collectionView];
    }
    return _collectionView;
}

- (void)addLongGestrue:(UICollectionView*)colletionView {
    UILongPressGestureRecognizer *longGestrue = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap:)];
    [colletionView addGestureRecognizer:longGestrue];
}

- (void)longTap:(UILongPressGestureRecognizer*)tap {
    
    CGFloat IOS_Versoin = [[[UIDevice currentDevice] systemVersion]floatValue];
    
    if (IOS_Versoin < 9.0) {return;}
    
    NSIndexPath *selectedIndexPath = [self.collectionView indexPathForItemAtPoint:[tap locationInView:self.collectionView]];
    __unused CollectionViewLayout *dragLayout = (CollectionViewLayout*)self.collectionView.collectionViewLayout;
    switch (tap.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (selectedIndexPath) {
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self.collectionView updateInteractiveMovementTargetPosition:[tap locationInView:tap.view]];

        }
            break;

        case UIGestureRecognizerStateEnded:
        {
            [self.collectionView endInteractiveMovement];
//            [self dymnicWithLayout:dragLayout indexPath:selectedIndexPath location:[tap locationInView:self.collectionView]];

            break;
        }
        case UIGestureRecognizerStateCancelled:
        {
            [self.collectionView cancelInteractiveMovement];
//            [self dymnicWithLayout:dragLayout indexPath:selectedIndexPath location:[tap locationInView:self.collectionView]];

        }
            
            break;
 
        default:
            break;
        }

}

- (void)dymnicWithLayout:(CollectionViewLayout*)dragLayout indexPath:(NSIndexPath*)indexPath location:(CGPoint)location {
    [UIView animateWithDuration:0.2
                     animations:^{
                         [dragLayout startDraggingIndexPath:indexPath fromPoint:location];
                         
                     }];
    
    [UIView animateWithDuration:1.25
                     animations:^{
                         [dragLayout updateDragLocation:location];
                         
                     }];
    [UIView animateWithDuration:2.25
                     animations:^{
                         [dragLayout stopDragging];
                     }];
}


#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TableViewCell class]) forIndexPath:indexPath];
    StoryModel *model = _dataArr[indexPath.row];
    [cell.favBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.model = model;
    
    [self.operationManager pushImageToImageCachFromURL:model.face indexPath:indexPath cell:cell imageView:cell.imgView];
    
    
//    __block UIImage *thumbImage;
//    thumbImage = [imageCache objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
//    if (thumbImage) {
//        cell.imgView.image = thumbImage;
//    }
//    else {
//        NSBlockOperation *operation = [operationStack objectForKey:[NSString stringWithFormat:@"%d",(int)indexPath.row]];
//        if (!operation) {
//            operation = [[NSBlockOperation alloc]init];
//            [operationStack setObject:operation forKey:[NSString stringWithFormat:@"%d",(int)indexPath.row]];
//        }
    
//        [cell.imgView setImageWithURL:[NSURL URLWithString:model.face] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation];
        
//        __weak typeof(operation) weakOp = operation;
//        [operation addExecutionBlock:^{
//            UIImage *image = [UIImage imageWithData:[model isKindOfClass:[StoryModel class]]?[NSData dataWithContentsOfURL:[NSURL URLWithString:model.face]]:model.facePic];
//            float scale = [UIScreen mainScreen].scale;
//            UIGraphicsBeginImageContextWithOptions(CGSizeMake(cell.bounds.size.width, 230), YES, scale);
//            [image drawInRect:CGRectMake(0, 0, self.view.bounds.size.width, 230)];
//            thumbImage = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                if (![weakOp isCancelled]) {
//                    cell.imgView.image = thumbImage;
//                    [imageCache setObject:thumbImage forKey:[NSString stringWithFormat:@"%d",indexPath.row]];
//                }
//            }];
//        }];
//        [operationQueue addOperation:operation];
//    }
        
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSBlockOperation *operation = [operationStack objectForKey:[NSString stringWithFormat:@"%d",(int)indexPath.row]];
//    if (operation) {
//        if (!operation.cancelled) {
//            [operation cancel];
//            [operationStack removeObjectForKey:[NSString stringWithFormat:@"%d",(int)indexPath.row]];
//        }
//    }
    NSBlockOperation *operation = [self.operationManager.operationStack objectForKey:[NSString stringWithFormat:@"%d",(int)indexPath.row]];
    if (operation) {
        if (!operation.cancelled) {
            [operation cancel];
            [self.operationManager.operationStack removeObjectForKey:[NSString stringWithFormat:@"%d",(int)indexPath.row]];
        }
    }
    
    cell.alpha = 1.0;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = (TableViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.transform = CGAffineTransformMakeScale(1.0, 1.0);
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = (TableViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.transform = CGAffineTransformMakeScale(1.0, 1.0);

}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    StoryModel *model = self.dataArr[sourceIndexPath.row];
    [self.dataArr removeObjectAtIndex:sourceIndexPath.row];
    [self.dataArr insertObject:model atIndex:destinationIndexPath.row];

    UIImage *sourceIndexPathImage = [imageCache objectForKey:[NSString stringWithFormat:@"%ld",sourceIndexPath.row]];
    UIImage *destinationIndexPathImage = [imageCache objectForKey:[NSString stringWithFormat:@"%ld",destinationIndexPath.row]];
    [imageCache removeObjectForKey:[NSString stringWithFormat:@"%ld",sourceIndexPath.row]];
    [imageCache setObject:destinationIndexPathImage forKey:[NSString stringWithFormat:@"%ld",sourceIndexPath.row]];
    [imageCache setObject:sourceIndexPathImage forKey:[NSString stringWithFormat:@"%ld",destinationIndexPath.row]];
    [self.collectionView reloadData];
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    TableViewCell *cell = (TableViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    CGPoint point = [cell.imgView convertPoint:CGPointMake(20, 200) fromView:cell.contentView];
    
    self.originPoint = (CGPoint){CGRectGetWidth(cell.frame)/2 + cell.frame.origin.x,cell.frame.origin.y-collectionView.contentOffset.y+170/2};
    
    [self getCoverView:cell.imgView.image point:point];
    
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}




#pragma mark UIScrollViewDelegate



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    [self.refreshControl startAnimating];
//    if (self.collectionView.contentOffset.y < -150 ) {
//        if (!self.isRefresh) {
//            self.isRefresh = YES;
//        }
//        
//        [UIView animateWithDuration:0.5 animations:^{
//            [self.collectionView setContentInset:UIEdgeInsetsMake(64*2, 0, 0, 0)];
//        }];
//    }
//    if (6 ==  self.dataCenter.pageIndex) {
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.isRefresh = NO;
//        });
//    }
    
    NSArray *visibleCells = [self.collectionView visibleCells];
    for (__unused TableViewCell *cell in visibleCells) {
        CGFloat offSetY = scrollView.contentOffset.y;
        CGFloat picViewHeight = 230;
        
//        NSLog(@"==cell==%0.2f",cell.frame.origin.y-offSetY);
        
        CGFloat Y = - 30.0/CGRectGetHeight([UIScreen mainScreen].bounds) * (cell.frame.origin.y-offSetY) - 30;
        
//        NSLog(@"==Y==%0.2f",Y);
        
        [UIView animateWithDuration:0.3 animations:^{
            cell.imgView.frame = CGRectMake(0,Y,CGRectGetWidth(self.collectionView.frame), picViewHeight);
            cell.alpha = 1.0;
        }];
    }
}


#pragma mark CollectionViewLayoutDelegate 

- (CGFloat)collectionView:(UICollectionView*) collectionView
                   layout:(CollectionViewLayout*) layout
 heightForItemAtIndexPath:(NSIndexPath*) indexPath {
    return 170;
    return 80 + random()%151;
}


#pragma mark 

- (void)getCoverView:(UIImage*)image point:(CGPoint)point {
    
    UIImageView *coverImageView = [[UIImageView alloc]initWithImage:image];
   
    
    [UIView animateWithDuration:0.4 animations:^{
        CGRect rect = coverImageView.frame;
        rect.origin.y = point.y;
        rect.size.width = [[UIScreen mainScreen] bounds].size.width;
        coverImageView.frame = rect;
    } completion:^(BOOL finished) {
        
    }];
    
    UIView *cover = [[UIView alloc]initWithFrame:self.view.bounds];
    [cover addSubview:coverImageView];
    coverImageView.tag = 10000;
    cover.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeFromParentView:)]];
    [[[UIApplication sharedApplication] keyWindow]addSubview:cover];
    
}

- (void)removeFromParentView:(UIGestureRecognizer*)tap {

    [UIView animateWithDuration:1 animations:^{
        UIView *imageView = [tap.view viewWithTag:10000];
        CGRect rect = imageView.frame;
        rect.size.width = 30;
        rect.size.height = 30;
        imageView.alpha = 0.0;
        imageView.frame = rect;
        imageView.center = self.originPoint;

    } completion:^(BOOL finished) {
        [tap.view removeFromSuperview];

    }];
    
    
}


- (void)btnClick:(UIButton*)btn {
    
}




@end




























