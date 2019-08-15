//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by yangpc on 10/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var locationName: String?
    var weatherData: Response?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}
