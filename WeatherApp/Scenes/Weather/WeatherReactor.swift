//
//  WeatherReactor.swift
//  WeatherApp
//
//  Created by yangpc on 11/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

extension WeatherTableViewController {

    class Reactor {

        weak var viewController: WeatherTableViewController! {
            didSet {
                setUpViewController()
            }
        }

        private func setUpViewController() {
        }

    }

}
