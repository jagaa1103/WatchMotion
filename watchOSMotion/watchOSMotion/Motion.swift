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
    public init() {
        print("Motion inited")
    }
    
    public func motionAvailableCheck() -> Bool {
        return motionManager.isDeviceMotionAvailable
    }
    //  Accelerometer start
    public func startAccel(){
        if !motionAvailableCheck() {
            return
        }
        motionManager.accelerometerUpdateInterval = 0.01
        motionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: { (data: CMAccelerometerData?, error: Error?) -> Void in
            if error == nil, let accel = data {
                print("accel_x : \(accel.acceleration.x), accel_y : \(accel.acceleration.y), accel_z : \(accel.acceleration.z)")
            }
        })
    }
    //  Gyroscope start
    public func startGyro(){
        if !motionAvailableCheck() {
            return
        }
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.01
            motionManager.startGyroUpdates(to: OperationQueue.main, withHandler: { (gyroData: CMGyroData?, error: Error?) in
                if error == nil, let data = gyroData {
                    print("gyro_x : \(data.rotationRate.x), gyro_y : \(data.rotationRate.y), gyro_z : \(data.rotationRate.z)")
                }
            })
        }else{
            print("GyroScope is not support")
        }
    }
    //  DeviceMotion start
    public func startMotion(){
        if !motionAvailableCheck() {
            return
        }
        motionManager.deviceMotionUpdateInterval = 0.01
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
