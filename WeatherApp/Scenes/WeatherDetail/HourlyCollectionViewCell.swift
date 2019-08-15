//
//  HourlyCollectionViewCell.swift
//  WeatherApp
//
//  Created by yangpc on 15/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func setupViews() {
        contentView.addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.register(
            HourlyWeatherCell.self,
            forCellWithReuseIdentifier: HourlyWeatherCell.identifier
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {

    public func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
}
