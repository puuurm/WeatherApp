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
            cell.highTemperatureLabel.text = "\(data.apparentTemperatureHigh ?? .zero)"
            cell.lowTemperatureLabel.text = "\(data.apparentTemperatureLow ?? .zero)"
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 414, height: 50)
        }
    }

}
