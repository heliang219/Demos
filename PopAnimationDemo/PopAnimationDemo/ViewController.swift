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
        
        addRefresh()
        
        addRadar()

        addSaw()
    
        addWave()
        
        addRoll()
        
    }
    
    func addRefresh() {
        let refresh = RefreshAnimationView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 200))
        view.addSubview(refresh)
    }
    
    func addRoll() {
        let roll = RollAnimationView(frame: self.view.bounds)
        view.addSubview(roll)
    }
    
    
    func addSaw() {
        let saw = SawAnimationView(frame: CGRect(x: 0, y: 400, width: view.bounds.width, height: 54))
        view.addSubview(saw)
    }
    
    func addRadar() {
       let radar = RadarAnimation(frame: view.bounds)
        view.addSubview(radar)

        radar.callBackRadar = { radar in
            radar.level = 2.5
        }
    }

    func addWave() {
        waver = PFLWaver(frame: CGRect(x: 10, y: 300, width: view.bounds.width-20, height: 44))
        waver.waveColor = UIColor.redColor()
        waver.primaryWaveLineWidth = 3
        waver.secondaryWaveLineWidth = 1
        waver.numberOfWaves = 5
        view.addSubview(waver)
        waver.waveCallBack = { waver in
            waver.level = 1.5
        }

    }
    

    


    
    
    

}

