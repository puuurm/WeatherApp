//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by yangpc on 10/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    let hourlyPresenter = HourlyWeatherCellPresenter()

    let dailyPresenter = DailyWeatherCellPresenter()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        return collectionView
    }()

    var locationName: String?
    var weatherData: Response?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.dataSource = self
        collectionView.delegate = self

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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

extension WeatherDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0, 1: return 0
        default: return 1
        }
    }

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionHeader {

            switch indexPath.section {
            case 0:
                let reusableView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: CurrentWeatherHeaderCell.identifier, for: indexPath
                    ) as! CurrentWeatherHeaderCell

                reusableView.locationLabel.text = locationName
                reusableView.summaryLabel.text = weatherData!.currently.summary!
                reusableView.temperatureLabel.text = "\(Int(weatherData!.currently.temperature!))º"
                return reusableView

            case 1:
                let reusableView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath
                    ) as! HourlyCollectionViewCell


                hourlyPresenter.collectionView = reusableView.collectionView
                hourlyPresenter.model = weatherData
                return reusableView

            default: break
            }


        }
        return UICollectionReusableView()
    }



    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 2:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DailyCollectionViewCell.identifier,
                for: indexPath) as! DailyCollectionViewCell
            dailyPresenter.collectionView = cell.collectionView
            dailyPresenter.model = weatherData
            return cell
        default:
            return UICollectionViewCell()
        }

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        switch indexPath.section {
        case 2:
            let dailyDataCount: CGFloat = CGFloat(weatherData?.daily.data.count ?? 0)
            return CGSize(width: view.frame.width, height: (50 * dailyDataCount))
        default:
            return .zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        switch section {
        case 0:
            return CGSize(width: view.frame.width, height: 300)
        case 1:
            return CGSize(width: view.frame.width, height: 120)
        default:
            return .zero
        }

    }

    
}
