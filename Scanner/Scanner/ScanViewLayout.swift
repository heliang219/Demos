//
//  ScanViewLayout.swift
//  Scanner
//
//  Created by pfl on 15/6/5.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

import UIKit

protocol MKMasonryViewLayoutDelegate
{
    func collectionView(collectionView:UICollectionView, layout: ScanViewLayout, heightForItemAtIndexPath indexPath:NSIndexPath)->CGFloat
}

class ScanViewLayout: UICollectionViewLayout {
   
    private var lastYValueForColumn: NSMutableDictionary? = NSMutableDictionary()
    private var layoutInfo: NSMutableDictionary? = NSMutableDictionary()
    
    var numberOfColumn: NSInteger!
    var interItemSpacing: CGFloat!
    var delegate: MKMasonryViewLayoutDelegate?
    
    override func prepareLayout() {
        
        numberOfColumn = 1
        interItemSpacing = 0
        var currentColumn = 0
        let fullWidth = collectionView?.bounds.width
        var availableSpaceExcludingPadding: CGFloat = fullWidth! - interItemSpacing * (CGFloat(numberOfColumn!) + 1)
        var itemWith: CGFloat = availableSpaceExcludingPadding / CGFloat(numberOfColumn)
        
        let numSections = self.collectionView?.numberOfSections()
        
        for section in 0..<numSections!
        {
            var numItems = self.collectionView?.numberOfItemsInSection(section)
            
            for itemIndex in 0..<numItems!
            {
                var indexPath = NSIndexPath(forItem: itemIndex, inSection: section)
                
                var itemAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                var x = interItemSpacing + (interItemSpacing + itemWith) * CGFloat(currentColumn)
               
                var y: CGFloat = 0
                
                if let obj: AnyObject = lastYValueForColumn!.objectForKey(NSNumber(integer: currentColumn))
                {
                   y = CGFloat(obj.doubleValue)
                }
                
    
                var height: CGFloat = (self.collectionView?.delegate as! MKMasonryViewLayoutDelegate).collectionView(collectionView!, layout: self, heightForItemAtIndexPath: indexPath)
                itemAttributes.frame = CGRectMake(x, y, itemWith, height)
                y += height
                y += interItemSpacing
                
                lastYValueForColumn?.setObject(NSNumber(double: Double(y)), forKey: NSNumber(integer: currentColumn))
                currentColumn++
                if currentColumn == numberOfColumn
                {
                    currentColumn = 0
                }
                
                layoutInfo?.setObject(itemAttributes, forKey: indexPath)
            }
        }
    }
    
    override func collectionViewContentSize() -> CGSize {
        
        var currentColumn = 0
        var maxHeight: CGFloat = 0
        do{
            var height = CGFloat(lastYValueForColumn!.objectForKey(NSNumber(integer: currentColumn))!.doubleValue)
            if maxHeight < height
            {
                maxHeight = height
            }
            currentColumn++
        
        }while(currentColumn < numberOfColumn)
        
        return CGSizeMake(self.collectionView!.bounds.width, maxHeight)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        
        var allAttributes = NSMutableArray(capacity: self.layoutInfo!.count)

        self.layoutInfo?.enumerateKeysAndObjectsUsingBlock({(indexPath, attributes, stop) -> Void in
            
            if CGRectIntersectsRect(rect, (attributes as! UICollectionViewLayoutAttributes).frame)
            {
                allAttributes.addObject(attributes)
            }
            
        })
        
        return allAttributes as [AnyObject]
    }
    
}































