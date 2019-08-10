//
//  WeatherTableViewController.swift
//  WeatherApp
//
//  Created by yangpc on 10/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {

    let reactor = Reactor()

    override func viewDidLoad() {
        super.viewDidLoad()
        reactor.viewController = self
    }

    @IBAction func addLocationButtonAction(_ sender: UIButton) {
        presentLocationSearchViewController()
    }

    private func presentLocationSearchViewController() {
        let locationSearch: LocationSearchViewController = UIStoryboard
            .locationSearch
            .instantiateViewController()
        present(locationSearch, animated: true, completion: nil)
    }
}

