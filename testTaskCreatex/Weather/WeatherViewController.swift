//
//  WeathetViewController.swift
//  testTaskCreatex
//
//  Created by Ilya Latugovskii on 06.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//

import UIKit

protocol WeatherInformationProtocol {
    var temperature: Int { get }
    var city: String { get }
}

class WeatherViewController: UIViewController {
    var weatherInformation: WeatherInformationProtocol?
    
    @IBOutlet weak var weatherInformationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherInformationLabel.text = String(weatherInformation!.temperature) + " degrees in " + weatherInformation!.city
    }
}
