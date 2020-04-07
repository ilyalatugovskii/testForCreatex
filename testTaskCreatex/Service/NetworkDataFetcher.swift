//
//  NetworkDataFetcher.swift
//  testTaskCreatex
//
//  Created by Ilya Latugovskii on 06.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func getData(withParams params: [String:String], completion: @escaping (WeatherAPI) -> Void)
}

class NetworkDataFetcher: DataFetcher {
   
    private let networkService: Networking = NetworkService()
    
    func getData(withParams params: [String:String], completion: @escaping (WeatherAPI) -> Void) {
        networkService.request(params: params) { (data, error) in
            if let data = data {
                let needModel = try! JSONDecoder().decode(WeatherAPI.self, from: data)
                completion(needModel)
            }
        }
    }
}
