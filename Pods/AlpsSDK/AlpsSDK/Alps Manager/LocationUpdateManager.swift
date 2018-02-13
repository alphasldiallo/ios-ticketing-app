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
        if validateLocation(location: location) == false { return }
        LocationAPI.createLocation(deviceId: deviceId, location: location, completion: { _, _ in
            self.lastLocation = location
        })
    }
    
    let kMaxLocationTimeInterval = 10.0
    let kMaxLocationDistance = 20.0
    // validates given location by comparing to last known location
    func validateLocation(location: Location) -> Bool {
        guard let lastClLocation = lastLocation?.clLocation,
              let currentClLocation = location.clLocation
        else { return true }
        
        let distance = currentClLocation.distance(from: lastClLocation)
        let timeInterval = currentClLocation.timestamp.timeIntervalSince(lastClLocation.timestamp)
        
        return (distance > kMaxLocationDistance) && (timeInterval > kMaxLocationTimeInterval)
    }
}
