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

class InterfaceController: WKInterfaceController {
    
    let connectionService = ConnectionService()
    let workoutManager = WorkoutManager()
    
    @IBOutlet var connectionStateLabel: WKInterfaceLabel!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        connectionStateLabel.setText("disconnected")
        connectionService.start(ctrl: self)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func sendMessage() {
        connectionService.sendToPhone(message: "Hello my Phone :)")
    }
    @IBAction func startWorkout() {
        workoutManager.startWorkout()
    }
    
    @IBAction func stopWorkout() {
        workoutManager.stopWorkout()
    }
    
    func onConnectionState(state: Bool){
        print("onConnectionState: \(state)")
        WKInterfaceDevice.current().play(.notification)
        if state {
            connectionStateLabel.setText("connected")
        }else{
            connectionStateLabel.setText("disconnected")
        }
    }
    
}
