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
    //  Accelerometer data start
    public func startAccel(){
        motionManager.accelerometerUpdateInterval = 1.0
        motionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: { (data: CMAccelerometerData?, error: Error?) in
            if((error) != nil) {
                print(error.debugDescription)
                return
            }
            if let accel = data {
                print("accel_x : \(accel.acceleration.x)")
                print("accel_y : \(accel.acceleration.y)")
                print("accel_z : \(accel.acceleration.z)")
            }
        })
    }
}
