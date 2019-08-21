//
//  WeatherTableCellPresenter.swift
//  WeatherApp
//
//  Created by yangpc on 21/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

extension WeatherTableViewController {

    class Presenter: NSObject, UITableViewDataSource, UITableViewDelegate {

        weak var tableView: UITableView! {
            didSet {
                tableView.dataSource = self
                tableView.delegate = self
            }
        }

        var onTapItem: ((Presenter, LocationName) -> Void)?

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return WeatherRepository.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(
                withIdentifier: WeatherTableCell.identifier,
                for: indexPath) as! WeatherTableCell

            let currentLocation = WeatherRepository.locations.data[indexPath.row]
            guard let weather = WeatherRepository.weatherTable[currentLocation.name]
                else {
                    cell.timeLabel.text = "-"
                    cell.temperatureLabel.text = "-"
                    cell.locationNameLabel.text = currentLocation.name

                    return cell
            }
            cell.timeLabel.text = Date().getDayName(by: .time, timeZone: weather.timezone)
            cell.temperatureLabel.text = weather.currently.temperature!.asTemperature
            cell.locationNameLabel.text = currentLocation.name
            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let currentLocation = WeatherRepository.locations.data[indexPath.row]
            onTapItem?(self, currentLocation.name)
        }
    }
}
