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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.data = NSMutableData()
        let Url = NSURL(string: url)
        let request = NSURLRequest(URL: Url!)
        let _ = NSURLConnection(request: request, delegate: self)
    
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
