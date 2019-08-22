//
//  PagingPresenter.swift
//  WeatherApp
//
//  Created by yangpc on 22/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

extension WeatherDetailViewController {

    class PagingPresenter: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

        let presenter = Presenter()

        weak var collectionView: UICollectionView? {
            didSet {
                collectionView?.dataSource = self
                collectionView?.delegate = self
            }
        }

        var locationName: LocationName = .cellPlaceholder {
            didSet {
                collectionView?.reloadData()
            }
        }

        func setup() {
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

            presenter.todayDetailViewData = TodayDetailWeatherViewData(
                timezone: weatherData.timezone,
                sunriseTime: weatherData.daily.data[0].sunriseTime?.asDate,
                sunsetTime: weatherData.daily.data[0].sunsetTime?.asDate,
                humidity: weatherData.currently.humidity,
                windBearing: weatherData.currently.windBearing,
                windSpeed: weatherData.currently.windSpeed,
                apparentTemperature: weatherData.hourly.data[0].apparentTemperature,
                precipProbability: weatherData.currently.precipProbability,
                precipIntensity: weatherData.currently.precipIntensity,
                precipType: weatherData.currently.precipType,
                pressure: weatherData.currently.pressure,
                uvIndex: weatherData.currently.uvIndex,
                visibility: weatherData.currently.visibility)
        }

        var weatherData: Forecast? {
            return WeatherRepository.weatherTable[locationName]
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return WeatherRepository.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WeatherDetailCell.identifier,
                for: indexPath) as! WeatherDetailCell

            presenter.collectionView = cell.collectionView
            presenter.locationName = WeatherRepository.locations.data[indexPath.row].name
            setup()
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 414, height: 769)
        }

        func setScrollOffset(row: Int) {
            guard let collectionView = collectionView else { return }
            collectionView.scrollToItem(
                at: IndexPath(row: row, section: 0),
                at: UICollectionView.ScrollPosition.centeredHorizontally,
                animated: false
            )
        }
    }
}
