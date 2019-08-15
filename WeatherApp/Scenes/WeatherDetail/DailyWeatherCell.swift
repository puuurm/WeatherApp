//
//  DailyWeatherCell.swift
//  WeatherApp
//
//  Created by yangpc on 15/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

class DailyWeatherCell: UICollectionViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
