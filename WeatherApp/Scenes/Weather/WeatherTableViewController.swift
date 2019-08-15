//
//  WeatherTableViewController.swift
//  WeatherApp
//
//  Created by yangpc on 10/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {

    let reactor = Reactor()

    var locationNames: [String] = []
    var weatherTableData: [String: Response] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        reactor.viewController = self
    }

    @IBAction func addLocationButtonAction(_ sender: UIButton) {
        presentLocationSearchViewController()
    }

    private func presentLocationSearchViewController() {
        let locationSearch: LocationSearchViewController = UIStoryboard
            .locationSearch
            .instantiateViewController()

        locationSearch.onDismiss = { [weak self] (_, mapItem) in

            let locationName = mapItem.placemark.name ?? "Unknown Place"
            let latitude = mapItem.placemark.coordinate.latitude
            let longitude = mapItem.placemark.coordinate.longitude

            let coordinate = Coordinate(latitude: latitude, longitude: longitude)


            ServerAccess
                .request(coordinate: coordinate, onSuccess: { (response: Response) in
                    self?.weatherTableData.updateValue(response, forKey: locationName)
                    self?.locationNames.append(locationName)
                    DispatchQueue.main.async { [weak self] in
                        self?.tableView.reloadData()
                    }
                }) { (error) in
                    self?.presentError(error: error)
            }

        }

        let locationSearchNavigationController = UINavigationController(
            rootViewController: locationSearch)
        
        navigationController?.present(
            locationSearchNavigationController,
            animated: true,
            completion: nil
        )
    }

    private func pushWeatherDetailViewController(_ data: (name: String, weather: Response)) {
        let weatherDetail: WeatherDetailViewController = UIStoryboard
            .weatherDetail
            .instantiateViewController()
        weatherDetail.locationName = data.name
        weatherDetail.weatherData = data.weather
        navigationController?.pushViewController(weatherDetail, animated: true)
    }

    private func presentError(error: Error) {
        let ac = UIAlertController(
            title: "오류가 발생했습니다.",
            message: nil,
            preferredStyle: .alert
        )

        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        )

        ac.addAction(action)

        present(ac, animated: true, completion: nil)
    }
}

extension WeatherTableViewController {

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: WeatherTableCell.identifier,
            for: indexPath) as! WeatherTableCell

        let locationName = locationNames[indexPath.row]
        guard let weather = weatherTableData[locationName] else {
                return UITableViewCell()
        }

        cell.timeLabel.text = "\(weather.currently.time!)"
        cell.temperatureLabel.text = "\(Int(weather.currently.temperature!))º"
        cell.locationNameLabel.text = locationName
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locationName = locationNames[indexPath.row]
        guard let weather = weatherTableData[locationName] else {
            return
        }
        pushWeatherDetailViewController((locationName, weather))
    }
}
