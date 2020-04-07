//
//  Location.swift
//  testTaskCreatex
//
//  Created by Ilya Latugovskii on 06.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

protocol LocationServiceDelegate: class {
    func coordinates(params: [String: String])
}

final class LocationServise: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    weak var locationServiceDelegate: LocationServiceDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let coordinate = manager.location!.coordinate
        let params = [(String(describing: coordinate.latitude)): (String(describing: coordinate.longitude))]
        locationServiceDelegate?.coordinates(params: params)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            NotificationCenter.default.post(name: .permissionToAccessLocation, object: nil)
        case .notDetermined:
            print(#function)
        case .restricted:
            print(#function)
        case .denied:
            print(#function)
        case .authorizedAlways:
            print(#function)
        @unknown default:
            print("default")
        }
    }
    
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
        -> Void ) {
        
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
            
            geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                    completionHandler(nil)
                }
            })
        }
        else {
            completionHandler(nil)
        }
    }
    
}
