//
//  WeatherFetchableProtocol.swift
//  iOS-study
//
//  Created by S892 on 2023/07/11.
//

import Foundation

protocol WeatherFetchable {
    func fetchWeather(_ jsonString: String) throws -> String
}
