//
//  PasswordView.swift
//  PasswordDemo
//
//  Created by pfl on 15/6/12.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

import UIKit

let gapY : CGFloat = 180
let gapItem: CGFloat = 20
let width: CGFloat = (UIScreen.mainScreen().bounds.width - 2 * gapItem - 2 * 40)/3
let height: CGFloat = (UIScreen.mainScreen().bounds.width - 2 * 20 - 2 * 40)/3
let gapx : CGFloat = (UIScreen.mainScreen().bounds.width - 3 * width - 2 * gapItem)/2
let status:String = "status"

protocol verifyPwdProtocol
{
    func callbackpwd(status:Bool)
}

class PasswordView: UIView {

    var pwdBtnArr = [UIView]()
    var tempwdBtnArr = [UIView]()
    var currentPoint = CGPointMake(0, 0)
    var currentPointArr = [CGRect]()
    var delegate: verifyPwdProtocol?
    var pwdCount = 1
    let userDefaults = NSUserDefaults.standardUserDefaults()
    var errorcodeCount = 0
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        loadUI()
        
        if !userDefaults.boolForKey("isFirst")
        {
            UIAlertView(title: "提示", message: "请设置密码", delegate: self, cancelButtonTitle: "好的!").show()
        }
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
            btn.setImage(UIImage(named: "8"), forState: UIControlState.Selected)
            btn.backgroundColor = UIColor.whiteColor()
            btn.userInteractionEnabled = false
            btn.layer.cornerRadius = width * 0.5
            btn.layer.borderColor = UIColor.brownColor().CGColor
            btn.layer.borderWidth = 1
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
                btn.setImage(UIImage(named: "8"), forState: UIControlState.Selected)
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
       
        if pwdBtnArr.count == 0{return}
        
        
       if !userDefaults.boolForKey("isFirst")
       {
            if !userDefaults.boolForKey(status)
            {
                if pwdBtnArr.count < 3
                {
                    UIAlertView(title: "提示", message: "密码长度不能少于3位,请重新输入!", delegate: self, cancelButtonTitle: "好的").show()
                    clearPath()
                    return
                }
                
                UIAlertView(title: "提示", message: "请再输入一次,设置密码", delegate: self, cancelButtonTitle: "好的").show()
                
                var pwd: String = ""
                for btn in pwdBtnArr as! [UIButton]
                {
                    pwd += "\(btn.tag)"
                }
                
                if pwdBtnArr.count < 3
                {
                    UIAlertView(title: "提示", message: "密码长度不能少于3位,请重新输入!", delegate: self, cancelButtonTitle: "好的").show()
                }
                else
                {
                    userDefaults.setObject(pwd, forKey: "pwd")
                    userDefaults.setBool(true, forKey: status)
                    userDefaults.synchronize()
                }
               
            }
            else
            {
                var pwd: String = ""
                for btn in pwdBtnArr as! [UIButton]
                {
                    pwd += "\(btn.tag)"
                }
                
                if (userDefaults.objectForKey("pwd") as! String) == pwd
                {
                    userDefaults.setObject(pwd, forKey: "pwd")
                    userDefaults.setBool(true, forKey: status)
                    userDefaults.setBool(true, forKey: "isFirst")
                    errorcodeCount = 0
                    delegate?.callbackpwd(true)
                    UIAlertView(title: "提示", message: "设置密码成功", delegate: self, cancelButtonTitle: "好的").show()
                }
                else
                {
                    userDefaults.setObject("", forKey: "pwd")
                    userDefaults.setBool(false, forKey: status)
                    UIAlertView(title: "提示", message: "两次输入不一致,请重新设置密码", delegate: self, cancelButtonTitle: "好的").show()
                }
                
                userDefaults.synchronize()
            }

       }
       else
       {
        var pwd: String = ""
        for btn in pwdBtnArr as! [UIButton]
        {
            pwd += "\(btn.tag)"
        }
        
        if (userDefaults.objectForKey("pwd") as! String) == pwd
        {
            
            delegate?.callbackpwd(true)
            
        }
        else
        {
           if errorcodeCount < 4
           {
            UIAlertView(title: "提示", message: "密码不正确,还可以输入\(4 - errorcodeCount)次!", delegate: self, cancelButtonTitle: "好的").show()
            }
            if errorcodeCount++ >= 4
            {
                userDefaults.setBool(false, forKey: "status")
                userDefaults.setObject("", forKey: "pwd")
                userDefaults.setBool(false, forKey: "isFirst")
                userDefaults.synchronize()
                UIAlertView(title: "提示", message: "请重新设置密码", delegate: self, cancelButtonTitle: "好的").show()
            }
           
        }
        
        
        }
        
       
        clearPath()
        
        
        
    }
    
    func clearPath()
    {
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








