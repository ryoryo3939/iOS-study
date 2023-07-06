//
//  WeatherService.swift
//  iOS-study
//
//  Created by S892 on 2023/06/22.
//

import Foundation
import YumemiWeather

protocol WeatherServiceDelegate: AnyObject {
    func didUpdateWeather(_ service: WeatherService, weatherType: WeatherType?)
    func didFailWithError(_ service: WeatherService, error: Error)
}

class WeatherService {
    weak var delegate: WeatherServiceDelegate?

    func fetchWeather() {
        do {
            let weather = try YumemiWeather.fetchWeatherCondition(at: "tokyo") // tryを使ってエラーを捕捉
            let weatherType = WeatherType(rawValue: weather)
            self.delegate?.didUpdateWeather(self, weatherType: weatherType)
        } catch let error {
            self.delegate?.didFailWithError(self, error: error) // エラーが発生したらdelegateメソッドを呼び出す
        }
    }
}
