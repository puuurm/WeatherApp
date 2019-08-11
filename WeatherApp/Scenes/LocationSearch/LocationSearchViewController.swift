//
//  LocationSearchViewController.swift
//  WeatherApp
//
//  Created by yangpc on 10/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

class LocationSearchViewController: UIViewController {

    var searchController = UISearchController()
    let filteredViewController = UITableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: filteredViewController)
        searchController.searchBar.showsCancelButton = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        definesPresentationContext = true
    }

}

