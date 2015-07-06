//
//  KeyboardViewController.swift
//  KeyBoard
//
//  Created by pfl on 15/7/2.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    var nextKeyboardButton: KeyButton!
    
    let rows: [AnyObject] = [["1",""],["2","ABC"],["3","EDF"],["4","GHI"],["5","JKL"],["6","MNO"],["7","PORS"],["8","TUV"],["9","WXYZ"],[".",""],["0",""],["",""]]
    
    let gapH = UIScreen.mainScreen().bounds.width/3.0
    let gapV = CGFloat(216)/4.0
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        // Perform custom UI setup here
        self.nextKeyboardButton = KeyButton.buttonWithType(.System) as! KeyButton
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
    
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        
//        self.view.addSubview(self.nextKeyboardButton)
        
        println(self.view.bounds)
        
        for index in 0..<3
        {
            let sepH = UIView(frame: CGRectMake(0,gapV * (1 + CGFloat(index)), UIScreen.mainScreen().bounds.width, 1))
            sepH.backgroundColor = UIColor.grayColor()
            self.view.addSubview(sepH)
        }
        
        for index in 0..<2
        {
            let sepV = UIView(frame: CGRectMake(gapH * (1 + CGFloat(index)),0, 1, 216))
            sepV.backgroundColor = UIColor.grayColor()
            self.view.addSubview(sepV)
        }
        
        var indexs: Int = 0
        for row in rows as! [[AnyObject]]
        {
            let r = indexs / 3
            let c = indexs % 3
            let keyBtn = KeyButton(frame: CGRectMake(CGFloat(c) * gapH, CGFloat(r) * gapV, gapH, gapV))
            self.view.addSubview(keyBtn)
            keyBtn.tag = indexs+1;
            keyBtn.addTarget(self, action:Selector("insertText:"), forControlEvents: UIControlEvents.TouchUpInside)
            
            if indexs == 9 || indexs == 10
            {
                keyBtn.setTitle((row[0] as! String), forState: UIControlState.Normal)
            }
            else if indexs == 11
            {
                keyBtn.setImage(UIImage(named: "delete"), forState: UIControlState.Normal)
                let longPress = UILongPressGestureRecognizer(target: self, action: Selector("longPress:"))
                longPress.minimumPressDuration = 1
                keyBtn.addGestureRecognizer(longPress)
            }
            else
            {
                keyBtn.titleLabel?.numberOfLines = 2
                let attributeStr = NSMutableAttributedString(string: (row[0] as! String) + "\n" + (row[1] as! String))
                attributeStr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12), range: NSMakeRange(1, attributeStr.length-1))
                attributeStr.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(24), range: NSMakeRange(0, 1))
                keyBtn.setAttributedTitle(attributeStr, forState: UIControlState.Normal)
               
            }
            indexs++
        }
        
        
        
        let keyBoardHeight: CGFloat = 100
        let constraint =  NSLayoutConstraint(item: self.view,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 0.0,
            constant: keyBoardHeight)
        self.view.addConstraint(constraint)
    
        
    }
    
    func insertText(btn: UIButton)
    {
        var proxy = self.textDocumentProxy as! UITextDocumentProxy
        
        if btn.tag != 12
        {
            if btn.tag == 10
            {
                proxy.insertText(".")
               
            }
            else if btn.tag == 11
            {
                proxy.insertText("0")
               
            }
            else
            {
               proxy.insertText("\(btn.tag)")
            }
            
        }
        else
        {
            
            proxy.deleteBackward()
        }
        
    }
    
    
    func longPress(longBtn: UILongPressGestureRecognizer)
    {
        if longBtn.state != UIGestureRecognizerState.Ended || longBtn.state != UIGestureRecognizerState.Cancelled
        {
            var proxy = self.textDocumentProxy as! UITextDocumentProxy
            proxy.deleteBackward()
            self.longPress(longBtn)
        }
        
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        var proxy = self.textDocumentProxy as! UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
   
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }

}