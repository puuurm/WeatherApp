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
            return model?.hourly.data.count ?? .zero
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HourlyWeatherCell.identifier,
                for: indexPath) as! HourlyWeatherCell
            let data = model!.hourly.data[indexPath.row]
            cell.temperatureLabel.text = "\(data.temperature!)"
            let request = Request.icon(name: data.icon!)
            ServerAccess.request(urlRequest: request, onSuccess: { (icon) in
                cell.weatherIconImageView.image = icon
            }) { (_) in }
            return cell

        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 80, height: 120)
        }
    }

}
