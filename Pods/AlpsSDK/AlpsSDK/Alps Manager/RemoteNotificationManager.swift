//
//  RemoteNotificationManager.swift
//  AlpsSDK
//
//  Created by Wen on 07.11.17.
//  Copyright © 2017 Alps. All rights reserved.
//

import Foundation

protocol RemoteNotificationManagerDelegate: class {
    func didReceiveMatchUpdateForDeviceId(deviceId: String)
}

let kTokenKey = "kTokenKey"

public class RemoteNotificationManager: NSObject {
    
    private weak var delegate: RemoteNotificationManagerDelegate?
    var deviceToken: String? {
        didSet {
            KeychainHelper.shared[kTokenKey] = self.deviceToken
        }
    }
    
    init(delegate: RemoteNotificationManagerDelegate) {
        self.deviceToken = KeychainHelper.shared[kTokenKey]
        super.init()
        self.delegate = delegate
    }
    
    func registerDeviceToken(deviceToken: String) {
        self.deviceToken = deviceToken
    }
    
    func process(pushNotification: [AnyHashable: Any]) {
        guard pushNotification["matchId"] != nil else { return }
        delegate?.didReceiveMatchUpdateForDeviceId(deviceId: "")
    }
}
