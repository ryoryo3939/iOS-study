//
//  NewViewController.swift
//  iOS-study
//
//  Created by S892 on 2023/06/23.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)

        if let oldViewController = self.storyboard?.instantiateViewController(withIdentifier: "WeatherViewController") {
            self.present(oldViewController, animated: true, completion: nil)
        }
    }
}
