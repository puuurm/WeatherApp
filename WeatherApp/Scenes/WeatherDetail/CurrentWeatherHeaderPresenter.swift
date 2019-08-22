//
//  CurrentWeatherHeaderPresenter.swift
//  WeatherApp
//
//  Created by yangpc on 22/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

extension WeatherDetailViewController {

    class CurrentWeatherHeaderPresenter {
        func setContent(_ content: CurrentWeatherViewData?,
                        cellProvider: UICollectionView,
                        indexPath: IndexPath)
            -> CurrentWeatherHeaderCell
        {
            let view = cellProvider.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: CurrentWeatherHeaderCell.identifier,
                for: indexPath) as! CurrentWeatherHeaderCell

            guard let content = content,
                let temperatureText = content.temperature?.asTemperature,
                let highTemperatureText = content.highTemperature?.asTemperature,
                let lowTemperatureText = content.lowTemperature?.asTemperature,
                let summaryText = content.summary
                else {
                    view.highTemperatureLable.text = .cellPlaceholder
                    view.lowTemperatureLabel.text = .cellPlaceholder
                    view.locationLabel.text = .cellPlaceholder
                    view.summaryLabel.text = .cellPlaceholder
                    view.temperatureLabel.text = .cellPlaceholder
                    view.dayLabel.text = .cellPlaceholder
                    return view
            }

            view.highTemperatureLable.text = highTemperatureText
            view.lowTemperatureLabel.text = lowTemperatureText
            view.locationLabel.text = content.locationName
            view.summaryLabel.text = summaryText
            view.temperatureLabel.text = temperatureText

            view.dayLabel.text = content.day.getDayName(
                by: .week,
                timeZone: content.timezone
            )
            return view
        }

    }

}
