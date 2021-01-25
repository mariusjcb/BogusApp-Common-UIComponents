//
//  File.swift
//  
//
//  Created by Marius Ilie on 24/01/2021.
//

import Foundation
import WatchConnectivity
import BogusApp_Common_UIComponents

extension TargetsListFlowCoordinator: WCSessionDelegate {

    public func subscribeToWatchConnectivity() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    public func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        guard let destination = message["to"] as? String,
              let message = message["message"] as? String else { return }
        sendEmail(destination, message)
    }

    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
    public func sessionDidBecomeInactive(_ session: WCSession) { }
    public func sessionDidDeactivate(_ session: WCSession) { }

}
