//
//  InterfaceController.swift
//  AppleWatchTestApp WatchKit Extension
//
//  Created by Enkhjargal Gansukh on 06/03/2018.
//  Copyright © 2018 Enkhjargal Gansukh. All rights reserved.
//

import WatchKit
import Foundation
import watchOSMotion
import CoreMotion


class InterfaceController: WKInterfaceController {
    
    let motion = Motion()
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func startAccelerometer() {
        motion.startAccel()
    }
    @IBAction func startGyroscope() {
        motion.startGyro()
    }
    @IBAction func startMotiondata() {
        motion.startMotion()
    }
    @IBAction func stopMotion() {
        motion.stopAll()
    }
}
