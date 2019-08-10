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

    // MARK: Footer View
    var onTapAddLocationButton: ((WeatherTableViewController, UIButton) -> Void)!

    @IBOutlet weak var addLocationButton: UIButton!

    @IBAction func addLocationAction(_ sender: UIButton) {
        onTapAddLocationButton!(self, sender)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reactor.viewController = self
    }


}

