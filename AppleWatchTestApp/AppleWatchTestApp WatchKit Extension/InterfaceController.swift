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

class InterfaceController: WKInterfaceController, SwingProtocol {
    let connectionService = ConnectionService()
    let swingManager = SwingManager()
    
    @IBOutlet var connectionStateLabel: WKInterfaceLabel!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        swingManager.delegate = self
        connectionStateLabel.setText("disconnected")
        connectionService.start(ctrl: self)
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }

    @IBAction func sendMessage() {
        do {
            try connectionService.sendToPhone(header: "Greeting", message: "watch")
        } catch {
            print("Error >> sendMessage")
        }
    }
    @IBAction func startWorkout() {
        swingManager.start()
    }
    
    @IBAction func stopWorkout() {
        swingManager.stop()
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
    
//  ============= Swing Detection Protocol Events =============
//  ===========================================================
    func onReady() {
        print("Ready")
    }
    
    func onSwing() {
        print("onSwing")
    }
//  ===========================================================
//  ===========================================================
}
