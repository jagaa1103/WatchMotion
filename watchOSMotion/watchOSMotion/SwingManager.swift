//
//  SwingManager.swift
//  watchOSMotion
//
//  Created by Enkhjargal Gansukh on 31/03/2018.
//  Copyright © 2018 Enkhjargal Gansukh. All rights reserved.
//

import Foundation

public class SwingManager{
    var swingData = [MotionData]()
    var readyTreshHold = [MotionData]()
    
    func checkReady(data: MotionData) -> Bool {
        if readyTreshHold.count < 80 {
            return false
        } else {
            readyTreshHold.removeFirst()
            readyTreshHold.append(data)
        }
        var errCount = 0
        readyTreshHold.forEach({ (data) in
            if((data.acc_x > 0.45) && ( 0.1 < data.acc_y && data.acc_y < 0.5) && (-0.3 < data.acc_z && data.acc_z < 0.3)) {
                
            }else{
                errCount += 1
            }
        })
        if(errCount == 0){
            return true
        }
        return false
    }
    
    var isSwinging = false
    var swingTimer: Timer!
    func collectSwingData(data: MotionData){
        data.printLog()
        if !isSwinging, checkReady(data: data) {
            print("============= Ready =============")
            isSwinging = true
            reset()
        }
        if isSwinging {
            swingTimer = Timer(timeInterval: 3.0, repeats: false, block: { _ in
                self.isSwinging = false
                self.analyzeSwing()
            })
            swingData.append(data)
        }
    }
    
    func reset(){
        isSwinging = false
        swingData = [MotionData]()
        swingTimer.invalidate()
    }
    
    func analyzeSwing(){
        print("================= start Analyze Swing ==================")
        swingData.forEach({ data in
            data.printLog()
        })
        print("================= finish Analyze Swing ==================")
    }
}
