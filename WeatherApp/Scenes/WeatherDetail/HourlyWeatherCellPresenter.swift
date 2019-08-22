//
//  HourlyWeatherCellPresenter.swift
//  WeatherApp
//
//  Created by yangpc on 16/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

extension WeatherDetailViewController {

    class HourlyWeatherCellPresenter: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

        var model: [HourlyWeatherViewData] = [] {
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

        func setContent(_ content: [HourlyWeatherViewData],
                        cellProvider: UICollectionView,
                        indexPath: IndexPath)
            -> HourlyCollectionViewCell
        {
            let reusableView = cellProvider.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath
                ) as! HourlyCollectionViewCell
            self.collectionView = reusableView.collectionView
            model = content
            return reusableView
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return model.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HourlyWeatherCell.identifier,
                for: indexPath) as! HourlyWeatherCell
            let currentItem = model[indexPath.row]

            guard let iconName = currentItem.iconName,
                let temperatureText = currentItem.temperature?.asTemperature
            else {
                cell.temperatureLabel.text = .cellPlaceholder
                cell.timeLabel.text = .cellPlaceholder
                cell.weatherIconImageView.image = UIImage()
                return cell
            }

            cell.timeLabel.text = currentItem.date.getDayName(by: .hour,timeZone: currentItem.timezone)
            cell.temperatureLabel.text = temperatureText
            
            let request = Request.icon(name: iconName)
            ServerAccess.request(urlRequest: request, onSuccess: { (icon) in
                cell.weatherIconImageView.image = icon
            }) { (_) in
                cell.weatherIconImageView.image = UIImage()
            }
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 80, height: 120)
        }

    }

}
