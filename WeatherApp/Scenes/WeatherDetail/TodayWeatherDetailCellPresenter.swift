//
//  TodayWeatherDetailCellPresenter.swift
//  WeatherApp
//
//  Created by yangpc on 18/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

extension WeatherDetailViewController {

    class TodayWeatherDetailCellPresenter: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

        var model: TodayDetailWeatherViewData? {
            didSet {
                collectionView?.reloadData()
            }
        }

        weak var collectionView: UICollectionView? {
            didSet {
                collectionView?.dataSource = self
                collectionView?.delegate = self
            }
        }

        func setContent(_ content: TodayDetailWeatherViewData?,
                        cellProvider: UICollectionView,
                        indexPath: IndexPath)
            -> TodayWeatherDetailCollectionViewCell
        {
            let cell = cellProvider.dequeueReusableCell(
                withReuseIdentifier: TodayWeatherDetailCollectionViewCell.identifier,
                for: indexPath) as! TodayWeatherDetailCollectionViewCell
            self.collectionView = cell.collectionView
            self.model = content
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return TodayWeather.allTypes.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TodayWeatherDetailCell.identifier,
                for: indexPath) as! TodayWeatherDetailCell
            let type = TodayWeather.allTypes[indexPath.row]
            
            cell.contentLabel.text = model?.getText(type: type) ?? .cellPlaceholder
            cell.titleLabel.text = type.rawValue
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width / 2, height: 50)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 5
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10
        }
    }

}

enum TodayWeather: String {
    case sunrise
    case sunset
    case probability
    case humidity
    case wind
    case feelsLike
    case intensity
    case pressure
    case uvIndex
    case visibility

    static let allTypes: [TodayWeather] = [
        .sunrise, .probability, .wind,
        .intensity, .visibility, .sunset,
        .humidity, .feelsLike, .pressure,
        .uvIndex]
}

fileprivate extension TodayDetailWeatherViewData {

    func getText(type: TodayWeather) -> String? {
        switch type {
        case .sunrise:
            return sunriseTime?.getDayName(by: .time, timeZone: timezone)
        case .sunset:
            return sunsetTime?.getDayName(by: .time, timeZone: timezone)
        case .probability:
            return precipProbability?.asPercent
        case .humidity:
            return humidity?.asPercent
        case .wind:
            let degree = windBearing?.asDegrees ?? ""
            let speed = windSpeed?.asMetersPerSecond ?? 0.0.asMetersPerSecond
            return degree + speed
        case .feelsLike:
            return apparentTemperature?.asTemperature
        case .intensity:
            return precipIntensity?.asMMPerHour
        case .pressure:
            return pressure?.asMilibar
        case .uvIndex:
            return uvIndex?.asString
        case .visibility:
            return visibility?.asKilometers

        }
    }
}

