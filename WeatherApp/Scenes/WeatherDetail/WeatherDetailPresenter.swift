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

        private enum Constant {
            static let screenWidth: CGFloat = UIScreen.main.bounds.width
        }

        private let currentPresenter = CurrentWeatherHeaderPresenter()

        private let hourlyPresenter = HourlyWeatherCellPresenter()

        private let dailyPresenter = DailyWeatherCellPresenter()

        private let summaryPresenter = SummaryWeatherPresenter()

        private let todayPresenter = TodayWeatherDetailCellPresenter()

        var currentHeaderData: CurrentWeatherViewData?

        var hourlyList: [HourlyWeatherViewData] = []

        var dailyList: [DailyWeatherViewData] = []

        var summaryViewData: SummaryWeatherViewData?

        weak var collectionView: UICollectionView? {
            didSet {
                collectionView?.dataSource = self
                collectionView?.delegate = self
            }
        }

        var locationName: String = .cellPlaceholder {
            didSet {
                collectionView?.reloadData()
            }
        }

        var weatherData: Forecast? {
            return WeatherRepository.weatherTable[locationName]
        }

        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return Section.numberOfSections
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return Section(rawValue: section)?.numberOfRows ?? 0
        }

        public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

            switch Section(rawValue: indexPath.section) {
            case .currentHeader?:
                return currentPresenter.setContent(
                    currentHeaderData,
                    cellProvider: collectionView,
                    indexPath: indexPath)

            case .hourlyHeader?:
                return hourlyPresenter.setContent(
                    hourlyList,
                    cellProvider: collectionView,
                    indexPath: indexPath
                )

            default: break
            }
            return UICollectionReusableView()
        }



        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            switch Section(rawValue: indexPath.section) {
            case .daily?:
                return dailyPresenter.setContent(
                    dailyList,
                    cellProvider: collectionView,
                    indexPath: indexPath)

            case .todaySummary?:
                return summaryPresenter.setContent(
                    summaryViewData,
                    cellProvider: collectionView,
                    indexPath: indexPath)

            case .todayDetail?:
                return todayPresenter.setContent(
                    summaryViewData,
                    cellProvider: collectionView,
                    indexPath: indexPath)
            default:
                return UICollectionViewCell()
            }

        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            switch Section(rawValue: indexPath.section) {
            case .daily?:
                let dailyDataCount: CGFloat = CGFloat(weatherData?.daily.data.count ?? 0)
                return CGSize(width: Constant.screenWidth, height: (50 * dailyDataCount))
            case .todaySummary?:
                return CGSize(width: Constant.screenWidth, height: 100)
            case .todayDetail?:
                return CGSize(width: Constant.screenWidth, height: 50 * 5)
            default:
                return .zero
            }
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

            switch Section(rawValue: section) {
            case .currentHeader?:
                return CGSize(width: Constant.screenWidth, height: 300)
            case .hourlyHeader?:
                return CGSize(width: Constant.screenWidth, height: 120)
            default:
                return .zero
            }
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return .zero
        }

    }
}

extension WeatherDetailViewController.Presenter {
    enum Section: Int {
        case currentHeader
        case hourlyHeader
        case daily
        case todaySummary
        case todayDetail

        var numberOfRows: Int {
            switch rawValue {
            case 0, 1: return 0
            default: return 1
            }
        }

        static var numberOfSections: Int { return 5 }
    }
}
