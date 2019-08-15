//
//  CurrentWeatherHeaderCell.swift
//  WeatherApp
//
//  Created by yangpc on 15/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

class CurrentWeatherHeaderCell: UICollectionViewCell, TypeIdentifiable {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var highTemperatureLable: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
