//
//  Motion.swift
//  watchOSMotion
//
//  Created by Enkhjargal Gansukh on 05/03/2018.
//  Copyright © 2018 Enkhjargal Gansukh. All rights reserved.
//

import Foundation
import CoreMotion

public class Motion{
    let motionManager = CMMotionManager()
    var motionSupport = false
    public init() {
        print("Motion inited")
    }
    
    public func motionAvailableCheck() -> Bool {
        motionSupport = motionManager.isDeviceMotionAvailable
        return motionSupport
    }
    //  Accelerometer data start
    public func startAccel(){
        if !motionSupport {
            return
        }
        motionManager.accelerometerUpdateInterval = 0.01
        motionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: { (data: CMAccelerometerData?, error: Error?) -> Void in
            if error == nil, let accel = data {
                print("accel_x : \(accel.acceleration.x), accel_y : \(accel.acceleration.y), accel_z : \(accel.acceleration.z)")
            }
        })
    }
    public func startGyro(){
        if !motionSupport {
            return
        }
        motionManager.gyroUpdateInterval = 0.01
        motionManager.startGyroUpdates(to: OperationQueue.main, withHandler: { (gyroData, error) in
            if error == nil, let data = gyroData {
                print("gyro_x : \(data.rotationRate.x), gyro_y : \(data.rotationRate.y), gyro_z : \(data.rotationRate.z)")
            }
        })
    }
    //  DeviceMotion data start
    public func startMotion(){
        print("startMotion")
        if !motionSupport {
            return
        }
        motionManager.deviceMotionUpdateInterval = 1.0
        motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (motionData: CMDeviceMotion?, error: Error?) in
            if error == nil, let data = motionData {
                print("pitch: \(data.attitude.pitch), yaw: \(data.attitude.yaw), roll: \(data.attitude.roll)")
            }
        }
    }
    
    public func stopAll(){
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
        motionManager.stopDeviceMotionUpdates()
    }
}
