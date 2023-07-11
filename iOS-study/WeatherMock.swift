//
//  WeatherMock.swift
//  iOS-study
//
//  Created by S892 on 2023/07/11.
//

import Foundation

class YumemiWeatherMock: WeatherFetchable {
    var jsonStringToReturn: String?

    func fetchWeather(_ jsonString: String) throws -> String {
        return jsonStringToReturn ?? ""
    }
}
