//
//  ViewController.swift
//  PopAnimationDemo
//
//  Created by pfl on 16/2/8.
//  Copyright © 2016年 pfl. All rights reserved.
//

import UIKit
//import Waver

class ViewController: UIViewController {

    var waver: PFLWaver!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let playButton = UIButton(type: .Custom)
        playButton.setImage(UIImage(named: ""), forState: .Normal)
        playButton.setTitle("", forState: .Normal)
        playButton.frame = CGRectMake(0, 150, 40, 40)
        playButton.layer.cornerRadius = playButton.bounds.width/2
        playButton.backgroundColor = UIColor.redColor()
        playButton.addTarget(self, action:Selector("play:"), forControlEvents: .TouchUpInside)
        self.view .addSubview(playButton)
        
        
        
        addRadar()
        
        
        waver = PFLWaver(frame: CGRect(x: 10, y: 250, width: view.bounds.width-20, height: 44))
        waver.waveColor = UIColor.redColor()
        waver.primaryWaveLineWidth = 3
        waver.secondaryWaveLineWidth = 1
        waver.numberOfWaves = 5
        view.addSubview(waver)
        waver.waveCallBack = { waver in
            waver.level = 1.5
        }
        
    }
    
    
    func addRadar() {
       let radar = RadarAnimation(frame: view.bounds)
        view.addSubview(radar)

        radar.callBackRadar = { radar in
            radar.level = 2.5
        }
    }

    
    func play(sender: UIButton) {
        
        self.transferView(sender)
        
    }

    func transferView(sender: UIButton) {
        
        
        
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim.toValue = NSValue(CGPoint: CGPointMake(0.2, 0.2))
        sender.layer.pop_addAnimation(scaleAnim, forKey: "")
        
        scaleAnim.completionBlock = { (anim, finished)->() in
            if finished {
                
                CATransaction.begin()
                CATransaction.setDisableActions(true)
                let progressLine = UIBezierPath()
                progressLine.moveToPoint(CGPointMake(0, 0))
                progressLine.addLineToPoint(CGPointMake(self.view.bounds.width-sender.center.x*2, 0))
                progressLine.lineCapStyle = CGLineCap.Round
                
                let progressLayer = CAShapeLayer()
                progressLayer.strokeColor = UIColor.redColor().CGColor
                progressLayer.lineWidth = sender.bounds.width*0.2
                progressLayer.lineCap = kCALineCapRound
                progressLayer.frame.origin = sender.center
                progressLayer.path = progressLine.CGPath
                self.view.layer.addSublayer(progressLayer)
                CATransaction.commit()
                
                UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, 0.0)
                let progressBoundsAnim = POPBasicAnimation(propertyNamed: kPOPShapeLayerStrokeEnd)
                progressBoundsAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                progressBoundsAnim.fromValue = NSNumber(float: 0.0)
                progressBoundsAnim.toValue = NSNumber(float: 1)
                progressBoundsAnim.duration = 5.0

                progressBoundsAnim.completionBlock = { (anim, finished)->() in
                    if finished {
                        UIGraphicsEndImageContext()
                        let scaleAnim2 = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
                        scaleAnim2.toValue = NSValue(CGPoint: CGPoint(x:1.0, y:1.0))
                        sender.layer.pop_addAnimation(scaleAnim2, forKey: "")
                        progressLayer.removeAllAnimations()
                        progressLayer.removeFromSuperlayer()
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

