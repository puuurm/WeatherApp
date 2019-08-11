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

    convenience init() {
        self.init(style: .plain)
        searchCompleter.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(
            SuggestionsLocationTableViewCell.self,
            forCellReuseIdentifier: SuggestionsLocationTableViewCell.identifier
        )
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

class SuggestionsLocationTableViewCell: UITableViewCell {

    static let identifier: String = "\(SuggestionsLocationTableViewCell.self)"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
