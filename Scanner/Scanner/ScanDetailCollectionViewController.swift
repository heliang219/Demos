//
//  ScanDetailCollectionViewController.swift
//  Scanner
//
//  Created by pfl on 15/6/5.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class ScanDetailCollectionViewController: UICollectionViewController, MKMasonryViewLayoutDelegate,NSFetchedResultsControllerDelegate {

    var fetchResultsController: NSFetchedResultsController?
    var managedObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.registerClass(ScanCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
      
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        fetchResultsController?.delegate = self
        var error: NSError?
        fetchResultsController?.performFetch(&error)
       
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
    

}














