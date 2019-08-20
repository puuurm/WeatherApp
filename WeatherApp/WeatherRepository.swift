//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by yangpc on 20/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import Foundation

typealias LocationName = String

extension Notification.Name {

    static let GetWeatherSuccess = Notification.Name("GetWeatherSuccess")

    static let GetWeatherFailure = Notification.Name("GetWeatherFailure")

}

class WeatherRepository {


    private(set) static var locations = LocationHistory()

    private(set) static var weatherTable: [LocationName: Response] = [:]

    private static let group = DispatchGroup()

    static var count: Int {
        return locations.data.count
    }

    static func load(_ object: LocationHistory) {
        locations = object
    }
}
