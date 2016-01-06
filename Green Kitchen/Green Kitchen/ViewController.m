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


@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, CollectionViewLayoutDelegate>
@property (nonatomic, readwrite, strong) UICollectionView *collectionView;
@property (nonatomic, readwrite, strong) NSArray *URLArr;
@property (nonatomic, readwrite, strong) NSMutableArray *dataArr;
@property (nonatomic, readwrite, strong) NSOperationQueue *operationQueue;
@property (nonatomic, readwrite, strong) NSMutableDictionary *operationStack;
@property (nonatomic, readwrite, strong) NSCache *imageCache;

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
}

- (NSMutableArray*)dataArr {
    if (_dataArr) {
        return _dataArr;
    }
    _dataArr = [NSMutableArray arrayWithCapacity:30];
    return _dataArr;
    
}


- (NSArray*)URLArr
{
    return @[@"http://www.wanzhoumo.com/wanzhoumo?UUID=97B42FCB-7D7A-4D41-A80B-24644CBEE429&app_key=800000002&app_v_code=12&app_v_name=2.2.1&format=json&is_near=1&is_valid=1&lat=22.562433&lon=113.904398&method=activity.List&os=iphone&pagesize=30&r=wanzhoumo&sign=0f97295d4c92c73217ff8341fb11b20c&sort=default&timestamp=1409632143&top_session=n8i2d0ie4g77qfb8dmoot08ct7&v=2.0",@"http://www.wanzhoumo.com/wanzhoumo?UUID=97B42FCB-7D7A-4D41-A80B-24644CBEE429&app_key=800000002&app_v_code=12&app_v_name=2.2.1&format=json&is_near=1&is_valid=1&lat=22.535044&lon=113.944849&method=activity.List&offset=30&os=iphone&pagesize=30&r=wanzhoumo&sign=7cf20949bd9c5990598836ba6ef073da&sort=default&timestamp=1410335762&v=2.0",@"http://www.wanzhoumo.com/wanzhoumo?UUID=97B42FCB-7D7A-4D41-A80B-24644CBEE429&app_key=800000002&app_v_code=12&app_v_name=2.2.1&format=json&is_near=1&is_valid=1&lat=22.535044&lon=113.944849&method=activity.List&offset=60&os=iphone&pagesize=30&r=wanzhoumo&sign=de3ff25211b760930bb81433e527b5df&sort=default&timestamp=1410335834&v=2.0",@"http://www.wanzhoumo.com/wanzhoumo?UUID=97B42FCB-7D7A-4D41-A80B-24644CBEE429&app_key=800000002&app_v_code=12&app_v_name=2.2.1&format=json&is_near=1&is_valid=1&lat=22.535044&lon=113.944849&method=activity.List&offset=90&os=iphone&pagesize=30&r=wanzhoumo&sign=8f2e34692044cb173e023e6d5ef6e9f5&sort=default&timestamp=1410335871&v=2.0",@"http://www.wanzhoumo.com/wanzhoumo?UUID=97B42FCB-7D7A-4D41-A80B-24644CBEE429&app_key=800000002&app_v_code=12&app_v_name=2.2.1&format=json&is_near=1&is_valid=1&lat=22.535044&lon=113.944849&method=activity.List&offset=120&os=iphone&pagesize=30&r=wanzhoumo&sign=46db75331082d7beb1c11efac327df23&sort=default&timestamp=1410335913&v=2.0",@"http://www.wanzhoumo.com/wanzhoumo?UUID=97B42FCB-7D7A-4D41-A80B-24644CBEE429&app_key=800000002&app_v_code=12&app_v_name=2.2.1&format=json&is_near=1&is_valid=1&lat=22.535044&lon=113.944849&method=activity.List&offset=150&os=iphone&pagesize=30&r=wanzhoumo&sign=f1f7bb7819db7b4fd36464ef41b9d477&sort=default&timestamp=1410335945&v=2.0"];
}


- (void)sendRequestForDataRefresh:(BOOL)refresh {
    AFEngine *angine = [AFEngine shareEngine];
    [angine POST:self.URLArr.firstObject parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject:%@",responseObject);
        
        NSArray *results = [responseObject objectForKey:@"result"][@"list"];
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
        
    }];
    
    
}



- (UICollectionView*)collectionView {
    if (!_collectionView) {
        CollectionViewLayout *layout = [[CollectionViewLayout alloc]init];
        layout.interItemSpacing = 10;
        layout.numberOfColumns = 3;
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
    NSIndexPath *selectedIndexPath = [self.collectionView indexPathForItemAtPoint:[tap locationInView:self.collectionView]];
    CollectionViewLayout *dragLayout = (CollectionViewLayout*)self.collectionView.collectionViewLayout;
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
            [self dymnicWithLayout:dragLayout indexPath:selectedIndexPath location:[tap locationInView:self.collectionView]];

            break;
        }
        case UIGestureRecognizerStateCancelled:
        {
            [self.collectionView cancelInteractiveMovement];
            [self dymnicWithLayout:dragLayout indexPath:selectedIndexPath location:[tap locationInView:self.collectionView]];

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
    
    __block UIImage *thumbImage;
    thumbImage = [imageCache objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    if (thumbImage) {
        cell.imgView.image = thumbImage;
    }
    else {
        NSBlockOperation *operation = [operationStack objectForKey:[NSString stringWithFormat:@"%d",(int)indexPath.row]];
        if (!operation) {
            operation = [[NSBlockOperation alloc]init];
            [operationStack setObject:operation forKey:[NSString stringWithFormat:@"%d",(int)indexPath.row]];
        }
        
        __weak typeof(operation) weakOp = operation;
        [operation addExecutionBlock:^{
            UIImage *image = [UIImage imageWithData:[model isKindOfClass:[StoryModel class]]?[NSData dataWithContentsOfURL:[NSURL URLWithString:model.face]]:model.facePic];
            float scale = [UIScreen mainScreen].scale;
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(cell.bounds.size.width, 230), YES, scale);
            [image drawInRect:CGRectMake(0, 0, self.view.bounds.size.width, 230)];
            thumbImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (![weakOp isCancelled]) {
                    cell.imgView.image = thumbImage;
                    [imageCache setObject:thumbImage forKey:[NSString stringWithFormat:@"%d",indexPath.row]];
                }
            }];
        }];
        [operationQueue addOperation:operation];
    }
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSBlockOperation *operation = [operationStack objectForKey:[NSString stringWithFormat:@"%d",(int)indexPath.row]];
    if (operation) {
        if (!operation.cancelled) {
            [operation cancel];
            [operationStack removeObjectForKey:[NSString stringWithFormat:@"%d",(int)indexPath.row]];
        }
    }
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

#pragma mark UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSArray *visibleCells = [self.collectionView visibleCells];
    for (__unused TableViewCell *cell in visibleCells) {
//        cell.alpha = 0.8;
    }
    
}

#pragma mark CollectionViewLayoutDelegate 

- (CGFloat)collectionView:(UICollectionView*) collectionView
                   layout:(CollectionViewLayout*) layout
 heightForItemAtIndexPath:(NSIndexPath*) indexPath {
    return 230;
    return 80 + random()%151;
}


#pragma mark 

- (void)btnClick:(UIButton*)btn {
    
}




@end




























