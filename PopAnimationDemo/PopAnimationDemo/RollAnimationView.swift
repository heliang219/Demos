
//
//  RollAnimationView.swift
//  PopAnimationDemo
//
//  Created by pfl on 16/2/16.
//  Copyright © 2016年 pfl. All rights reserved.
//

import UIKit

class RollAnimationView: UIView {

    var point: CGPoint = CGPoint.zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
        setup()
    }
    
    
    func setup()->Void {
        let playButton = UIButton(type: .Custom)
        playButton.setImage(UIImage(named: ""), forState: .Normal)
        playButton.setTitle("", forState: .Normal)
        playButton.frame = CGRectMake(0, 150, 40, 40)
        playButton.layer.cornerRadius = playButton.bounds.width/2
        playButton.backgroundColor = UIColor.redColor()
        playButton.addTarget(self, action:Selector("play:"), forControlEvents: .TouchUpInside)
        self.addSubview(playButton)
        point = playButton.center

    }
    
    func play(sender: UIButton) {
        sender.userInteractionEnabled = false
        self.transferView(sender)
        
    }

    
    func transferView(sender: UIButton) {
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.toValue = NSValue(CGPoint: CGPointMake(0.2, 0.2))
        sender.layer.pop_addAnimation(scaleAnim, forKey: "") 
        
        
        let scaleAnimtion = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnimtion.fromValue = NSValue(CGPoint: CGPointMake(1, 1))
        scaleAnimtion.toValue = NSValue(CGPoint: CGPointMake(0.2, 0.2))
        scaleAnimtion.duration = 5
        scaleAnimtion.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

//        sender.layer.pop_addAnimation(scaleAnimtion, forKey: "scalexy")

        
        let traslationAnimtion = POPBasicAnimation(propertyNamed: kPOPLayerPositionX)
        traslationAnimtion.fromValue = point.x
        traslationAnimtion.toValue = self.bounds.width-point.x*2
        traslationAnimtion.duration = 5
        traslationAnimtion.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        sender.layer.pop_addAnimation(traslationAnimtion, forKey: "positionX")


        
        
        scaleAnim.completionBlock = { (anim, finished)->() in
            if finished {
        
                CATransaction.begin()
                CATransaction.setDisableActions(true)
                let progressLine = UIBezierPath()
                progressLine.moveToPoint(CGPoint.zero)
                progressLine.addLineToPoint(CGPointMake(self.bounds.width - self.point.x*2, 0))
                progressLine.lineCapStyle = CGLineCap.Round
                
                let progressLayer = CAShapeLayer()
                progressLayer.strokeColor = UIColor.redColor().CGColor
                progressLayer.lineWidth = sender.bounds.width*0.2
                progressLayer.lineCap = kCALineCapRound
                progressLayer.frame.origin = self.point
                progressLayer.path = progressLine.CGPath
                self.layer.addSublayer(progressLayer)
                CATransaction.commit()
                
                UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
                let progressBoundsAnim = POPBasicAnimation(propertyNamed: kPOPShapeLayerStrokeEnd)
                progressBoundsAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                progressBoundsAnim.fromValue = NSNumber(float: 0.0)
                progressBoundsAnim.toValue = NSNumber(float: 1)
                progressBoundsAnim.duration = 5.0
                
                progressBoundsAnim.completionBlock = { (anim, finished)->() in
                    if finished {
                        UIGraphicsEndImageContext()
                        sender.userInteractionEnabled = true
                        sender.alpha = 0.0
                        let scaleAnim2 = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
                        scaleAnim2.toValue = NSValue(CGPoint: CGPoint(x:1.0, y:1.0))
                        sender.layer.pop_addAnimation(scaleAnim2, forKey: "")
                        progressLayer.removeAllAnimations()
                        progressLayer.removeFromSuperlayer()
                        
                        UIView.animateWithDuration(1, animations: { () -> Void in
                            sender.alpha = 1
                        })
                        
                        
                    }
                }
                progressLayer.pop_addAnimation(progressBoundsAnim, forKey: nil)
            }
        }

        
        let tb:Int? = 1
        let b = tb.map { (a: Int) -> Int? in
            if a % 2 == 0 {
                return a
            }
            else {
                return nil
            }
        }
        
        if let b = b {
            if let a = b {
                print("not nil b :",a)
            }
            else {
                print("nil:")
            }
        }
        else {
            print("nil")
        }
        
    }

    
}
