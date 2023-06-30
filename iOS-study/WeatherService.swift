//
//  WeatherService.swift
//  iOS-study
//
//  Created by S892 on 2023/06/22.
//

import Foundation
import YumemiWeather

protocol WeatherServiceDelegate: AnyObject {
    func didUpdateWeather(_ service: WeatherService, weather: String)
}

class WeatherService {
    weak var delegate: WeatherServiceDelegate?

    func fetchWeather() {
        // 天気を非同期に取得するコード
        let weather = YumemiWeather.fetchWeatherCondition()

        // delegateメソッドを呼び出す
        self.delegate?.didUpdateWeather(self, weather: weather)
    }
}
