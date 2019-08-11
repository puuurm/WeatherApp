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
    let filteredViewController = SuggestionsTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: filteredViewController)
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController.searchResultsUpdater = filteredViewController
        definesPresentationContext = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

extension LocationSearchViewController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }

}
