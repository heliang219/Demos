//
//  ViewController.swift
//  CustomKeyBoard
//
//  Created by pfl on 15/7/2.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let textView = UITextView(frame: CGRectMake(0, 20, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height-20))
        textView.font = UIFont.systemFontOfSize(16)
      
        view.addSubview(textView)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

