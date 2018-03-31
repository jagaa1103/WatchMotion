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
//    init(yaw: Double, pitch: Double, roll: Double) {
//        self.yaw = yaw
//        self.pitch = pitch
//        self.roll = roll
//    }
    func printLog(){
        print("Motion: \(yaw), \(pitch), \(roll)")
    }
}

public protocol MotionProtocol {
    func onMotionChanged(data: Accel)
}
