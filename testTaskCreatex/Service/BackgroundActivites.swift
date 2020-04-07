//
//  BackgroundActivites.swift
//  testTaskCreatex
//
//  Created by Ilya Latugovskii on 06.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//

import Foundation

struct LocationData {
    var params: [String: String]
    var city: String
}

protocol BackgroundActivitesDelegate: class {
    func getLocationData(locationData: LocationData)
}

class BackgroundActivites {
   
    init(locationService: LocationServise = LocationServise()) {
        self.locationService = locationService
        self.locationService.locationServiceDelegate = self
    }
    private var locationService: LocationServise
    private var locationData: LocationData?
    
    weak var backgroundActivitesDelegate: BackgroundActivitesDelegate? {
        didSet {
            if let locationData = locationData {
                backgroundActivitesDelegate?.getLocationData(locationData: locationData)
            }
        }
    }
}

extension BackgroundActivites: LocationServiceDelegate {
    func coordinates(params: [String : String]) {
       
        locationService.lookUpCurrentLocation { [weak self] (place) in
            guard let city = place?.administrativeArea else { return }
            let locationData = LocationData(params: params, city: city)
            self?.locationData = locationData
            self?.backgroundActivitesDelegate?.getLocationData(locationData: locationData)
        }
    }
}
