//
//  ContextManager.swift
//  Alps
//
//  Created by Rafal Kowalski on 28.09.16.
//  Copyright © 2016 Alps. All rights reserved.
//

import Foundation
import CoreLocation
import Alps

protocol ContextManagerDelegate: class {
    func didUpdateLocation(location: CLLocation)
}

class ContextManager: NSObject, CLLocationManagerDelegate {
    
    private weak var delegate: ContextManagerDelegate?
    
    let proximityHandler = ProximityHandler()

    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        return locationManager
    }()
    
    lazy var beaconTriples = BeaconTripleStore()

    init(delegate: ContextManagerDelegate) {
        super.init()
        self.delegate = delegate
    }

    // MARK: - Core Location Manager Delegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        delegate?.didUpdateLocation(location: lastLocation)
    }

    // MARK: - Beacons
    
    func startRanging() {
        beaconTriples.findAll { result in
            result.responseObject!.forEach {
                let beaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: $0.proximityUUID!)!, identifier: $0.deviceId!)
                self.locationManager.startRangingBeacons(in: beaconRegion)
            }
        }
    }
    
    // MARK: - Proximity Handler Delegate

    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        beaconTriples.findAll { result in
            self.proximityHandler.rangeBeacons(beacons: beacons, knownBeacons: result.responseObject!)
        }
    }
}
