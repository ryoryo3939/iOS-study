//
//  WeatherMockDelegate.swift
//  iOS-study
//
//  Created by S892 on 2023/07/11.
//

import Foundation
@testable import iOS_study

class YumemiWeatherMockDelegate: WeatherServiceDelegate {
    var lastWeatherResponse: WeatherResponse?
    var lastWeatherType: WeatherType?

    func didUpdateWeather(_ service: WeatherService, weatherResponse: WeatherResponse, weatherType: WeatherType) {
        lastWeatherResponse = weatherResponse
        lastWeatherType = weatherType
    }

    func didFailWithError(_ service: WeatherService, error: Error) {}
}
