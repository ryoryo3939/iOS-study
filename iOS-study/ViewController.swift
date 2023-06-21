//
//  ViewController.swift
//  iOS-study
//
//  Created by S892 on 2023/06/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBAction func reloadButtonAction(_ sender: UIButton) {
        WeatherService.fetchWeatherCondition { weather in
            DispatchQueue.main.async {
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
        }
    }
}

