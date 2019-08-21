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

        var model: Response? {
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

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return model?.daily.data.count ?? .zero
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DailyWeatherCell.identifier,
                for: indexPath) as! DailyWeatherCell
            let data = model!.daily.data[indexPath.row]
            let request = Request.icon(name: data.icon!)
            ServerAccess.request(urlRequest: request, onSuccess: { (icon) in
                cell.iconImageView.image = icon
            }) { (_) in }
            let date = Date(timeIntervalSince1970: data.time)
            cell.dayLabel.text = date.getDayName(by: .week, timeZone: model!.timezone)
            cell.highTemperatureLabel.text = data.temperatureHigh!.asString
            cell.lowTemperatureLabel.text = data.temperatureLow!.asString
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 414, height: 50)
        }
    }

}
