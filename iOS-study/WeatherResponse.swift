//
//  WeatherResponse.swift
//  iOS-study
//
//  Created by S892 on 2023/07/06.
//

import Foundation

struct Response: Codable {
    let weatherCondition: String
    let minTemperature: Int
    let maxTemperature: Int
    let date: String

    func getWeatherType() -> WeatherType? {
        return WeatherType(rawValue: weatherCondition)
    }
}
