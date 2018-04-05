//
//  MotionProtocol.swift
//  watchOSMotion
//
//  Created by Enkhjargal Gansukh on 14/03/2018.
//  Copyright © 2018 Enkhjargal Gansukh. All rights reserved.
//

import Foundation

public struct Accel {
    var x: Double
    var y: Double
    var z: Double
    
    func printLog(){
        print("Accel: \(x), \(y), \(z)")
    }
}

public struct Gyro {
    var x: Double
    var y: Double
    var z: Double
    
    func printLog(){
        print("Gyro: \(x), \(y), \(z)")
    }
}

public struct Motion {
    var yaw: Double
    var pitch: Double
    var roll: Double
    func printLog(){
        print("Motion: \(yaw), \(pitch), \(roll)")
    }
}

struct MotionData {
    var acc_x: Double
    var acc_y: Double
    var acc_z: Double
    var gyro_x: Double
    var gyro_y: Double
    var gyro_z: Double
    func printLog(){
        print("acc_x: \(acc_x), acc_y: \(acc_y), acc_z: \(acc_z), gyro_x: \(gyro_x), gyro_y: \(gyro_y), gyro_z: \(gyro_z)")
    }
}


protocol MotionProtocol {
    func onMotionChanged(data: MotionData)
}
