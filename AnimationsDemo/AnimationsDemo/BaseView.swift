
//
//  BaseView.swift
//  AnimationsDemo
//
//  Created by pfl on 15/11/20.
//  Copyright © 2015年 pfl. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let image = UIImage(named: "HomeAd1")
        let imagePath = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 20, y: 230), size: CGSize(width: 100, height: 100)), byRoundingCorners: .AllCorners, cornerRadii: CGSize(width: 50, height: 0))
        UIColor.redColor().set()
        imagePath.stroke()
        imagePath.addClip()
//        image?.drawAtPoint(CGPoint(x: 20, y: 230))
        image?.drawInRect(CGRect(origin: CGPoint(x: 20, y: 230), size: CGSize(width: 100, height: 100)))

     
    }


}
