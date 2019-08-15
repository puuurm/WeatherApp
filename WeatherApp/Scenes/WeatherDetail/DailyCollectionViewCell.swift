//
//  DailyCollectionViewCell.swift
//  WeatherApp
//
//  Created by yangpc on 16/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

class DailyCollectionViewCell: UICollectionViewCell {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func setupViews() {
        contentView.addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.register(
            DailyWeatherCell.self,
            forCellWithReuseIdentifier: HourlyWeatherCell.identifier
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
