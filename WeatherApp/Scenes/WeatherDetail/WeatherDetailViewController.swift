//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by yangpc on 10/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    private let presenter = Presenter()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        presenter.collectionView = collectionView
        presenter.locationName = locationName
        return collectionView
    }()

    private var locationName: LocationName

    init(_ locationName: LocationName) {
        self.locationName = locationName
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        registerCollectionViewCell()

        guard let weatherData = WeatherRepository.weatherTable[locationName] else {
            return
        }

        presenter.currentHeaderData = CurrentWeatherViewData(
            day: Date(timeIntervalSince1970: weatherData.currently.time),
            timezone: weatherData.timezone,
            highTemperature: weatherData.daily.data[0].temperatureHigh,
            lowTemperature: weatherData.daily.data[0].temperatureLow,
            locationName: locationName,
            summary: weatherData.currently.summary,
            temperature: weatherData.currently.temperature
        )

        presenter.hourlyList = weatherData.hourly.data.map({ (hourly) -> HourlyWeatherViewData in
            let date = Date(timeIntervalSince1970: hourly.time)
            return HourlyWeatherViewData(
                date: date,
                timezone: weatherData.timezone,
                temperature: hourly.temperature,
                iconName: hourly.icon
            )
        })

        presenter.dailyList = weatherData.daily.data.map({ (daily) -> DailyWeatherViewData in
            let date = Date(timeIntervalSince1970: daily.time)
            return DailyWeatherViewData(
                date: date,
                timezone: weatherData.timezone,
                iconName: daily.icon,
                highTemperature: daily.temperatureHigh,
                lowTemperature: daily.temperatureLow
            )
        })

        presenter.summaryViewData = SummaryWeatherViewData(
            summary: weatherData.currently.summary,
            highTemperature: weatherData.daily.data[0].temperatureHigh,
            lowTemperature: weatherData.daily.data[0].temperatureLow
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }

    private func registerCollectionViewCell() {
        collectionView.register(
            UINib(nibName: CurrentWeatherHeaderCell.identifier, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CurrentWeatherHeaderCell.identifier
        )

        collectionView.register(
            HourlyCollectionViewCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HourlyCollectionViewCell.identifier
        )

        collectionView.register(
            DailyCollectionViewCell.self,
            forCellWithReuseIdentifier: DailyCollectionViewCell.identifier
        )

        collectionView.register(
            TodaySummaryCell.self,
            forCellWithReuseIdentifier: TodaySummaryCell.identifier
        )

        collectionView.register(
            TodayWeatherDetailCollectionViewCell.self,
            forCellWithReuseIdentifier: TodayWeatherDetailCollectionViewCell.identifier
        )
    }

}

