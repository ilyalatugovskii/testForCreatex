//
//  LoadingViewController.swift
//  testTaskCreatex
//
//  Created by Ilya Latugovskii on 06.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    private let networkDataFetcher: DataFetcher = NetworkDataFetcher()
    private var locationData: LocationData? {
        didSet {
            getWeatherData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.backgroundActivites?.backgroundActivitesDelegate = self
        }

    }
    
    private func getWeatherData() {
        if let locationData = locationData {
            networkDataFetcher.getData(withParams: locationData.params) { (weatherAPI) in
                let weatherInformation: WeatherInformationProtocol = WeatherInformation(temperature: weatherAPI.fact!.temp, city: locationData.city)
                
                guard
                    let rootViewController = UIApplication.shared.windows.first?.rootViewController as? RootViewController,
                    let weatherVC = UIStoryboard(name: "Weather", bundle: nil).instantiateViewController(identifier: "weather") as? WeatherViewController else { return }
                
                weatherVC.weatherInformation = weatherInformation
               
                rootViewController.switchMainScreen(to: weatherVC)
                
            }
        }
    }

}

extension LoadingViewController: BackgroundActivitesDelegate {
    func getLocationData(locationData: LocationData) {
            self.locationData = locationData
    }
}
