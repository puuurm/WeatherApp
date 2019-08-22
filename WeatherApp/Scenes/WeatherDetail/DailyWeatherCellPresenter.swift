//
//  DailyWeatherCellPresenter.swift
//  WeatherApp
//
//  Created by yangpc on 18/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

extension WeatherDetailViewController {

    class DailyWeatherCellPresenter: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

        var model: [DailyWeatherViewData] = [] {
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

        func setContent(_ content: [DailyWeatherViewData],
                        cellProvider: UICollectionView,
                        indexPath: IndexPath)
            -> DailyCollectionViewCell
        {
            let cell = cellProvider.dequeueReusableCell(
                withReuseIdentifier: DailyCollectionViewCell.identifier,
                for: indexPath) as! DailyCollectionViewCell
            self.collectionView = cell.collectionView
            self.model = content
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return model.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DailyWeatherCell.identifier,
                for: indexPath) as! DailyWeatherCell
            let data = model[indexPath.row]

            guard let iconName = data.iconName,
                let highTemperatureText = data.highTemperature?.asString,
                let lowTemperatureText = data.lowTemperature?.asString else {

                    cell.dayLabel.text = .cellPlaceholder
                    cell.highTemperatureLabel.text = .cellPlaceholder
                    cell.lowTemperatureLabel.text = .cellPlaceholder
                    return cell

            }
            cell.dayLabel.text = data.date.getDayName(by: .week, timeZone: data.timezone)
            cell.highTemperatureLabel.text = highTemperatureText
            cell.lowTemperatureLabel.text = lowTemperatureText


            let request = Request.icon(name: iconName)
            ServerAccess.request(urlRequest: request, onSuccess: { (icon) in
                cell.iconImageView.image = icon
            }) { (_) in }
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 414, height: 50)
        }
    }

}
