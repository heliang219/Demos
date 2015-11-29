//
//  KeyButton.swift
//  CustomKeyBoard
//
//  Created by pfl on 15/7/2.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

import UIKit

class KeyButton: UIButton {

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 24.0)
        self.titleLabel?.textAlignment = .Center
        self.setTitleColor(UIColor(white: 68.0/255, alpha: 1), forState: UIControlState.Normal)
        self.titleLabel?.sizeToFit()
        
//        self.layer.borderWidth = 0.5
//        self.layer.borderColor = UIColor(red: 216.0/255, green: 211.0/255, blue: 199.0/255, alpha: 1).CGColor
//        self.layer.cornerRadius = 3
        
//        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.contentVerticalAlignment = .Center
        self.contentHorizontalAlignment = .Center
        
       
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
