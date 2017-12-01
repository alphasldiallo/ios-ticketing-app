//
//  LocationUpdateManager.swift
//  AlpsSDK
//
//  Created by Maciej Burda on 27/10/2017.
//  Copyright © 2017 Alps. All rights reserved.
//

import Foundation
import Alps

/// filters location data update
final public class LocationUpdateManager {
    private(set) var lastLocation: Location?
    
    func tryToSend(location: Location, for deviceId: String) {
        if location == lastLocation { return }
        LocationAPI.createLocation(deviceId: deviceId, location: location, completion: { (_, error) in
            if error == nil { self.lastLocation = location }
        })
    }
}
