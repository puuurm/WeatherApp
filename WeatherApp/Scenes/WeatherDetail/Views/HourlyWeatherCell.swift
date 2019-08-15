//
//  HourlyWeatherCell.swift
//  WeatherApp
//
//  Created by yangpc on 15/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

class HourlyWeatherCell: UICollectionViewCell, TypeIdentifiable {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
