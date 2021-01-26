//
//  LocationManager.swift
//  Planti
//
//  Created by Dominik Wieners on 20.01.21.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    private let manager: CLLocationManager
    
    @Published var lastKnownLocation: CLLocation?
    
    init(manager: CLLocationManager = CLLocationManager()) {
        self.manager = manager
        super.init()
    }
    
    func startUpdating() {
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
    }
    
    func stopUpdating() {
        self.manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        debugPrint("📍[Location]: \(locations)")
        lastKnownLocation = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        if status  == .authorizedWhenInUse {
            self.manager.startUpdatingLocation()
        }
    }
    
    
}
