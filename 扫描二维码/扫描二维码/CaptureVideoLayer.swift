//
//  CaptureVideoLayer.swift
//  扫描二维码
//
//  Created by pfl on 15/5/12.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

import AVFoundation
import Foundation

class CaptureVideoLayer: AVCaptureVideoPreviewLayer,NSCoding {


    
    

    override func copy() -> AnyObject {
        
        
        return CaptureVideoLayer()
    }
    
}


