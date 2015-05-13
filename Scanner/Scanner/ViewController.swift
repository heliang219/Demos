//
//  ViewController.swift
//  Scanner
//
//  Created by pfl on 15/5/13.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

import UIKit
import AVFoundation

let square = [CGPoint(x: kLineMinX,y: kLineMinY),//0
    CGPoint(x: kLineMinX,y: kLineMinY),//1
    CGPoint(x: kLineMinX,y: 224),//2
    CGPoint(x: kLineMinX,y: 364),//3
    CGPoint(x: kLineMinX,y: 382),//4
    CGPoint(x: 100,y: 382),//5
    CGPoint(x: 220 + kSquareWidth,y: 382),//6
    CGPoint(x: 258,y: 344  + kSquareWidth),//7
    CGPoint(x: 220,y: 344),//8
    CGPoint(x: 258,y: kLineMinY),//9
    CGPoint(x: 220 + kSquareWidth,y: kLineMinY),//10
    CGPoint(x: 220,y: kLineMinY),//11
]
let kReaderWidth: CGFloat = 200
let kReaderHeight: CGFloat = 200
let kAlpha: CGFloat = 0.7
let kSquareWidth: CGFloat = 20
let kDeviceWidth: CGFloat = UIScreen.mainScreen().bounds.width
let kDeviceHeigth: CGFloat = UIScreen.mainScreen().bounds.height
let kLineMinX: CGFloat = 60
let kLineMinY: CGFloat = 184


class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate {
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: CaptureVideoLayer?
    var qrCodeFrameView: UIView?
    var messageLabel: UILabel?
    var scanLabel: UILabel? = UILabel()
    var isStopScan: Bool? = false
    var isAnimation: Bool? = false
    
    var coverView: UIView?{
        didSet
        {
            coverView?.backgroundColor = UIColor.blackColor()
            coverView?.layer.opacity = 0.6
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        scanLabel?.frame = CGRectMake(0, 0, kReaderWidth, 1)
        scanLabel?.backgroundColor = UIColor.greenColor()
        scanLabel?.layer.shadowColor = UIColor.greenColor().CGColor
        scanLabel?.layer.shadowOpacity = 1.0
        scanLabel?.layer.shadowRadius = 5.0
        scanLabel?.layer.shadowOffset = CGSizeMake(0, -5)
        
    
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error: NSError?
        var captureInput: AnyObject? = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: &error)
        if error != nil
        {
            println(error?.localizedDescription)
            return
        }
        
        captureSession = AVCaptureSession()
        if captureSession!.canSetSessionPreset(AVCaptureSessionPreset1920x1080)
        {
            captureSession?.sessionPreset = AVCaptureSessionPreset1920x1080
        }else if captureSession!.canSetSessionPreset(AVCaptureSessionPreset640x480)
        {
            captureSession?.sessionPreset = AVCaptureSessionPreset640x480
        }
        
        if captureSession!.canAddInput(captureInput as! AVCaptureInput)
        {
            captureSession?.addInput(captureInput! as! AVCaptureInput)
        }
        
        
        let captureMetadataOutput = AVCaptureMetadataOutput()
        
        if captureSession!.canAddOutput(captureMetadataOutput)
        {
            captureSession?.addOutput(captureMetadataOutput)
        }
        
        
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code]
        
        
        videoPreviewLayer = CaptureVideoLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.bounds
        videoPreviewLayer?.backgroundColor = UIColor.whiteColor().CGColor
        view.layer.addSublayer(videoPreviewLayer!)
        captureSession?.startRunning()
        
        
        qrCodeFrameView = UIView(frame: CGRectMake(kLineMinX, kLineMinY, kReaderWidth, kReaderWidth))
        qrCodeFrameView?.layer.borderColor = UIColor.whiteColor().CGColor
        qrCodeFrameView?.layer.borderWidth = 2.0
        qrCodeFrameView?.addSubview(scanLabel!)
        view.addSubview(qrCodeFrameView!)
        
        captureMetadataOutput.rectOfInterest = CGRectMake(kLineMinY / kDeviceHeigth, kLineMinX / kDeviceWidth, kReaderWidth/kDeviceHeigth, kReaderWidth/kDeviceWidth)
        
        
        
        loadUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if isStopScan == false
        {
            animationView(scanLabel!)
        }
        
        
        configureSquare()
    }
    
    
    func loadUI()
    {
        
        var topView = UIView(frame: CGRectMake(0, 0, kDeviceWidth, kLineMinY))
        topView.backgroundColor = UIColor.blackColor()
        topView.alpha = kAlpha
        view.addSubview(topView)
        
        var leftView = UIView(frame: CGRectMake(0, CGRectGetMaxY(topView.frame), (kDeviceWidth - kReaderWidth)/2, kReaderWidth))
        leftView.backgroundColor = UIColor.blackColor()
        leftView.alpha = kAlpha
        view.addSubview(leftView)
        
        var rightView = UIView(frame: CGRectMake(kDeviceWidth - (kDeviceWidth - kReaderWidth)/2, CGRectGetMaxY(topView.frame), (kDeviceWidth - kReaderWidth)/2, kReaderWidth))
        rightView.backgroundColor = UIColor.blackColor()
        rightView.alpha = kAlpha
        view.addSubview(rightView)
        
        
        var bottomView = UIView(frame: CGRectMake(0, CGRectGetMaxY(leftView.frame), kDeviceWidth, (kDeviceHeigth - kReaderWidth)/2))
        bottomView.backgroundColor = UIColor.blackColor()
        bottomView.alpha = kAlpha
        view.addSubview(bottomView)
        
        var tips = UILabel(frame: CGRectMake(0, bottomView.frame.origin.y + 30, kDeviceWidth, 40))
        tips.text = "请将二维码/条形码放入扫描框内,即可自行扫描"
        tips.textColor = UIColor.whiteColor()
        tips.font = UIFont.boldSystemFontOfSize(12)
        tips.textAlignment = .Center
        view.addSubview(tips)
        
        messageLabel = UILabel(frame: CGRectMake(0, CGRectGetMaxY(tips.frame) + 10,kDeviceWidth, 40))
        messageLabel?.font = UIFont.boldSystemFontOfSize(12)
        messageLabel?.text = "我的二维码"
        messageLabel?.textAlignment = NSTextAlignment.Center
        messageLabel?.textColor = UIColor.greenColor()
        view.addSubview(messageLabel!)
        
        
        var image = UIImage(named: "cover")
        var imageView = UIImageView(image: image!)
        imageView.frame = CGRectMake(0, 0, image!.size.width * 0.5, image!.size.height * 0.5)
//        view.addSubview(imageView)
        
        
        
    }
    
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        if metadataObjects == nil || metadataObjects.count == 0
        {
     
            messageLabel?.text = "NO QR code is detected"
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode
        {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
       
            
            if metadataObj.stringValue != nil
            {
                messageLabel?.text = metadataObj.stringValue
                
                if metadataObj.stringValue.hasPrefix("http")
                {
                    UIApplication.sharedApplication().openURL(NSURL(string: metadataObj.stringValue!)!)
                }
                
            }
            stopRuning()
          
            
            UIAlertView(title: "提示", message: messageLabel?.text, delegate: self, cancelButtonTitle: "确定").show()
            
        }else if metadataObj.type == AVMetadataObjectTypeEAN13Code
        {
            messageLabel?.text = metadataObj.stringValue
         
            UIAlertView(title: "提示", message: metadataObj.stringValue, delegate: self, cancelButtonTitle: "确定").show()
            
            stopRuning()
        }
        
        
        
        
    }
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        captureSession?.startRunning()
        
        isStopScan = false
        
        isAnimation = isAnimation ?? false
        
        if isAnimation == false
        {
//            animationView(scanLabel!)
//            isAnimation = true
        }
        
    }
    
    func stopRuning()
    {
        captureSession!.stopRunning()
        isStopScan = true
        
    }
    
    
    func animationView(lable: UILabel)
    {
        
        
        let animateSpeed = 5 / kReaderHeight
        var duration =  NSTimeInterval(animateSpeed * kReaderHeight)
        
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            
            lable.frame.origin.y = CGRectGetHeight(lable.superview!.frame) - 1
            
            println(CGRectGetHeight(lable.superview!.frame))
            
            }, completion: { _ in
                
                lable.frame.origin.y = 0
//               
//                if self.isStopScan == false
//                {
//                    self.isAnimation = true
                    self.animationView(lable)
//                }
        
        })
        
        
    }
    
    func configureSquare()
    {
        var path = UIBezierPath()
        
        for index in 0..<square.count
        {
            var w: CGFloat = 20
            var h: CGFloat = 2
            var cnt = 0
            var point: CGPoint = square[index]
            if index % 3 == 0
            {
                
                path.moveToPoint(point)
            }
            else if index % 3 == 1
            {
                path.addLineToPoint(point)
            }else
            {
                continue
            }
            
            
            
            
            switch (index)
            {
            case 0:
                
                var label = UILabel(frame: CGRectMake(0, 0, w, h))
                label.frame.origin = point
                label.backgroundColor = UIColor.greenColor()
                view.addSubview(label)
                
            case 1:
                
                var label = UILabel(frame: CGRectMake(0, 0, h, w))
                label.frame.origin = point
                label.backgroundColor = UIColor.greenColor()
                view.addSubview(label)
                
            case 3:
                
                var label = UILabel(frame: CGRectMake(0, 0, h, w))
                label.frame.origin = point
                label.backgroundColor = UIColor.greenColor()
                view.addSubview(label)
                
            case 4:
                
                var label = UILabel(frame: CGRectMake(0, 0, w, h))
                label.frame.origin = point
                label.backgroundColor = UIColor.greenColor()
                view.addSubview(label)
                
            case 6:
                
                var label = UILabel(frame: CGRectMake(0, 0, w, h))
                label.frame.origin = point
                label.backgroundColor = UIColor.greenColor()
                view.addSubview(label)
                
            case 7:
                
                var label = UILabel(frame: CGRectMake(0, 0, h, w))
                label.frame.origin = point
                label.backgroundColor = UIColor.greenColor()
                view.addSubview(label)
                
            case 9:
                
                var label = UILabel(frame: CGRectMake(0, 0, h, w))
                label.frame.origin = point
                label.backgroundColor = UIColor.greenColor()
                view.addSubview(label)
                
            case 10:
                
                var label = UILabel(frame: CGRectMake(0, 0, w, h))
                label.frame.origin = point
                label.backgroundColor = UIColor.greenColor()
                view.addSubview(label)
                
            default: break
                
            }
            
            
            
        }
        
        
        
        
        
    }
    
    
    
    
    
}












