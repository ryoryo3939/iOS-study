//
//  WeatherService.swift
//  iOS-study
//
//  Created by S892 on 2023/06/22.
//

import Foundation
import YumemiWeather

protocol WeatherServiceDelegate: AnyObject {
    func didUpdateWeather(_ service: WeatherService, weatherResponse: Response)
    func didFailWithError(_ service: WeatherService, error: Error)
}

class WeatherService {
    weak var delegate: WeatherServiceDelegate?
    
    private func getDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    private func getResponseFromData(_ data: Data) throws -> Response {
        return try getDecoder().decode(Response.self, from: data)
    }

    func fetchWeather() {
        do {
            let jsonString = "{\"area\":\"tokyo\",\"date\":\"2020-04-01T12:00:00+09:00\"}"
            let weatherJsonString = try YumemiWeather.fetchWeather(jsonString)
            let jsonData = weatherJsonString.data(using: .utf8)!
            let weatherResponse = try getResponseFromData(jsonData)
            self.delegate?.didUpdateWeather(self, weatherResponse: weatherResponse)
        } catch let error {
            self.delegate?.didFailWithError(self, error: error)
        }
    }
}
