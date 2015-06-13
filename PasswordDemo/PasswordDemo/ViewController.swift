//
//  ViewController.swift
//  PasswordDemo
//
//  Created by pfl on 15/6/12.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

import UIKit


class ViewController: UIViewController, verifyPwdProtocol{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let  passwordView = PasswordView(frame: UIScreen.mainScreen().bounds)
            passwordView.delegate = self
        passwordView.backgroundColor = UIColor.whiteColor()
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(passwordView)
        
        
        
        
    }

    func callbackpwd(status: Bool) {
               
        presentViewController(NextViewController(), animated: true, completion: nil)
    }

}

