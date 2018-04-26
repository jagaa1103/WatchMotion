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

    var isReady = false
    var swingTimer: Timer!
    
    func checkReady(data: MotionData) -> Bool {
        if( data.isReadyAngle() && !data.isMoving() ) { // Ready
            readyTreshHold.append(data)
        }else{ // Not Ready
            readyTreshHold.removeAll()
        }
        if readyTreshHold.count > READY_CHECK_COUNTER {
            delegate?.onReady()
            return true
        }
        return false
    }
    
    func isSwinging()->Bool {
        if(checkMovement()){
            completion()
        }
        swingTimer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false, block: { _ in
            self.isSwinging = false
            self.analyzeSwing()
            self.workoutManager.stopWorkout()
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { _ in
                self.workoutManager.startWorkout()
            })
        })
    }
    
    func checkMovement()->Bool {
        let d1 =
        return false
    }
    
    
    func reset(){
        isSwing = false
        swingData.removeAll()
        swingTimer.invalidate()
    }
    
    func analyzeSwing(){
        print("================= start Analyze Swing ==================")
        swingData.forEach({ data in
            data.printLog()
        })
        delegate?.onSwing()
        print("================= finish Analyze Swing ==================")
        reset()
    }
    
    public func onMotionChanged(data: MotionData) {
        if(isSwinging()){
            collectSwingData(data: data)
            return
        }
        isReady(data: data)
    }
    
    func collectSwingData(data: MotionData){
        swingData.append(data)
    }
}
