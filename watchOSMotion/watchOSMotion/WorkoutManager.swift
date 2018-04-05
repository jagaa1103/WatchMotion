//
//  WorkoutManager.swift
//  watchOSMotion
//
//  Created by Enkhjargal Gansukh on 31/03/2018.
//  Copyright © 2018 Enkhjargal Gansukh. All rights reserved.
//

import Foundation
import HealthKit

public class WorkoutManager: MotionProtocol {
    
    let motionManager = MotionManager()
    let healthStore = HKHealthStore()
    
    var session: HKWorkoutSession?
    
    public init() {
        motionManager.delegate = self
    }
    
    public func startWorkout(){
        if session != nil { return }
        let config = HKWorkoutConfiguration()
        config.activityType = .golf
        config.locationType = .outdoor
        do {
            session = try HKWorkoutSession(configuration: config)
        } catch {
            fatalError("Workout Session cannot started")
        }
        healthStore.start(session!)
        motionManager.startMotion()
    }
    public func stopWorkout(){
        motionManager.stopMotion()
        if(session != nil){ healthStore.end(session!) }
        session = nil
    }
    
    func onMotionChanged(data: MotionData) {
        data.printLog()
    }
    
}
