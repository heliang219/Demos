//
//  PFLWaver.swift
//  PopAnimationDemo
//
//  Created by pfl on 16/2/15.
//  Copyright © 2016年 pfl. All rights reserved.
//

import UIKit

let kDefaultFrequency: CGFloat = 1.5
let kDefaultAmplitude: CGFloat = 1.0
let kDefaultdleAmplitude: CGFloat = 0.01
let kDefaultNumberOfWaves: Int = 5
let kDefaultPhaseShift: CGFloat = -0.15
let kDefaultDensity: CGFloat = 5.0
let kDefaultPrimaryLineWidth: CGFloat = 3.0
let kDefaultSecondaryLineWidth: CGFloat = 1.0

class PFLWaver: UIView {

    var level: CGFloat = 0 {
        didSet {
            self.phase += self.phaseShift
            self.amplitude = max(level, self.idleAmplitude)
            self.updateMeters()
        }
    }

    @IBInspectable var numberOfWaves: Int = 5
    @IBInspectable var waveColor: UIColor!
    @IBInspectable var primaryWaveLineWidth: CGFloat!
    @IBInspectable var secondaryWaveLineWidth: CGFloat!
    @IBInspectable var idleAmplitude: CGFloat!
    @IBInspectable var frequency: CGFloat!
    @IBInspectable var amplitude: CGFloat = 0
    @IBInspectable var density: CGFloat!
    @IBInspectable var phaseShift: CGFloat!
    
    private(set) var waves: NSMutableArray = []
    
    private var phase: CGFloat  = 0
    
    private(set) var displayLink: CADisplayLink!
    
    private var presented = false
    
    deinit {
        displayLink.invalidate()
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
        presented = true
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        presented = false
    }
    

    func setup() {
        waveColor = UIColor.whiteColor()
        frequency = kDefaultFrequency
        amplitude = kDefaultAmplitude
        idleAmplitude = kDefaultdleAmplitude
        numberOfWaves = kDefaultNumberOfWaves
        phaseShift = kDefaultPhaseShift
        density = kDefaultDensity
        primaryWaveLineWidth = kDefaultPrimaryLineWidth
        secondaryWaveLineWidth = kDefaultSecondaryLineWidth
    }
    
    
    var waveCallBack: ((wave: PFLWaver)->())? {
        didSet {
            displayLink = CADisplayLink(target: self, selector: "callBackWaver")
            let runloop = NSRunLoop.currentRunLoop()
            displayLink.addToRunLoop(runloop, forMode: NSRunLoopCommonModes)

            for var i = 0; i < numberOfWaves; i++ {
                let wave = CAShapeLayer()
                wave.frame = CGRect(x: 0, y: 200, width: self.bounds.width, height: self.bounds.height)
                wave.lineCap = kCALineCapRound
                wave.lineJoin = kCALineJoinRound
                wave.strokeColor = UIColor.clearColor().CGColor
                wave.fillColor = UIColor.clearColor().CGColor
                wave.lineWidth = (i==0 ? self.primaryWaveLineWidth : self.secondaryWaveLineWidth)
                
                let floatI = CGFloat(i)
                let progressIndex = floatI/CGFloat(self.numberOfWaves)
                let progress = 1.0 - progressIndex
                let multiplier = min(1.0, (progress/3.0*2.0) + (1.0/3.0))
                wave.strokeColor = waveColor.colorWithAlphaComponent(multiplier).CGColor
                layer.addSublayer(wave)
                waves.addObject(wave)
            }
 
        }
    }
    
    
    func callBackWaver() {
        guard let waveCallBack = waveCallBack where presented == true else {return}
        waveCallBack(wave: self)
    }
    
    #if false
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextClearRect(context, bounds)
        backgroundColor?.set()
        CGContextFillRect(context, rect)
        
        
        for var i = 0; i < numberOfWaves; i++ {
            let context = UIGraphicsGetCurrentContext()
            CGContextSetLineWidth(context, i == 0 ? primaryWaveLineWidth : secondaryWaveLineWidth)
            let halfHeight: CGFloat = CGRectGetHeight(bounds)/2
            let width: CGFloat = CGRectGetWidth(bounds)
            let mid = width/2
            
            let maxAmplitude = halfHeight - 4.0
            let progress: CGFloat = 1.0 - CGFloat(i) / CGFloat(numberOfWaves)
            let normedAmplitude: CGFloat = (1.5 * progress - 0.5) * amplitude
            let multiplier = min(1.0, (progress / 3.0 * 2.0) + (1.0 / 3.0))
            
            waveColor.colorWithAlphaComponent(multiplier * CGColorGetAlpha(waveColor.CGColor)).set()
            
            for var x: CGFloat = 0; x < width + density; x += density {
                let scaling = -powf(Float(1.0 / mid * (x - mid)), 2.0) + 1.0
                let y: CGFloat = CGFloat(scaling) * maxAmplitude * normedAmplitude * CGFloat(sinf(Float(2.0 * CGFloat(M_PI) * (x / width) * frequency + phase)))
                if x == 0 {
                    CGContextMoveToPoint(context, x, y)
                }
                else {
                    CGContextAddLineToPoint(context, x, y)
                }
            }
            CGContextStrokePath(context)
        }
    }
    
    #endif
    
    
    func updateMeters() {
        
        UIGraphicsBeginImageContext(self.bounds.size)
        let wavelinePath = UIBezierPath()
        
        for var i = 0; i < numberOfWaves; i++ {
            let halfHeight: CGFloat = CGRectGetHeight(bounds)/2
            let width: CGFloat = CGRectGetWidth(bounds)
            let mid = width/2
            
            let maxAmplitude = halfHeight - 4.0
            
            //Thanks to https://github.com/stefanceriu/SCSiriWaveformView
            let progress: CGFloat = 1.0 - CGFloat(i) / CGFloat(numberOfWaves)
            let normedAmplitude: CGFloat = (1.5 * progress - 0.5) * amplitude
            let multiplier = min(1.0, (progress / 3.0 * 2.0) + (1.0 / 3.0))
//            print("progress:\(progress)")
//            print("normedAmplitude:\(normedAmplitude)")
//            print("multiplier:\(multiplier)")

            waveColor.colorWithAlphaComponent(multiplier * CGColorGetAlpha(waveColor.CGColor)).set()
            
            for var x: CGFloat = 0; x < width + density; x += density {
                let scaling = -powf(Float(1.0 / mid * (x - mid)), 2.0) + 1.0
                let y: CGFloat = CGFloat(scaling) * maxAmplitude * normedAmplitude * CGFloat(sinf(Float(2.0 * CGFloat(M_PI) * (x / width) * frequency + phase)))
                if x == 0 {
                    wavelinePath.moveToPoint(CGPoint(x: x, y: y))
                }
                else {
                    wavelinePath.addLineToPoint(CGPoint(x: x, y: y))
                }
                let wave = waves[i] as! CAShapeLayer
                wave.path = wavelinePath.CGPath
                
//                print("scaling:\(scaling)")
//                print("x:\(x)")
//                print("y:\(y)")

            }
        }
        
        UIGraphicsEndImageContext()
        
    }

}
















