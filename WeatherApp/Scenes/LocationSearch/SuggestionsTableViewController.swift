//
//  SuggestionsTableViewController.swift
//  WeatherApp
//
//  Created by yangpc on 12/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit
import MapKit

class SuggestionsTableViewController: UITableViewController {

    private let searchCompleter = MKLocalSearchCompleter()
    private var filteredLocations: [MKLocalSearchCompletion]?

    var onDismiss: ((SuggestionsTableViewController, Location) -> Void)?

    convenience init() {
        self.init(style: .plain)
        searchCompleter.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.register(
            SuggestionsLocationTableViewCell.self,
            forCellReuseIdentifier: SuggestionsLocationTableViewCell.identifier
        )

    }

    private func search(for suggestedCompletion: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: suggestedCompletion)
        let localSearch = MKLocalSearch(request: searchRequest)
        localSearch.start { [weak self] (response, error) in
            guard let weakSelf = self else { return }

            guard error == nil else {
                return
            }

            guard let mapItem = response?.mapItems.first
            else {
                return
            }

            let locationName = mapItem.placemark.name ?? "Unknown Place"
            let latitude = mapItem.placemark.coordinate.latitude
            let longitude = mapItem.placemark.coordinate.longitude

            let coordinate = Coordinate(latitude: latitude, longitude: longitude)
            let location = Location(coordinate: coordinate, name: locationName)

            weakSelf.dismiss(animated: false, completion: {
                weakSelf.onDismiss?(weakSelf, location)
            })
        }
    }


}

extension SuggestionsTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLocations?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SuggestionsLocationTableViewCell.identifier, for: indexPath)
        let filteredResult = filteredLocations?[indexPath.row]
        cell.textLabel?.text = filteredResult?.title
        cell.detailTextLabel?.text = filteredResult?.subtitle
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedLocation = filteredLocations?[indexPath.row] else { return }
        search(for: selectedLocation)
    }

}

extension SuggestionsTableViewController: MKLocalSearchCompleterDelegate {

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        filteredLocations = completer.results.filter { !$0.subtitle.isEmpty }
        tableView.reloadData()
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
    }
}

extension SuggestionsTableViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        searchCompleter.queryFragment = searchController.searchBar.text ?? ""
    }
}

class SuggestionsLocationTableViewCell: UITableViewCell, TypeIdentifiable {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
