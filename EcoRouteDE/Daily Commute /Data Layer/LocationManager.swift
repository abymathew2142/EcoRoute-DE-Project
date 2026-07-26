//
//  LocationManager.swift
//  EcoRoute DE
//
//  Created by Aby Mathew on 08/07/26.
//

import Foundation
import CoreLocation
import Observation

@Observable
final class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager: CLLocationManager = CLLocationManager()
    
    var startLocation: CLLocation?
    var endLocation: CLLocation?
    var isTracking: Bool = false
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    
    func startTracking() {
        startLocation = locationManager.location
        isTracking = true
        locationManager.startUpdatingLocation()
    }
    
    func stopTracking() -> Double {
        endLocation = locationManager.location
        isTracking = false
        locationManager.stopUpdatingLocation()
        
        guard let start = startLocation, let end = endLocation else { return 0.0 }
        
        let distance = start.distance(from: end)
        return distance / 1000.0 // in Km
    }
}
