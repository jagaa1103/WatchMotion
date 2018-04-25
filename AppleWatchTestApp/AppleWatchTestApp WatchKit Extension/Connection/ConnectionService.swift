//
//  ConnectionService.swift
//  AppleWatchTestApp WatchKit Extension
//
//  Created by Enkhjargal Gansukh on 10/03/2018.
//  Copyright © 2018 Enkhjargal Gansukh. All rights reserved.
//

import Foundation
import WatchConnectivity

class ConnectionService: NSObject, WCSessionDelegate {
    
    let session = WCSession.default
    weak var controller: InterfaceController!
    
    func start(ctrl: InterfaceController){
        print("::::::::: ConnectionService > start :::::::::::::::")
        if WCSession.isSupported(){
            session.delegate = self
            session.activate()
            controller = ctrl
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
            print("activationDidCompleteWith > activated")
            controller?.onConnectionState(state: true)
            break
        case .inactive:
            print("activationDidCompleteWith > inactive")
            controller?.onConnectionState(state: false)
            break
        case .notActivated:
            print("activationDidCompleteWith > notActivated")
            controller?.onConnectionState(state: false)
            break
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("didReceiveMessage: \(message)")
    }
    
    func sessionReachabilityDidChange(_ session: WCSession) {
        print("sessionReachabilityDidChange : \(session)")
    }
    
    func sendToPhone(header: String, message: String) throws {
        self.session.sendMessage([header: message], replyHandler: nil, errorHandler: nil)
    }
    
}
