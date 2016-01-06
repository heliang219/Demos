//
//  CollectionViewLayout.m
//  QianHaiWallet
//
//  Created by pfl on 15/12/20.
//  Copyright © 2015年 QianHai Electronic Pay. All rights reserved.
//

#import "CollectionViewLayout.h"

@interface CollectionViewLayout ()
@property (nonatomic, strong) NSMutableDictionary *lastYValueForColumn;
@property (strong, nonatomic) NSMutableDictionary *layoutInfo;
@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) UIAttachmentBehavior *behavior;
@property (nonatomic, readwrite, strong) NSIndexPath *toIndexPath;

@end
@implementation CollectionViewLayout

#define ZOOM_FACTOR 0.35



- (void)prepareLayout {
    [super prepareLayout];
    self.lastYValueForColumn = [NSMutableDictionary dictionary];
    CGFloat currentColumn = 0;
    CGFloat fullWidth = self.collectionView.frame.size.width;
    CGFloat availableSpaceExcludingPadding = fullWidth - (self.interItemSpacing * (self.numberOfColumns + 1));
    CGFloat itemWidth = availableSpaceExcludingPadding / self.numberOfColumns;
    self.layoutInfo = [NSMutableDictionary dictionary];
    NSIndexPath *indexPath;
    NSInteger numSections = [self.collectionView numberOfSections];
    
    for(NSInteger section = 0; section < numSections; section++)  {
        
        NSInteger numItems = [self.collectionView numberOfItemsInSection:section];
        for(NSInteger item = 0; item < numItems; item++){
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            CGFloat x = self.interItemSpacing + (self.interItemSpacing + itemWidth) * currentColumn;
            CGFloat y = [self.lastYValueForColumn[@(currentColumn)] doubleValue] + self.interItemSpacing/2.0;
            
            CGFloat height = [((id<CollectionViewLayoutDelegate>)self.collectionView.delegate)
                              collectionView:self.collectionView
                              layout:self
                              heightForItemAtIndexPath:indexPath];
            
            itemAttributes.frame = CGRectMake(x, y, itemWidth, height);
            y+= height;
            y += self.interItemSpacing;
            
            self.lastYValueForColumn[@(currentColumn)] = @(y);

            currentColumn ++;
            if(currentColumn == self.numberOfColumns) currentColumn = 0;
            self.layoutInfo[indexPath] = itemAttributes;
        }
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                         UICollectionViewLayoutAttributes *attributes,
                                                         BOOL *stop) {
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            if (attributes.indexPath != self.indexPath) {
                [allAttributes addObject:attributes];
            }
        }
    }];
    
    [allAttributes addObjectsFromArray:[self.animator itemsInRect:rect]];

    return allAttributes;
}

-(CGSize) collectionViewContentSize {
    
    NSUInteger currentColumn = 0;
    CGFloat maxHeight = 0;
    do {
        CGFloat height = [self.lastYValueForColumn[@(currentColumn)] doubleValue];
        if(height > maxHeight)
            maxHeight = height;
        currentColumn ++;
    } while (currentColumn < self.numberOfColumns);
    
    return CGSizeMake(self.collectionView.frame.size.width, maxHeight);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGRect oldRect = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldRect)) {
        return YES;
    }
    return NO;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item >= self.layoutInfo.count || indexPath.section >= self.layoutInfo.count) {
        return nil;
    }
    return self.layoutInfo[indexPath];
}



- (UICollectionViewLayoutInvalidationContext *)invalidationContextForEndingInteractiveMovementOfItemsToFinalIndexPaths:(NSArray<NSIndexPath *> *)indexPaths previousIndexPaths:(NSArray<NSIndexPath *> *)previousIndexPaths movementCancelled:(BOOL)movementCancelled {
    UICollectionViewLayoutInvalidationContext *context = [super invalidationContextForEndingInteractiveMovementOfItemsToFinalIndexPaths:indexPaths previousIndexPaths:previousIndexPaths movementCancelled:movementCancelled];
    [self.collectionView moveItemAtIndexPath:previousIndexPaths[0] toIndexPath:indexPaths[0]];
    self.toIndexPath = indexPaths[0];
    return context;
}




- (void)startDraggingIndexPath:(NSIndexPath *)indexPath
                     fromPoint:(CGPoint)p {
    self.indexPath = indexPath;
    self.animator = [[UIDynamicAnimator alloc]
                     initWithCollectionViewLayout:self];
    self.toIndexPath = indexPath;
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:self.indexPath];
    
    // Raise the item above its peers
    attributes.zIndex += 1;
    if (!attributes) {return;}
    self.behavior = [[UIAttachmentBehavior alloc] initWithItem:attributes
                                              attachedToAnchor:p];
    self.behavior.length = 0;
    self.behavior.frequency = 10;
    [self.animator addBehavior:self.behavior];
    
    // Add a little resistance to keep things stable
    UIDynamicItemBehavior *dynamicItem = [[UIDynamicItemBehavior alloc]
                                          initWithItems:@[attributes]];
    dynamicItem.resistance = 10;
    [self.animator addBehavior:dynamicItem];
    
    [self updateDragLocation:attributes.center];
}

- (void)updateDragLocation:(CGPoint)p {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.behavior.anchorPoint = p;

    });
}

- (void)stopDragging {
    // Move back to the original location (super)
    UICollectionViewLayoutAttributes *
    attributes = [self layoutAttributesForItemAtIndexPath:self.toIndexPath];
    [self updateDragLocation:attributes.center];
    self.indexPath = nil;
    self.behavior = nil;
}

@end







