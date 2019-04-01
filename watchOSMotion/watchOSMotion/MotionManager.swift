//
//  Motion.swift
//  watchOSMotion
//
//  Created by Enkhjargal Gansukh on 05/03/2018.
//  Copyright © 2018 Enkhjargal Gansukh. All rights reserved.
//

import Foundation
import CoreMotion

class MotionManager{
    let motionManager = CMMotionManager()
    var delegate: MotionProtocol?
    
    func motionAvailableCheck() -> Bool {
        return motionManager.isDeviceMotionAvailable
    }
    
    func startAll(){
        if !motionAvailableCheck() { return }
        startMotion()
    }
    
    //  Accelerometer start
    func startAccel(){
        motionManager.accelerometerUpdateInterval = 0.01
        motionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: { (accelData: CMAccelerometerData?, error: Error?) -> Void in
            if error == nil, let data = accelData {
                print("accel: x: \(data.acceleration.x), y: \(data.acceleration.y), z: \(data.acceleration.z)")
            }
        })
    }
    //  Gyroscope start
    func startGyro(){
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.01
            motionManager.startGyroUpdates(to: OperationQueue.main, withHandler: { (gyroData: CMGyroData?, error: Error?) in
                if error == nil, let data = gyroData {
                    print("gyro: x: \(data.rotationRate.x), y: \(data.rotationRate.y), z: \(data.rotationRate.z)")
                }
            })
        }else{
            print("GyroScope is not support")
        }
    }
    //  DeviceMotion start
    func startMotion(){
        motionManager.deviceMotionUpdateInterval = 0.01
        motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (motionData: CMDeviceMotion?, error: Error?) in
            if error == nil, let data = motionData {
                let sensorData = MotionData(_accel: data.gravity, _gyro: data.rotationRate, _quater: data.attitude.quaternion)
                self.delegate?.onMotionChanged(data: sensorData)
            }
        }
    }
    func stopMotion(){
        motionManager.stopDeviceMotionUpdates()
    }
    
    func stopAll(){
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
        motionManager.stopDeviceMotionUpdates()
    }
    
}
