//
//  PasswordView.swift
//  PasswordDemo
//
//  Created by pfl on 15/6/12.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

import UIKit

let gapY : CGFloat = 100
let gapItem: CGFloat = 20
let width: CGFloat = (UIScreen.mainScreen().bounds.width - 2 * 20 - 2 * 40)/3
let height: CGFloat = (UIScreen.mainScreen().bounds.width - 2 * 20 - 2 * 40)/3
let gapx : CGFloat = (UIScreen.mainScreen().bounds.width - 3 * width - 2 * gapItem)/2
let status:String = "status"

protocol verifyPwdProtocol
{
    func callbackpwd(btnArr:NSArray)
}

class PasswordView: UIView {

    var pwdBtnArr = [UIView]()
    var tempwdBtnArr = [UIView]()
    var currentPoint = CGPointMake(0, 0)
    var currentPointArr = [CGRect]()
    var delegate: verifyPwdProtocol?
    var pwdCount = 1
    let userDefaults = NSUserDefaults.standardUserDefaults()
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        loadUI()
        
        userDefaults.setBool(false, forKey: status)
        userDefaults.synchronize()
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadUI()
    {
        for index in 0..<9
        {
            let row = index / 3
            let column = index % 3
            var btn = UIButton(frame: CGRectMake(gapx + (gapItem + width) * CGFloat(column), gapY + (gapItem + height) * CGFloat(row), width, height))
            btn.backgroundColor = UIColor.brownColor()
            btn.userInteractionEnabled = false
            btn.layer.cornerRadius = width * 0.5
            btn.tag = index
            btn.layer.masksToBounds = true
            self.addSubview(btn)
         
        }
        
        
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        var point = (touches.first as! UITouch).locationInView(self)
       currentPoint = CGPointZero
        var currentBtn: UIButton?
        for btn in subviews as! [UIButton]
        {
            if CGRectContainsPoint(btn.frame, point)
            {
                currentBtn = btn
                break
            }
        }
        
        if let btn = currentBtn
        {
            if btn.selected == false
            {
                btn.selected = true
                btn.highlighted = true
                pwdBtnArr.append(btn)
            }
            else
            {
                 currentPoint = point
            }
           
        }else
        {
            currentPoint = point
        }
        
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        touchesBegan(touches, withEvent: event)
    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
       
       
        
        if !userDefaults.boolForKey(status)
        {
            
            
            
            UIAlertView(title: "提示", message: "没有设置密码,请再输入一次,设置密码", delegate: self, cancelButtonTitle: "好的!").show()

        }
        else
        {
             delegate?.callbackpwd(pwdBtnArr)
        }
    
       
        
        let btnArr = NSArray(array: pwdBtnArr)
        for btn in btnArr as! [UIButton]
        {
            btn.selected = false
        }
        pwdBtnArr.removeAll(keepCapacity: true)
         setNeedsDisplay()
        
        
    }
    
    
   
    override func drawRect(rect: CGRect) {
        
        if pwdBtnArr.count == 0{return}
        var path = UIBezierPath()
        path.lineWidth = 5.0
        path.lineJoinStyle = kCGLineJoinRound
        path.lineCapStyle = kCGLineCapRound
        UIColor.brownColor().set()
        
        for index in 0..<pwdBtnArr.count
        {
            let btn = pwdBtnArr[index] as! UIButton
            if index == 0
            {
                path.moveToPoint(btn.center)
            }
            else
            {
                path.addLineToPoint(btn.center)
            }
           
        }
        
        if !CGPointEqualToPoint(self.currentPoint, CGPointZero)
        {
            path.addLineToPoint(self.currentPoint)
        }
        
        path.stroke()
        
        
        
        
    }
    

}








