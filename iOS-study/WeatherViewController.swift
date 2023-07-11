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

        NotificationCenter.default.addObserver(self, selector: #selector(refreshWeatherOnActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        weatherService.fetchWeather()
    }

    @objc func refreshWeatherOnActive() {
        weatherService.fetchWeather()
    }
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var lowestTemperature: UILabel!
    @IBOutlet weak var highestTemperature: UILabel!
    
    @IBAction func reloadButtonAction(_ sender: UIButton) {
        weatherService.fetchWeather()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didUpdateWeather(_ service: WeatherService, weatherResponse: WeatherResponse, weatherType: WeatherType) {
        self.weatherImageView.image = weatherType.image
        self.lowestTemperature.text = "\(weatherResponse.minTemperature)"
        self.highestTemperature.text = "\(weatherResponse.maxTemperature)"
     }
    
    func didFailWithError(_ service: WeatherService, error: Error) {
        DispatchQueue.main.async {
            let errorMessage = self.makeErrorMessage(error)
            let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }

    func makeErrorMessage(_ error: Error) -> String {
        guard let weatherError = error as? YumemiWeatherError else {
            return error.localizedDescription
        }
        switch weatherError {
        case .invalidParameterError:
            return "Invalid parameters!"
        case .unknownError:
            return "An unknown error occurred!"
        }
    }
    
    deinit {
        print("WeatherViewController deinitialized")
    }
}
