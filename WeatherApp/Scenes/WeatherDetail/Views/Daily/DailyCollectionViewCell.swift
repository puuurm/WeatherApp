//
//  DailyCollectionViewCell.swift
//  WeatherApp
//
//  Created by yangpc on 16/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

class DailyCollectionViewCell: UICollectionViewCell, TypeIdentifiable {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .white
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    func setupViews() {
        contentView.addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.register(
            UINib(nibName: DailyWeatherCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: DailyWeatherCell.identifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
