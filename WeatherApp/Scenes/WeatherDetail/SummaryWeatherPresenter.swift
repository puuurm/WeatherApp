//
//  SummaryWeatherPresenter.swift
//  WeatherApp
//
//  Created by yangpc on 22/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

extension WeatherDetailViewController {
    
    class SummaryWeatherPresenter {
        func setContent(_ content: SummaryWeatherViewData?,
                        cellProvider: UICollectionView,
                        indexPath: IndexPath)
            -> TodaySummaryCell
        {
            let cell = cellProvider.dequeueReusableCell(
                withReuseIdentifier: TodaySummaryCell.identifier,
                for: indexPath) as! TodaySummaryCell

            guard let content = content,
                let highTemperatureText = content.highTemperature?.asTemperature,
                let lowTemperatureText = content.lowTemperature?.asTemperature,
                let summaryText = content.summary
                else {
                    cell.descriptionLabel?.text = .cellPlaceholder
                    return cell
            }
            cell.descriptionLabel?.text = "오늘: 현재 날씨" + summaryText + ". 최고 기온은"
                + highTemperatureText
                + "입니다. 최저 기온은"
                + lowTemperatureText
                + "입니다."
            return cell
        }

    }

}
