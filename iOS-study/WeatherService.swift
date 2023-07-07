//
//  WeatherService.swift
//  iOS-study
//
//  Created by S892 on 2023/06/22.
//

import Foundation
import YumemiWeather

protocol WeatherServiceDelegate: AnyObject {
    func didUpdateWeather(_ service: WeatherService, weatherResponse:WeatherResponse, weatherType:WeatherType)
    func didFailWithError(_ service: WeatherService, error: Error)
}

class WeatherService {
    weak var delegate: WeatherServiceDelegate?

    func fetchWeather() {
        do {
            let now = Date()
            let dateString = DateFormatter.iso8601Full.string(from: now)
            let jsonString = "{\"area\":\"tokyo\",\"date\":\"\(dateString)\"}"
            let weatherJsonString = try YumemiWeather.fetchWeather(jsonString)
            print(weatherJsonString)//受け渡している値を表示
            guard let jsonData = weatherJsonString.data(using: .utf8) else {
                print("Failed to convert weatherJsonString to Data.")// nilの場合やエンコードできない場合にはメッセージを表示
                return
            }
            let weatherResponse = try JSONDecoder.customDecoder.decode(WeatherResponse.self, from: jsonData)
            guard let weatherType = getWeatherType(from: weatherResponse.weatherCondition) else {return}
            self.delegate?.didUpdateWeather(self, weatherResponse: weatherResponse, weatherType: weatherType)
        } catch let error {
            self.delegate?.didFailWithError(self, error: error)
        }
    }
    private func getWeatherType(from condition: String) -> WeatherType? {
            return WeatherType(rawValue: condition)
        }
}
