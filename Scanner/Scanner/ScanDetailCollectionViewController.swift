//
//  ScanDetailCollectionViewController.swift
//  Scanner
//
//  Created by pfl on 15/6/5.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class ScanDetailCollectionViewController: UICollectionViewController, MKMasonryViewLayoutDelegate,NSFetchedResultsControllerDelegate, UIGestureRecognizerDelegate {

    var fetchResultsController: NSFetchedResultsController?
    var managedObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.registerClass(ScanCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
      
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        fetchResultsController?.delegate = self
        var error: NSError?
        fetchResultsController?.performFetch(&error)
       
        var longGesture = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        self.collectionView?.addGestureRecognizer(longGesture)
        var panGesture = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        self.collectionView?.addGestureRecognizer(panGesture)
        panGesture.delegate = self
        
    }


    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        if let sections = fetchResultsController?.sections
        {
            return  fetchResultsController!.sections!.count
        }
        return 0
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        if let sections = fetchResultsController?.sections
        {
            let sectionInfo: AnyObject =  sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: ScanCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ScanCollectionViewCell
       
        
        var scanItem = fetchResultsController?.objectAtIndexPath(indexPath) as! ScanItem
        
        cell.scanImageView.image = UIImage(named:"scan")
        cell.scanDetailLabel.text = scanItem.scanDetail
        cell.scanDateLabel.text = scanItem.scanDate
        
        return cell 
    }

    func collectionView(collectionView: UICollectionView, layout: ScanViewLayout, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 60
    }
    
 
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var scanItem = fetchResultsController?.objectAtIndexPath(indexPath) as! ScanItem
        if scanItem.scanDetail.hasPrefix("www") || scanItem.scanDetail.hasPrefix("http")
        {
            UIApplication.sharedApplication().openURL(NSURL(string: scanItem.scanDetail!)!)
        }
        
    }
    
 
    
    
    
    
    // MARK: UIGestrueRecognizerDelegate
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    func handlePanGesture(panGesture: UIPanGestureRecognizer)
    {
        
        let dragLayout = self.collectionView?.collectionViewLayout as! ScanViewLayout
        var point = panGesture.translationInView(self.collectionView!)
        var locationPoint = panGesture.locationInView(self.collectionView!)
        var indexpath: NSIndexPath? = self.collectionView!.indexPathForItemAtPoint(locationPoint)
        if indexpath == nil
        {
            return
        }

    
        if point.x < 0
        {
           
            
            
            collectionView?.performBatchUpdates({ () -> Void in
                
                self.collectionView!.deleteItemsAtIndexPaths([indexpath!])
               
                let item: ScanItem = self.fetchResultsController?.objectAtIndexPath(indexpath!) as! ScanItem
                self.managedObjectContext!.deleteObject(item)
                self.managedObjectContext?.save(nil)
                }, completion: nil)
            
            
             self.collectionView?.reloadData()
            
           
          
        }
        
        
    }
    
    
    func handleLongPress(longPress:UILongPressGestureRecognizer)
    {
        
        let dragLayout = self.collectionView?.collectionViewLayout as! ScanViewLayout
        var point = longPress.locationInView(self.collectionView)
        var indexpath = self.collectionView?.indexPathForItemAtPoint(point)
        if indexpath == nil
        {
            return
        }
        var cell = self.collectionView?.cellForItemAtIndexPath(indexpath!) as! ScanCollectionViewCell
        
        switch longPress.state
        {
        case .Began:
            dragLayout.startDraggingIndexPath(indexPath: indexpath!, fromPoint: point)
        case .Ended:
            fallthrough
        case .Cancelled:
            dragLayout.stopDrag()
        case .Changed:
            dragLayout.updateDragLocation(point)
        default: break
            
        }
        
        
    }
    
    
    

}


extension ScanDetailCollectionViewController: NSFetchedResultsControllerDelegate
{
    
  
//    
//    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
//        collectionView?.performBatchUpdates({[weak collectionView] () -> Void in
//            if let strongSelf = collectionView
//            {
//                strongSelf.deleteItemsAtIndexPaths([indexPath!])
//            }
//            }, completion: {[weak collectionView] _ in
//                
//                if let strongSelf = collectionView
//                {
//                    strongSelf.reloadData()
//                }
//        })
//    }
    
    
    
}











