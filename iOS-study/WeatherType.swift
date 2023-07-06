//
//  WeatherType.swift
//  iOS-study
//
//  Created by S892 on 2023/06/30.
//

import Foundation
import UIKit

enum WeatherType: String, Codable{
    case sunny
    case cloudy
    case rainy
    
    var image: UIImage {
        switch self {
        case .sunny:
            return (UIImage(named: "icon-sunny")?.withTintColor(.customOrange))!
        case .cloudy:
            return (UIImage(named: "icon-cloudy")?.withTintColor(.customGrey))!
        case .rainy:
            return (UIImage(named: "icon-rainy")?.withTintColor(.customLightBlue))!
        }
    }
}
