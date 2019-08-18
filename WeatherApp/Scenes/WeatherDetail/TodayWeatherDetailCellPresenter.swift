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

        private let titleList: [String] = [
            "일출", "일몰", "비 올 확률", "습도", "바람", "체감", "강수량", "기압", "가시거리", "자외선 지수"
        ]
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
            return titleList.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TodayWeatherDetailCell.identifier,
                for: indexPath) as! TodayWeatherDetailCell
            cell.titleLabel.text = titleList[indexPath.row]
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width / 2, height: 50)
        }
    }

}
