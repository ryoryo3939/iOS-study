//
//  WeatherType.swift
//  iOS-study
//
//  Created by S892 on 2023/06/30.
//

import Foundation
import UIKit

enum WeatherType: String {
    case sunny
    case cloudy
    case rainy
    
    var image: UIImage {
        switch self {
        case .sunny:
            return UIImage(named: "icon-sunny")!
        case .cloudy:
            return UIImage(named: "icon-cloudy")!
        case .rainy:
            return UIImage(named: "icon-rainy")!
        }
    }
}
