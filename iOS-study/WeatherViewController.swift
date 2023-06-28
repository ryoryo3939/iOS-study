//
//  ViewController.swift
//  iOS-study
//
//  Created by S892 on 2023/06/20.
//

import UIKit

class WeatherViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var reloadButton: UIButton!
    @IBAction func reloadButtonAction(_ sender: UIButton) {
        Task {
            do {
                let weather = try await WeatherService.fetchWeatherCondition()
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
            } catch {
                print("Failed to fetch weather: \(error)")
            }
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
