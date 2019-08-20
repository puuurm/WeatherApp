//
//  WeatherDetailPresenter.swift
//  WeatherApp
//
//  Created by yangpc on 18/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

extension WeatherDetailViewController {

    class Presenter: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

        private let hourlyPresenter = HourlyWeatherCellPresenter()

        private let dailyPresenter = DailyWeatherCellPresenter()

        private let todayPresenter = TodayWeatherDetailCellPresenter()

        private let screenWidth: CGFloat = UIScreen.main.bounds.width

        weak var collectionView: UICollectionView? {
            didSet {
                collectionView?.dataSource = self
                collectionView?.delegate = self
            }
        }

        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 5
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            switch section {
            case 0, 1: return 0
            default: return 1
            }
        }

        public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

            let currentLocation = WeatherRepository.locations.data[indexPath.row]
            let weatherData = WeatherRepository.weatherTable[currentLocation.name]

            if kind == UICollectionView.elementKindSectionHeader {

                switch indexPath.section {
                case 0:
                    let reusableView = collectionView.dequeueReusableSupplementaryView(
                        ofKind: kind,
                        withReuseIdentifier: CurrentWeatherHeaderCell.identifier, for: indexPath
                        ) as! CurrentWeatherHeaderCell

                    guard let weatherData = weatherData
                        else {
                            reusableView.locationLabel.text = currentLocation.name
                            reusableView.summaryLabel.text = "-"
                            reusableView.temperatureLabel.text = "-"
                            return reusableView
                    }

                    reusableView.locationLabel.text = currentLocation.name
                    reusableView.summaryLabel.text = weatherData.currently.summary!
                    reusableView.temperatureLabel.text = "\(Int(weatherData.currently.temperature!))º"
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

            let currentLocation = WeatherRepository.locations.data[indexPath.row]
            let weatherData = WeatherRepository.weatherTable[currentLocation.name]

            switch indexPath.section {
            case 2:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: DailyCollectionViewCell.identifier,
                    for: indexPath) as! DailyCollectionViewCell
                dailyPresenter.collectionView = cell.collectionView
                dailyPresenter.model = weatherData
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TodaySummaryCell.identifier,
                    for: indexPath) as! TodaySummaryCell
                cell.descriptionLabel?.text = "오늘: 현재 날씨. 현재 기온은 \(weatherData?.currently.temperature ?? 0)이며 오늘 예상 최고 기온은 \(weatherData?.currently.temperature ?? 0)입니다."
                return cell
            case 4:
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TodayWeatherDetailCollectionViewCell.identifier,
                    for: indexPath) as! TodayWeatherDetailCollectionViewCell
                todayPresenter.collectionView = cell.collectionView
                todayPresenter.model = weatherData
                return cell
            default:
                return UICollectionViewCell()
            }

        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            let currentLocation = WeatherRepository.locations.data[indexPath.row]
            let weatherData = WeatherRepository.weatherTable[currentLocation.name]

            switch indexPath.section {
            case 2:
                let dailyDataCount: CGFloat = CGFloat(weatherData?.daily.data.count ?? 0)
                return CGSize(width: screenWidth, height: (50 * dailyDataCount))
            case 3:
                return CGSize(width: screenWidth, height: 100)
            case 4:
                return CGSize(width: screenWidth, height: 50 * 5)
            default:
                return .zero
            }
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

            switch section {
            case 0:
                return CGSize(width: screenWidth, height: 300)
            case 1:
                return CGSize(width: screenWidth, height: 120)
            default:
                return .zero
            }

        }


    }

}
