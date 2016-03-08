//
//  RefreshAnimationView.swift
//  PopAnimationDemo
//
//  Created by pfl on 16/2/16.
//  Copyright © 2016年 pfl. All rights reserved.
//

import UIKit

class RefreshAnimationView: UIView {


    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    func setup() {
        
        let refreshLayer = CAReplicatorLayer()
        refreshLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        refreshLayer.position = CGPoint(x: bounds.width/2, y: bounds.height/2)
        refreshLayer.instanceCount = 18
        let angle = CGFloat(2*M_PI)/18.0
        refreshLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1.0)
        refreshLayer.cornerRadius = 10
        layer.addSublayer(refreshLayer)
        
        refreshLayer.backgroundColor = UIColor.grayColor().CGColor
        
        
        let rowLayer = CALayer()
        rowLayer.backgroundColor = UIColor.redColor().CGColor
        rowLayer.frame = CGRect(x: refreshLayer.bounds.width/2, y: 20, width: 8, height: 8)
        rowLayer.cornerRadius = rowLayer.bounds.width/2
        refreshLayer.addSublayer(rowLayer)
        
        let baseA = CABasicAnimation(keyPath: "transform.scale")
        baseA.fromValue = 1.0
        baseA.toValue = 0.1
        baseA.duration = 1.5
        baseA.repeatCount = Float.infinity
        baseA.autoreverses = true
        rowLayer.addAnimation(baseA, forKey: nil)
        refreshLayer.instanceDelay = baseA.duration / 18
        rowLayer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01)

        
    }
    
    
    
}









