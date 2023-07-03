//
//  ViewController.swift
//  iOS-study
//
//  Created by S892 on 2023/06/20.
//

import UIKit
import YumemiWeather

class WeatherViewController: UIViewController, WeatherServiceDelegate {
    
    var weatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherService = WeatherService()
        weatherService.delegate = self
    }
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var reloadButton: UIButton!
    
    @IBAction func reloadButtonAction(_ sender: UIButton) {
        weatherService.fetchWeather()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didUpdateWeather(_ service: WeatherService, weatherType: WeatherType?) {
                self.weatherImageView.image = weatherType?.image
     }
    
    deinit {
        print("WeatherViewController deinitialized")
    }
}
