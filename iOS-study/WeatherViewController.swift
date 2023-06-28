//
//  ViewController.swift
//  iOS-study
//
//  Created by S892 on 2023/06/20.
//

import UIKit

class WeatherViewController: UIViewController, WeatherServiceDelegate {
    
    var weatherService: WeatherService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherService = WeatherService()
        weatherService?.delegate = self
    }
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var reloadButton: UIButton!
    
    @IBAction func reloadButtonAction(_ sender: UIButton) {
        weatherService?.fetchWeather()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // WeatherServiceDelegate method
    func weatherService(_ service: WeatherService, didUpdateWeather weather: String) {
        switch weather {
        case "sunny":
            self.weatherImageView.image = UIImage(named: "icon-sunny")
        case "cloudy":
            self.weatherImageView.image = UIImage(named: "icon-cloudy")
        case "rainy":
            self.weatherImageView.image = UIImage(named: "icon-rainy")
        default:
            print("Failed to fetch weather.")
        }
    }
    
    deinit {
        print("WeatherViewController deinitialized")
    }
}
