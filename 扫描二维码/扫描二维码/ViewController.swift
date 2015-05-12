//
//  ViewController.swift
//  扫描二维码
//
//  Created by pfl on 15/5/12.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

import UIKit
import AVFoundation

let square = [CGPoint(x: 20,y: 100),//0
            CGPoint(x: 20,y: 100),//1
            CGPoint(x: 20,y: 140),//2
            CGPoint(x: 20,y: 340),//3
            CGPoint(x: 20,y: 378),//4
            CGPoint(x: 60,y: 380),//5
            CGPoint(x: 260,y: 378),//6
            CGPoint(x: 298,y: 340),//7
            CGPoint(x: 260,y: 340),//8
            CGPoint(x: 298,y: 100),//9
            CGPoint(x: 260,y: 100),//10
            CGPoint(x: 260,y: 100),//11
]

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate {

    var captureSession: AVCaptureSession?
    var videoPreviewLayer: CaptureVideoLayer?
    var qrCodeFrameView: UIView?
    var messageLabel: UILabel?
    var scanLabel: UILabel? = UILabel()
    
    var coverView: UIView?{
        didSet
        {
            coverView?.backgroundColor = UIColor.blackColor()
            coverView?.layer.opacity = 0.6
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coverView = UIView(frame: self.view.bounds)
        view.addSubview(coverView!)
        
        messageLabel = UILabel(frame: CGRectMake(20, self.view.bounds.height - 80, 280, 40))
        messageLabel?.font = UIFont.boldSystemFontOfSize(15)
        messageLabel?.textAlignment = NSTextAlignment.Center
        messageLabel?.textColor = UIColor.greenColor()
        messageLabel?.backgroundColor = UIColor.grayColor()
        view.addSubview(messageLabel!)
        
        scanLabel?.frame = CGRectMake(0, 0, 280, 1)
        scanLabel?.backgroundColor = UIColor.greenColor()
        scanLabel?.layer.shadowColor = UIColor.greenColor().CGColor
        scanLabel?.layer.shadowOpacity = 1.0
        scanLabel?.layer.shadowOffset = CGSizeMake(0, -5)
        view.addSubview(scanLabel!)
        
        
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error: NSError?
        var captureInput: AnyObject? = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: &error)
        if error != nil
        {
            println(error?.localizedDescription)
            return
        }
        
        captureSession = AVCaptureSession()
        captureSession?.addInput(captureInput! as! AVCaptureInput)
        
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code]
        
        videoPreviewLayer = CaptureVideoLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.bounds//CGRectMake(0, 0, 280, 280)
        videoPreviewLayer?.backgroundColor = UIColor.clearColor().CGColor
        view.layer.addSublayer(videoPreviewLayer!)
        println(videoPreviewLayer!.copy() as! CALayer)
        captureSession?.startRunning()
        
        
        qrCodeFrameView = UIView(frame: CGRectMake(20, 100, 280, 280))
        qrCodeFrameView?.layer.borderColor = UIColor.clearColor().CGColor
        qrCodeFrameView?.layer.borderWidth = 2.0
//        videoPreviewLayer?.frame = CGRectMake(0, 0, 280, 280)
//        qrCodeFrameView?.layer.addSublayer(videoPreviewLayer!)
        qrCodeFrameView?.addSubview(scanLabel!)
        view.addSubview(qrCodeFrameView!)
        println(videoPreviewLayer!)
    
        
        view.insertSubview(coverView!, belowSubview: qrCodeFrameView!)
        
        
    }

    override func viewWillAppear(animated: Bool) {
        animationView(scanLabel!)
        configureSquare()
    }
  
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        if metadataObjects == nil || metadataObjects.count == 0
        {
//            qrCodeFrameView?.frame = CGRectZero
            messageLabel?.text = "NO QR code is detected"
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObjectTypeQRCode
        {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
//            qrCodeFrameView?.frame = barCodeObject.bounds
            
            if metadataObj.stringValue != nil
            {
                messageLabel?.text = metadataObj.stringValue
            }
            
            captureSession?.stopRunning()
            
            UIAlertView(title: "提示", message: messageLabel?.text, delegate: self, cancelButtonTitle: "确定").show()
            
        }
        
        
        
        
    }
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        captureSession?.startRunning()
        
    }
    
    
    func animationView(lable: UILabel)
    {
        
        let animateSpeed = 5 / 280.0
        var duration = NSTimeInterval(animateSpeed * 280)
        
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            
            lable.frame.origin.y = lable.superview!.frame.size.height-1
            
            }, completion: { _ in
            lable.frame.origin.y -= lable.superview!.frame.size.height-1
            self.animationView(lable)
        })
        
        
    }
    
    func configureSquare()
    {
        var path = UIBezierPath()

        for index in 0..<square.count
        {
            var w: CGFloat = 40
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










