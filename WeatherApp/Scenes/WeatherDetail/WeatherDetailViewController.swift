//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by yangpc on 10/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    var locationName: String?
    var weatherData: Response?

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        locationLabel.text = locationName
        summaryLabel.text = weatherData!.currently.summary!
        temperatureLabel.text = "\(Int(weatherData!.currently.temperature!))º"
    }

}
