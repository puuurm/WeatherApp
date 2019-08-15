//
//  WeatherTableCell.swift
//  WeatherApp
//
//  Created by yangpc on 15/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

class WeatherTableCell: UITableViewCell {

    static let identifier: String = "\(WeatherTableCell.self)"
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

}
