//
//  MotionProtocol.swift
//  watchOSMotion
//
//  Created by Enkhjargal Gansukh on 14/03/2018.
//  Copyright © 2018 Enkhjargal Gansukh. All rights reserved.
//

import CoreMotion

public struct Accel: Codable {
    public var x: Double
    public var y: Double
    public var z: Double
    
    init(data: CMAcceleration) {
        x = data.x
        y = data.y
        z = data.z
    }
}

public struct Gyro: Codable {
    public var x: Double
    public var y: Double
    public var z: Double
    
    init(data: CMRotationRate) {
        x = data.x
        y = data.y
        z = data.z
    }
}

public struct Quaternion: Codable {
    public var x: Double
    public var y: Double
    public var z: Double
    public var w: Double
    
    init(data: CMQuaternion) {
        x = data.x
        y = data.y
        z = data.z
        w = data.w
    }
}


public struct MotionData: Codable {
    public var accel: Accel
    public var gyro: Gyro
    public var quaternion: Quaternion
    init(_accel: CMAcceleration, _gyro: CMRotationRate, _quater: CMQuaternion) {
        accel = Accel(data: _accel)
        gyro = Gyro(data: _gyro)
        quaternion = Quaternion(data: _quater)
    }
    public func printLog(){
        print("ax: \(accel.x), ay: \(accel.y), az: \(accel.z), gx: \(gyro.x), gy: \(gyro.y), gz: \(gyro.z), qx: \(quaternion.x), qy: \(quaternion.y),qz: \(quaternion.z),qw: \(quaternion.w)")
    }
    public func isReadyAngle() -> Bool {
        if(accel.x > 0.7 &&  -0.2 < accel.y && accel.y < 0.5 && -0.3 < accel.z && accel.z < 0.5) { return true } else { return false }
    }
    public func isMoving() -> Bool {
        return sqrt(accel.x * accel.x + accel.y * accel.y + accel.z * accel.z) < 0.3
    }
}


public protocol MotionProtocol {
    func onMotionChanged(data: MotionData)
}
