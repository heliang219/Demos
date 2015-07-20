//
//  ViewController.swift
//  ScrollViewDe
//
//  Created by pfl on 15/7/20.
//  Copyright (c) 2015年 pfl. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var sectionScrollView: UIScrollView!
    @IBOutlet weak var rowScrollView: UIScrollView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionScrollView.contentSize = CGSize(width: UIScreen.mainScreen().bounds.width * 4, height: 0)
        sectionScrollView.backgroundColor = UIColor.redColor()
        rowScrollView.contentSize = CGSize(width: 0, height: UIScreen.mainScreen().bounds.height * 4)
        rowScrollView.backgroundColor = UIColor.greenColor()
        mainScrollView.contentSize = CGSize(width: UIScreen.mainScreen().bounds.width * 4, height: UIScreen.mainScreen().bounds.height * 4)
        mainScrollView.backgroundColor = UIColor.grayColor()
        
        
        configurateScrollViews()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func configurateScrollViews() {
        
        let w: CGFloat = UIScreen.mainScreen().bounds.width / 5
        let h: CGFloat = UIScreen.mainScreen().bounds.height / 5
        
        for var i = 0; i < 20; i++ {
            let label = UILabel(frame: CGRectMake(w * CGFloat(i), 0, w, 56))
            label.text = toString(i)
            label.textAlignment = .Center
            label.textColor = UIColor.whiteColor()
            label.font = UIFont.systemFontOfSize(20)
            sectionScrollView.addSubview(label)
            
            let label2 = UILabel(frame: CGRectMake(0, h * CGFloat(i), 56, h))
            label2.text = toString(i)
            label2.textAlignment = .Center
            label2.textColor = UIColor.whiteColor()
            label2.font = UIFont.systemFontOfSize(20)
            rowScrollView.addSubview(label2)
            
            
        }
        
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView .isEqual(sectionScrollView) {
            rowScrollView.delegate = nil
            mainScrollView.delegate = nil
            
            rowScrollView.contentOffset = CGPoint(x: 0, y: sectionScrollView.contentOffset.x / sectionScrollView.contentSize.width * rowScrollView.contentSize.height)
            mainScrollView.contentOffset = CGPoint(x: 0, y: sectionScrollView.contentOffset.x / sectionScrollView.contentSize.width * mainScrollView.contentSize.height)
            
        }
        else if scrollView .isEqual(rowScrollView) {
            sectionScrollView.delegate = nil
            mainScrollView.delegate = nil
            sectionScrollView.contentOffset = CGPoint(x: rowScrollView.contentOffset.y / rowScrollView.contentSize.height * sectionScrollView.contentSize.width, y: 0)
            mainScrollView.contentOffset = CGPoint(x: 0, y: rowScrollView.contentOffset.y / rowScrollView.contentSize.height * mainScrollView.contentSize.height)
            
        }
        else {
            
            sectionScrollView.delegate = nil
            rowScrollView.delegate = nil
            sectionScrollView.contentOffset = CGPoint(x: mainScrollView.contentOffset.x / mainScrollView.contentSize.width * sectionScrollView.contentSize.width, y: 0)
            rowScrollView.contentOffset = CGPoint(x: 0, y: mainScrollView.contentOffset.y / mainScrollView.contentSize.height * rowScrollView.contentSize.height)
            
        }
        
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        rowScrollView.delegate = self
        mainScrollView.delegate = self
        sectionScrollView.delegate = self;
    }
    

}

