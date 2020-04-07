//
//  SecondTutorialViewController.swift
//  testTaskCreatex
//
//  Created by Ilya Latugovskii on 04.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//

import UIKit
import FirebaseAnalytics

class SecondTutorialViewController: UIViewController {
    
    @IBAction func getWeather(_ sender: UIButton) {
        Analytics.logEvent("Click", parameters: ["Controllers" : "\(self)", "Device" : UIDevice.current.model, "ButtonName": #function])
        
        guard
            let window = UIApplication.shared.windows.first,
            let loadingVC = UIStoryboard(name: "Loading", bundle: nil).instantiateViewController(identifier: "Loading") as? LoadingViewController else { return }

        window.rootViewController = RootViewController(current: loadingVC)
        window.makeKeyAndVisible()
    }
}
