//
//  SwingManager.swift
//  watchOSMotion
//
//  Created by Enkhjargal Gansukh on 31/03/2018.
//  Copyright © 2018 Enkhjargal Gansukh. All rights reserved.
//

import Foundation
import watchOSMotion

let READY_CHECK_COUNTER = 50  // 0.5 seconds ready position check



public class SwingManager : MotionProtocol {
    
    var delegate: SwingProtocol?
    let workoutManager = WorkoutManager()
    var swingData = [MotionData]()
    var readyTreshHold = [MotionData]()
    
    init() {
        workoutManager.delegate = self
    }
    func start(){
        workoutManager.startWorkout()
    }
    func stop(){
        workoutManager.stopWorkout()
    }

    var isSwinging = false
    var swingTimer: Timer!
    func collectSwingData(data: MotionData){
        if !isSwinging, checkReady(data: data) {
            delegate?.onReady()
            isSwinging = true
            swingTimer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false, block: { _ in
                self.isSwinging = false
                self.analyzeSwing()
            })
        }
        if isSwinging {
            swingData.append(data)
        }
    }
    
    func checkReady(data: MotionData) -> Bool {
        if data.isReadyAngle() { readyTreshHold.append(data)
        }else{  readyTreshHold.removeAll() }
        if readyTreshHold.count > READY_CHECK_COUNTER { return true }
        return false
    }
    
    func reset(){
        isSwinging = false
        swingData.removeAll()
        swingTimer.invalidate()
    }
    
    func analyzeSwing(){
        print("================= start Analyze Swing ==================")
        swingData.forEach({ data in
            data.printLog()
        })
        print("================= finish Analyze Swing ==================")
        reset()
    }
    
    public func onMotionChanged(data: MotionData) {
        collectSwingData(data: data)
    }
}
