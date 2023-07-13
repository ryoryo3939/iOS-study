//
//  WeatherMock.swift
//  iOS-study
//
//  Created by S892 on 2023/07/11.
//

import Foundation
@testable import iOS_study

class YumemiWeatherMock: WeatherFetchable {
    var jsonStringToReturn: String?

    func fetchWeather(_ jsonString: String) throws -> String {
        return jsonStringToReturn ?? ""
    }
}

class WeatherServiceMock: WeatherService {
    var weatherResponse: WeatherResponse?
    var weatherType: WeatherType?

    override func fetchWeather() {
        guard let weatherResponse = weatherResponse, let weatherType = weatherType else {
            return
        }
        self.delegate?.didUpdateWeather(self, weatherResponse: weatherResponse, weatherType: weatherType)
    }
}
