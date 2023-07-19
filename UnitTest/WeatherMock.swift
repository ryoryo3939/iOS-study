//
//  WeatherMock.swift
//  iOS-study
//
//  Created by S892 on 2023/07/11.
//

import Foundation
@testable import iOS_study


class WeatherServiceMock: WeatherService {
    var weatherResponse: WeatherResponse?
    var weatherType: WeatherType?
    var jsonStringToReturn: String?

    override func fetchWeather() {
        if let jsonStringToReturn = jsonStringToReturn,
           let jsonData = jsonStringToReturn.data(using: .utf8) {
            do {
                print(jsonStringToReturn)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                weatherResponse = try decoder.decode(WeatherResponse.self, from: jsonData)
                guard let condition = weatherResponse?.weatherCondition else { return }
                weatherType = WeatherType(rawValue: condition)
            } catch {
                return
            }
        }
        guard let weatherResponse = weatherResponse, let weatherType = weatherType else {
            return
        }
        print("Calling didUpdateWeather")
        self.delegate?.didUpdateWeather(self, weatherResponse: weatherResponse, weatherType: weatherType)
    }
}
