//
//  WeatherService.swift
//  iOS-study
//
//  Created by S892 on 2023/06/22.
//

import Foundation
import YumemiWeather

class WeatherService {
    static func fetchWeatherCondition(completion: @escaping (String?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let weather = YumemiWeather.fetchWeatherCondition()
            DispatchQueue.main.async {
                completion(weather)
            }
        }
    }
}
