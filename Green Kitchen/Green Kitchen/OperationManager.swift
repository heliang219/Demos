//
//  OperationManager.swift
//  Green Kitchen
//
//  Created by pfl on 16/1/12.
//  Copyright © 2016年 pfl. All rights reserved.
//

import Foundation
import UIKit

class OperationManager: NSObject {

    var indexPath: NSIndexPath?
    var cachImage: UIImage?
    
    private lazy var imageCach: NSCache = {
        var imageCach = NSCache()
        return imageCach
    }()
    
    let operationStack: NSMutableDictionary = {
        var stack = NSMutableDictionary()
        return stack
    }()
    
    lazy var operationQueue: NSOperationQueue = {
        var operationQueue = NSOperationQueue()
        return operationQueue
    }()
    
    
    func operationForIndexPath(indexPath: NSIndexPath)->NSBlockOperation? {
        return operationStack.objectForKey(indexPath.row.intToString()) as? NSBlockOperation
    }
    
    func cachImageForIndexPath(indexPath: NSIndexPath) -> UIImage? {
        
        return imageCach.objectForKey(indexPath) as? UIImage
    }
    
    func pushImageToImageCachFromURL(url:String, indexPath: NSIndexPath, cell: TableViewCell, imageView: UIImageView) {
        
        let tuImgae = imageCach.objectForKey(indexPath) as? UIImage
        if tuImgae != nil {
            imageView.image = tuImgae
            return
        }
        
        var operation: NSBlockOperation? = operationStack .objectForKey(indexPath.row.intToString()) as? NSBlockOperation
        if operation == nil {
            operation = NSBlockOperation()
            operationStack.setObject(operation!, forKey: indexPath.row.intToString())
        }
        operation!.addExecutionBlock { () -> Void in
            let URL = NSURL(string: url)
            guard let URL1 = URL else{return}
            let data: NSData? = NSData(contentsOfURL: URL1)
            guard let data1 = data else {return}
            let image = UIImage(data: data1)
            guard let image1 = image else {return}
            
            let _ = UIScreen.mainScreen().scale;
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(cell.bounds.width, 230), false, 0)
            image1.drawInRect(CGRectMake(0, 0, cell.bounds.width, 230))
            let thumbImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext();
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                if !operation!.cancelled {
                    imageView.image = thumbImage
                    self.imageCach.setObject(thumbImage, forKey: indexPath)
                }
            })
        }
        operationQueue.addOperation(operation!)
    }
    
}


extension Int {
    func intToString()->String {
        return String(self)
    }
}















