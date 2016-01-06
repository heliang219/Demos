//
//  CollectionViewLayout.h
//  QianHaiWallet
//
//  Created by pfl on 15/12/20.
//  Copyright © 2015年 QianHai Electronic Pay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CollectionViewLayout;
@protocol CollectionViewLayoutDelegate <NSObject>
@required
- (CGFloat)collectionView:(UICollectionView*) collectionView
                    layout:(CollectionViewLayout*) layout
  heightForItemAtIndexPath:(NSIndexPath*) indexPath;
@end

@interface CollectionViewLayout : UICollectionViewLayout
@property (nonatomic, assign) NSUInteger numberOfColumns;
@property (nonatomic, assign) CGFloat interItemSpacing;
@property (weak, nonatomic)  id<CollectionViewLayoutDelegate> delegate;

- (void)startDraggingIndexPath:(NSIndexPath *)indexPath
                     fromPoint:(CGPoint)p;
- (void)updateDragLocation:(CGPoint)point;
- (void)stopDragging;


@end