//
//  MotionProtocol.swift
//  watchOSMotion
//
//  Created by Enkhjargal Gansukh on 14/03/2018.
//  Copyright © 2018 Enkhjargal Gansukh. All rights reserved.
//

import CoreMotion


public struct MotionData {
    var accel: CMAcceleration
    var gyro: CMRotationRate
    var quaternion: CMQuaternion
    public func printLog(){
        print("ax: \(accel.x), ay: \(accel.y), az: \(accel.z), gx: \(gyro.x), gy: \(gyro.y), gz: \(gyro.z), qx: \(quaternion.x), qy: \(quaternion.y),qz: \(quaternion.z),qw: \(quaternion.w)")
    }
    public func isReadyAngle() -> Bool {
        if(accel.x > 0.7 &&  -0.2 < accel.y && accel.y < 0.5 && -0.3 < accel.z && accel.z < 0.5) { return true } else { return false }
    }
}


public protocol MotionProtocol {
    func onMotionChanged(data: MotionData)
}
