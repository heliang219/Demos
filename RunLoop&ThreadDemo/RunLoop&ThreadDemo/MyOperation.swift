//
//  MyOperation.swift
//  RunLoop&ThreadDemo
//
//  Created by pfl on 15/11/29.
//  Copyright © 2015年 pfl. All rights reserved.
//

import UIKit

class MyOperation: NSOperation {

    override func start() {
        
        willChangeValueForKey("executing")
        
        
    }
    
    override var concurrent: Bool {
        return true
    }
    
    override var asynchronous: Bool {
        return true
    }
    
    private func finish() {
        
    }
    
    
    
}
