//
//  WatchConnectorProtocol.swift
//  AppleWatchTestApp WatchKit Extension
//
//  Created by Enkhjargal Gansukh on 10/03/2018.
//  Copyright © 2018 Enkhjargal Gansukh. All rights reserved.
//

import Foundation


protocol WatchConnector {
    var state: Bool { get set }
    func onStateChanged(state: Bool)
}
