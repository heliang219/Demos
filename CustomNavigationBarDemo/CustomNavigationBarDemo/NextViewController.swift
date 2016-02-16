//
//  NextViewController.swift
//  CustomNavigationBarDemo
//
//  Created by pfl on 16/2/5.
//  Copyright © 2016年 pfl. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    @IBOutlet weak var TelephoneTextField: UITextField!
    @IBOutlet weak var MobileTextFiled: NSLayoutConstraint!
    @IBOutlet weak var MobileTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var LabelWidthConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.redColor()
        LabelWidthConstraint.constant = 80
        MobileTopConstraint.constant = 20
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = false
        
        UIView.animateWithDuration(2.3, animations: { () -> Void in
            
            self.TelephoneTextField.frame.origin.x = self.view.frame.width
//            self.MobileTopConstraint.constant += 100
            
            }, completion: { _ in
                self.TelephoneTextField.frame.origin.x = -self.TelephoneTextField.frame.width
               self.viewWillAppear(animated)
        })
        
        
    }
    
}
