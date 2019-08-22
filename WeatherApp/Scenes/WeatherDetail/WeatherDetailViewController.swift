//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by yangpc on 10/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    private let pagingPresenter = PagingPresenter()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        pagingPresenter.collectionView = collectionView
        pagingPresenter.locationName = locationName
        return collectionView
    }()

    private var locationName: LocationName
    private var index: Int

    init(_ locationName: LocationName, index: Int) {
        self.locationName = locationName
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        registerCollectionViewCell()
        pagingPresenter.setScrollOffset(row: index)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }

    private func registerCollectionViewCell() {
        collectionView.register(
            WeatherDetailCell.self,
            forCellWithReuseIdentifier: WeatherDetailCell.identifier
        )
    }

}
