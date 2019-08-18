//
//  TodaySummaryCell.swift
//  WeatherApp
//
//  Created by yangpc on 18/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

class TodaySummaryCell: UICollectionViewCell, TypeIdentifiable {

    weak var descriptionLabel: UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    func setupViews() {
        let descriptionLabel = UILabel()
        descriptionLabel.frame = contentView.bounds
        descriptionLabel.numberOfLines = 2
        contentView.addSubview(descriptionLabel)
        contentView.backgroundColor = .white
        descriptionLabel.fillSuperview()
        self.descriptionLabel = descriptionLabel
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
