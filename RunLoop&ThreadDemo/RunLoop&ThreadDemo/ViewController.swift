//
//  ViewController.swift
//  RunLoop&ThreadDemo
//
//  Created by pfl on 15/11/20.
//  Copyright © 2015年 pfl. All rights reserved.
//

import UIKit

let url = "https://d13yacurqjgara.cloudfront.net/users/345826/screenshots/1780193/dots18.gif"

class ViewController: UIViewController {

    var data: NSMutableData?
    private lazy var imageView: UIImageView = {
        let imgView = UIImageView(frame: CGRectMake(0, 0, 200, 200))
        imgView.center = self.view.center
        self.view.addSubview(imgView)
        return imgView
    }()
    
    
    private lazy var progress: UIProgressView = {
        let progress = UIProgressView(frame: CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.height, 200, 30))
        progress.trackTintColor = UIColor.redColor()
        progress.progressTintColor = UIColor.greenColor()
        self.view.addSubview(progress)
        return progress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.data = NSMutableData()
        
        let queue = NSOperationQueue()
//        let operation = NSBlockOperation()
//        operation.addExecutionBlock({ () -> Void in
            let Url = NSURL(string: url)
//            let request = NSURLRequest(URL: Url!)
//            let _ = NSURLConnection(request: request, delegate: self)
//            let runloop = NSRunLoop.currentRunLoop()
//            runloop.run()
//
//        })
        
        let operation = MyOperation2(URL: Url, response: { (response, error) -> Void in
            let data = response ?? NSData()
//            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.imageView.image = UIImage(data:data as! NSData)
//                })

//            })
            }) { (progress) -> Void in
//                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.progress.progress = progress;
//                    })
                
//                })

        }
        
        queue.addOperation(operation)
    }

    
    
    

}

extension ViewController: NSURLConnectionDataDelegate {
   
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        print(response.expectedContentLength)
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        print(data.length)
        self.data!.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.imageView.image = UIImage(data: self.data!, scale: UIScreen.mainScreen().scale)
        }
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        
    }
    
    
}
