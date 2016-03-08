//
//  SawAnimationView.swift
//  PopAnimationDemo
//
//  Created by pfl on 16/2/16.
//  Copyright © 2016年 pfl. All rights reserved.
//

import UIKit

class SawAnimationView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = UIColor.whiteColor()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func setup() {
        
        let sawAnimation = CAReplicatorLayer()
        sawAnimation.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        let transform = CATransform3DMakeTranslation(10, 0, 0)
        sawAnimation.instanceTransform = transform
        sawAnimation.instanceCount = 27
        sawAnimation.instanceDelay = 0.33
        layer.addSublayer(sawAnimation)

        
        sawAnimation.instanceColor = UIColor.orangeColor().CGColor
        
        let bar = CALayer()
        bar.bounds = CGRect(x: 0, y: 0, width: 6, height: 40)
        bar.position = CGPoint(x: 30, y: 54)
        bar.cornerRadius = 2
        bar.backgroundColor = UIColor.redColor().CGColor
        sawAnimation.addSublayer(bar)
        sawAnimation.masksToBounds = true

        
        
        let baseA = CABasicAnimation(keyPath: "position.y")
        baseA.repeatCount = Float.infinity
        baseA.duration = 0.4
        baseA.toValue = bar.position.y-10
        baseA.autoreverses = true
        bar.addAnimation(baseA, forKey: "")
        

        
    }
    
    
    
    
    
}
