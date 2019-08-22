//
//  WeatherTableViewController.swift
//  WeatherApp
//
//  Created by yangpc on 10/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {

    let presenter = Presenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        observeWeatherRepository()
        WeatherRepository.getAllWeather()
    }

    private func setupPresenter() {
        presenter.tableView = tableView

        presenter.onTapItem = { [weak self] (_, locationName, index) in
            self?.pushWeatherDetailViewController(locationName: locationName, index: index)
        }
    }

    private func observeWeatherRepository() {
        NotificationCenter.default.addObserver(
            forName: .GetWeatherSuccess,
            object: nil,
            queue: .main) { [weak presenter] (note) in
                presenter?.tableView.reloadData()
        }

        NotificationCenter.default.addObserver(
            forName: .GetWeatherFailure,
            object: nil,
            queue: .main) { [weak self] (note) in
                guard case .error(let error) = WeatherRepository.state else {
                    return
                }
                self?.presentError(error: error)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func addLocationButtonAction(_ sender: UIButton) {
        presentLocationSearchViewController()
    }


    private func presentLocationSearchViewController() {
        let locationSearch: LocationSearchViewController = UIStoryboard
            .locationSearch
            .instantiateViewController()

        locationSearch.onDismiss = { (_, location) in
            WeatherRepository.add(location: location)
        }

        let locationSearchNavigationController = UINavigationController(
            rootViewController: locationSearch)
        
        navigationController?.present(
            locationSearchNavigationController,
            animated: true,
            completion: nil
        )
    }

    private func pushWeatherDetailViewController(locationName: LocationName, index: Int) {
        let weatherDetail = WeatherDetailViewController(locationName, index: index)
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
