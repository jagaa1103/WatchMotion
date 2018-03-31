//
//  WatchConnection.swift
//  AppleWatchTestApp
//
//  Created by Enkhjargal Gansukh on 10/03/2018.
//  Copyright © 2018 Enkhjargal Gansukh. All rights reserved.
//

import Foundation
import WatchConnectivity

class WatchConnection: NSObject, WCSessionDelegate {
    
    var session: WCSession!
    
    func start(){
        print(":::::::::::: WatchConnection > start ::::::::::::::")
        if WCSession.isSupported() {
            session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidBecomeInactive")
    }
    func sessionDidDeactivate(_ session: WCSession) {
        print("sessionDidDeactivate")
    }
    
    func sessionWatchStateDidChange(_ session: WCSession) {
        print("sessionState: \(session)")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("::::::::::: WatchConnection > didReceiveMessage ::::::::::::::")
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("session activation complete : \(activationState)")
    }
}
