//
//  ViewController.swift
//  AnimationDemo
//
//  Created by pfl on 16/2/1.
//  Copyright © 2016年 pfl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view .addSubview(self.tip)
        self.view.addSubview(self.btn)
        self.btn.addTarget(self, action: Selector("addCover"), forControlEvents: .TouchUpInside)
    }

    
    private let tip: UILabel = {
       let tip = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 44))
        tip.center.y = UIScreen.mainScreen().bounds.height/2
        tip.text = "这是一个demo"
        tip.textAlignment = .Center
        tip.font = UIFont.systemFontOfSize(20)
        return tip
    }()
    
    
    private let cover: UIView = {
       let cover = UIView(frame: UIScreen.mainScreen().bounds)
        cover.backgroundColor = UIColor.blackColor()
        return cover
    }()


    private let btn: UIButton = {
       let btn = UIButton(frame: CGRect(x: 0, y: 0, width:  80, height: 44))
        btn.center.y = UIScreen.mainScreen().bounds.height - 100
        btn.center.x = UIScreen.mainScreen().bounds.width/2
        btn.setTitle("btn", forState: .Normal)
        btn.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        return btn
    }()
    
    func addCover() {
        var image = self.getCurrentCover()
        image = image.applyBlurWithRadius(0.0, tintColor: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5), saturationDeltaFactor: 5.0, maskImage: nil)
        let imageView = UIImageView(image: image)
        
        self.cover.addSubview(imageView)
        UIApplication.sharedApplication().keyWindow?.addSubview(self.cover)
    }
    
    func getCurrentCover()->UIImage {
        UIGraphicsBeginImageContextWithOptions(UIScreen.mainScreen().bounds.size, true, UIScreen.mainScreen().scale)
        view.drawViewHierarchyInRect(self.view.bounds, afterScreenUpdates:false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
















