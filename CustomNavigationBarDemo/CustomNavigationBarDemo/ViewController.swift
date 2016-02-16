//
//  ViewController.swift
//  CustomNavigationBarDemo
//
//  Created by pfl on 16/2/5.
//  Copyright © 2016年 pfl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var customNavigationBar: UINavigationBar!
    private var customNavigationItem: UINavigationItem = UINavigationItem(title: "Detail")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customNavigationBar = UINavigationBar(frame: CGRectMake(0,0,UIScreen.mainScreen().bounds.width,64))
        customNavigationBar.setItems([customNavigationItem], animated: false)
        customNavigationBar.tintColor = UIColor.whiteColor()
        customNavigationBar.translucent = true
        customNavigationBar.barStyle = .BlackTranslucent
        customNavigationBar.shadowImage = UIImage()
        customNavigationBar.backgroundColor = UIColor.clearColor()
        customNavigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        customNavigationBar.tintAdjustmentMode = .Normal
        view.addSubview(customNavigationBar)
        
        let titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        customNavigationBar.titleTextAttributes = titleTextAttributes
        
        
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        btn.center.y = 200
        btn.center.x = self.view.center.x
        btn.addTarget(self, action: Selector("push"), forControlEvents: .TouchUpInside)
        view.addSubview(btn)
        btn.setTitle("push", forState: .Normal)
        btn.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        
        
        let settingsBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_settings"), style: .Plain, target: self, action: "showSettings:")
        
        customNavigationItem.rightBarButtonItem = settingsBarButtonItem

        
    }
    
    func showSettings(item:UINavigationItem) {
        navigationController?.pushViewController(NextViewController(), animated: true)
    }
    
    
    func push() {
//        navigationController?.pushViewController(NextViewController(), animated: true)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBarHidden = true
    }

    
    
    

}

