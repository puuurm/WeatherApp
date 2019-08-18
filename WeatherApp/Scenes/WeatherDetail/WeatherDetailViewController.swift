//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by yangpc on 10/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    private let presenter = Presenter()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        presenter.collectionView = collectionView
        return collectionView
    }()

    var locationName: String?
    var weatherData: Response?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.fillSuperview()

        collectionView.register(
            UINib(nibName: CurrentWeatherHeaderCell.identifier, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CurrentWeatherHeaderCell.identifier
        )

        collectionView.register(
            HourlyCollectionViewCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HourlyCollectionViewCell.identifier
        )

        collectionView.register(
            DailyCollectionViewCell.self,
            forCellWithReuseIdentifier: DailyCollectionViewCell.identifier
        )

        collectionView.register(
            TodaySummaryCell.self,
            forCellWithReuseIdentifier: TodaySummaryCell.identifier
        )

        collectionView.register(
            TodayWeatherDetailCollectionViewCell.self,
            forCellWithReuseIdentifier: TodayWeatherDetailCollectionViewCell.identifier
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.locationName = locationName
        presenter.weatherData = weatherData
    }

}
