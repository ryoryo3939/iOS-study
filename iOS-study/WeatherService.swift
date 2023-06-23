//
//  WeatherService.swift
//  iOS-study
//
//  Created by S892 on 2023/06/22.
//

import Foundation
import YumemiWeather

class WeatherService {
    static func fetchWeatherCondition() async throws -> String {
        return YumemiWeather.fetchWeatherCondition()
    }
}
