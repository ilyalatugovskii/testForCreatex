//
//  FirstTutorialViewController.swift
//  testTaskCreatex
//
//  Created by Ilya Latugovskii on 04.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//

import UIKit
import FirebaseAnalytics

protocol ButtonPressDelegate: class {
    func nextPage(viewController: UIViewController)
}

class FirstTutorialViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    weak var delegate: ButtonPressDelegate?
    let locationService = LocationServise()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(permissionToAccessLocation), name: .permissionToAccessLocation, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func permissionToAccessLocation() {
        nextButton.isHidden = false
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.backgroundActivites = BackgroundActivites(locationService: locationService)
        }
        UserDefaults.standard.set(true, forKey: "FirstRun")
    }

    @IBAction func next(_ sender: UIButton) {
        Analytics.logEvent("Click", parameters: ["Controllers" : "\(self)", "Device" : UIDevice.current.model, "ButtonName": #function])
        
        delegate?.nextPage(viewController: self)
    }
    
}

    

