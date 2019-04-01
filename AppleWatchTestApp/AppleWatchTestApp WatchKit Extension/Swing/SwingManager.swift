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

    func checkReady(data: MotionData) -> Bool {
        if( data.isReadyAngle() && !data.isMoving() ) {
            readyTreshHold.append(data)
        }else{
            readyTreshHold.removeAll()
        }
        if readyTreshHold.count > READY_CHECK_COUNTER {
            delegate?.onReady()
            return true
        }
        return false
    }
    
    
    var movementTreshHold = [MotionData]()
    func checkSwingMovement(data: MotionData)->Bool {
//        movementTreshHold.append(data)
//        if movementTreshHold.count < 3 {
//            return false
//        } else {
////            let velocity = sqrt(movementTreshHold[0].accel.z * movementTreshHold[0].accel.z + movementTreshHold[0].accel.z * movementTreshHold[0].accel.z + movementTreshHold[0].accel.z * movementTreshHold[0].accel.z)
//        }
        return true
    }
    
    
    func reset(){
        swingData.removeAll()
        swingTimer.invalidate()
    }
    
    func analyzeSwing(){
        print("================= start Analyze Swing ==================")
        delegate?.onSwing(dataList: swingData)
        print("================= finish Analyze Swing ==================")
        SWING_STATE = .SWING_END
    }
    
    var SWING_STATE = SwingState.NOT_READY
    public func onMotionChanged(data: MotionData) {
        switch SWING_STATE {
        case .NOT_READY:
            if checkReady(data: data) {
                SWING_STATE = .READY
            } else {
                SWING_STATE = .NOT_READY
            }
        case .READY:
            if checkSwingMovement(data: data) {
                SWING_STATE = .SWING_START
            } else {
                SWING_STATE = .SWING_FAILED
            }
        case .SWING_START:
            collectSwingData(data: data)
        case .SWING_END:
            reset()
            SWING_STATE = .NOT_READY
        case .SWING_FAILED:
            reset()
            SWING_STATE = .NOT_READY
        }
    }
    
    var swingTimer: Timer!
    func collectSwingData(data: MotionData){
        if swingTimer == nil || !swingTimer.isValid {
            swingTimer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false, block: { _ in
                self.analyzeSwing()
                self.swingTimer.invalidate()
            })
        }
        swingData.append(data)
    }
    
    func toJSON(data: MotionData) -> String {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(data)
            return String(data: jsonData, encoding: .utf8)!
        } catch {
            print("toJSON error")
            return ""
        }
        return ""
    }
}
