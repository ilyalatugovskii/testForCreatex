//
//  WeatherAPI.swift
//  testTaskCreatex
//
//  Created by Ilya Latugovskii on 06.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//

import Foundation

struct WeatherAPI: Codable {
    var fact: Fact?
}

struct Fact: Codable {
    var temp: Int
}
