//
//  ViewController.swift
//  AnimationsDemo
//
//  Created by pfl on 15/11/20.
//  Copyright © 2015年 pfl. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseView = BaseView(frame: view.bounds)
        view.addSubview(baseView)
        
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRectMake(20, 20, 200, 200)
        shapeLayer.strokeColor = UIColor.redColor().CGColor
        shapeLayer.fillColor = UIColor.orangeColor().CGColor
        let path = UIBezierPath(roundedRect: CGRectMake(0, 0, 200, 200), cornerRadius: 10)
        shapeLayer.path = path.CGPath
        shapeLayer.contentsScale = UIScreen.mainScreen().scale
        view.layer.addSublayer(shapeLayer)
        
        let shapeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        shapeAnimation.fromValue = NSNumber(float: 0)
        shapeAnimation.toValue = NSNumber(float: 1)
        shapeAnimation.duration = 2
        shapeAnimation.repeatCount = MAXFLOAT
        shapeLayer.addAnimation(shapeAnimation, forKey: nil)
        
        
        
    }

   
    
    


}

