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
        collectionView.backgroundColor = .white
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
        view.backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
        setupCollectionView()
        registerCollectionViewCell()
        pagingPresenter.setScrollOffset(row: index)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)]
        )
    }

    private func setupToolbar() {
        let barbutton = UIBarButtonItem(
            barButtonSystemItem: .stop,
            target: self,
            action: #selector(popViewController(_:)))
        toolbarItems = [barbutton]
        navigationController?.setToolbarHidden(false, animated: false)
    }

    private func registerCollectionViewCell() {
        collectionView.register(
            WeatherDetailCell.self,
            forCellWithReuseIdentifier: WeatherDetailCell.identifier
        )
    }

    @objc func popViewController(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}
