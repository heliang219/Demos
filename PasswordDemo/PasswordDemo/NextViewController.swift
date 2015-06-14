//
//  NextViewController.swift
//  PasswordDemo
//
//  Created by dongbailan on 15/6/13.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(UIImageView(image: UIImage(named: "5C")))
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: "back")
        
    }

    func back()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}
