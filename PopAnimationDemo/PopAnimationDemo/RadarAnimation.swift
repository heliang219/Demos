//
//  RadarAnimation.swift
//  PopAnimationDemo
//
//  Created by pfl on 16/2/15.
//  Copyright © 2016年 pfl. All rights reserved.
//

import UIKit

class RadarAnimation: UIView {


    private(set) var displayLink: CADisplayLink!
    private var radius: CGFloat = 0
    private(set) var radarCircles: NSMutableArray = []

    var numberOfCircle: Int = 5*8
    
    var level: CGFloat = 0 {
        didSet {
            radius += level
            updateMeters()
        }
    }
    
    
    deinit {
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func didMoveToSuperview() {
         super.didMoveToSuperview()
        
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
    }
    
    var callBackRadar:((radar: RadarAnimation)->())? {
        didSet {
            displayLink = CADisplayLink(target: self, selector: "radarCallBack")
//            displayLink = NSTimer(timeInterval: 0.01, target: self, selector: "radarCallBack", userInfo: nil, repeats: true)
            displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
//            NSRunLoop.currentRunLoop().addTimer(displayLink, forMode: NSRunLoopCommonModes)
            
            for var i = 0; i < numberOfCircle; i++ {
                let radarCirclePath = CAShapeLayer()
                radarCirclePath.lineCap = kCALineCapButt
                radarCirclePath.lineJoin = kCALineJoinRound
                radarCirclePath.fillColor = UIColor.clearColor().CGColor
                radarCirclePath.lineWidth = 1.4
                radarCirclePath.shadowColor = UIColor.greenColor().CGColor
                radarCirclePath.shadowOffset = CGSize(width: 10, height: 10)
                radarCirclePath.strokeColor = UIColor.orangeColor().CGColor
                radarCirclePath.shadowRadius = 10
                layer.addSublayer(radarCirclePath)
                radarCircles.addObject(radarCirclePath)
            }
            
//            displayLink.fire()

        }
    }
    
    
    
    func setup() {
        
    }
    
    func radarCallBack() {
        guard let callBackRadar = callBackRadar else{return}
        callBackRadar(radar: self)
    }
    
    
    func updateMeters() {
        
//        layer.sublayers?.removeAll()
        for var i = 0; i < numberOfCircle; i++ {
            let circlePath = UIBezierPath()
//            let radarCirclePath = CAShapeLayer()
//            radarCirclePath.lineCap = kCALineCapButt
//            radarCirclePath.lineJoin = kCALineJoinRound
//            radarCirclePath.fillColor = UIColor.clearColor().CGColor
//            radarCirclePath.lineWidth = 1.4
//            radarCirclePath.strokeColor = UIColor.orangeColor().CGColor
//            layer.addSublayer(radarCirclePath)
            
//            if i == 0 {
//                circlePath.moveToPoint(center)
//            }
//            else {
//            }
            
            let radarCirclePath = radarCircles[i] as! CAShapeLayer
            radarCirclePath.path = nil
            circlePath.addArcWithCenter(center, radius: radius - CGFloat(i) * level, startAngle: 0, endAngle: 2 * CGFloat(M_PI), clockwise: false)
            radarCirclePath.path = circlePath.CGPath
            
            if radius > 90 {
                radius = 0
            }
        
        }
        
        
        
    }
    
    
}








