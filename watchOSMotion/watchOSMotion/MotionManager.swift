//
//  Motion.swift
//  watchOSMotion
//
//  Created by Enkhjargal Gansukh on 05/03/2018.
//  Copyright © 2018 Enkhjargal Gansukh. All rights reserved.
//

import Foundation
import CoreMotion

class MotionManager {
    
    let motionManager = CMMotionManager()
    let swingManager = SwingManager()
    var delegate: MotionProtocol?
    var treshArray = [Accel]()
    
    func motionAvailableCheck() -> Bool {
        return motionManager.isDeviceMotionAvailable
    }
    
    func startAll(){
        if !motionAvailableCheck() { return }
//        startAccel()
//        startGyro()
        startMotion()
    }
    
    //  Accelerometer start
    func startAccel(){
        motionManager.accelerometerUpdateInterval = 0.01
        motionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: { (accelData: CMAccelerometerData?, error: Error?) -> Void in
            if error == nil, let data = accelData {
                let accel = Accel(x: data.acceleration.x, y: data.acceleration.y, z: data.acceleration.z)
                accel.printLog()
            }
        })
    }
    //  Gyroscope start
    func startGyro(){
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.01
            motionManager.startGyroUpdates(to: OperationQueue.main, withHandler: { (gyroData: CMGyroData?, error: Error?) in
                if error == nil, let data = gyroData {
                    let gyro = Gyro(x: data.rotationRate.x, y: data.rotationRate.y, z: data.rotationRate.z)
                    gyro.printLog()
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
                let sensorData = MotionData(acc_x: data.userAcceleration.x, acc_y: data.userAcceleration.y, acc_z: data.userAcceleration.z, gyro_x: data.rotationRate.x, gyro_y: data.rotationRate.y, gyro_z: data.rotationRate.z)
                self.swingManager.collectSwingData(data: sensorData)
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
