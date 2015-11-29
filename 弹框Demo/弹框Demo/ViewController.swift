//
//  ViewController.swift
//  弹框Demo
//
//  Created by pfl on 15/9/4.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let btn = UIButton(frame: CGRectMake(0, 0, 100, 44))
        btn.center = CGPointMake(self.view.center.x, 100);
        btn.addTarget(self, action: Selector("showAlertView"), forControlEvents: UIControlEvents.TouchUpInside)
        btn.setTitle("btn", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        view.addSubview(btn)
        
        
    }
    
    
    func showAlertView() {
        
        let keyWindow = UIApplication.sharedApplication().keyWindow
        let coverView = UIView(frame: UIScreen.mainScreen().bounds)
        coverView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        coverView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "remove"))
        keyWindow!.addSubview(coverView)
        coverView.tag = 2
        
        let alertView = UIView(frame: CGRectMake(0, 0, 200, 200))
        alertView.center = view.center;
        alertView.backgroundColor = UIColor.redColor()
        keyWindow?.addSubview(alertView)
        alertView.transform = CGAffineTransformMakeScale(0.3, 0.3)
        alertView.tag = 3
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            alertView.transform = CGAffineTransformMakeScale(1.1, 1.1)

            }, completion: { _ in
        
                alertView.transform = CGAffineTransformMakeScale(1.0, 1.0)

        })
        
        
    }
   
    func remove() {
        
        let keyWindow = UIApplication.sharedApplication().keyWindow
        let alertView = keyWindow!.viewWithTag(3)!
        let coverView = keyWindow!.viewWithTag(2)!
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            alertView.transform = CGAffineTransformMakeScale(0.3, 0.3)
            coverView.alpha = 1.0
            }, completion: { _ in
                alertView.removeFromSuperview()
                coverView.removeFromSuperview()
        })
        
    }
    



}

