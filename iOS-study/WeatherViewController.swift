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
    
    func didFailWithError(_ service: WeatherService, error: Error) {
        let errorMessage = makeErrorMessage(from: error)
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    func makeErrorMessage(from error: Error) -> String {
        if let yumemiError = error as? YumemiWeatherError {
            switch yumemiError {
            case .invalidParameterError:
                return "Invalid parameters!"
            case .unknownError:
                return "An unknown error occurred!"
            }
        } else {
            return error.localizedDescription
        }
    }
    
    deinit {
        print("WeatherViewController deinitialized")
    }
}
