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

    enum State {

        case idle
        case requesting
        case loaded
        case error(Error)

    }

    private(set) static var locations = LocationHistory()

    private(set) static var weatherTable: [LocationName: Forecast] = [:]

    private static let group = DispatchGroup()

    static var state: State = .idle

    static func add(location: Location) {
        locations.data.append(location)
        getWeather(for: location)
        notifyGetWeatherFinish()
    }

    static func load(_ object: LocationHistory) {
        locations = object
    }

    static func getAllWeather() {
        locations.data.forEach { (location) in
            getWeather(for: location)
        }
        notifyGetWeatherFinish()
    }

    static func notifyGetWeatherFinish() {
        group.notify(queue: .main) {
            guard case .error(let error) = state else {
                NotificationCenter.default.post(
                    name: .GetWeatherSuccess,
                    object: nil
                )
                return
            }
            NotificationCenter.default.post(
                name: .GetWeatherFailure,
                object: nil
            )
        }
    }

    static func getWeather(for location: Location) {
        group.enter()
        state = .requesting
        let request = Request.weather(coordinate: location.coordinate)

        ServerAccess.request(urlRequest: request, onSuccess: { (weather: Forecast) in
            handleGetAllWeatherSuccess(weather: weather, for: location)
        }) { (error) in
            handleGetWeatherFailure(error)
        }
    }

    static func handleGetAllWeatherSuccess(weather: Forecast, for location: Location) {
        state = .loaded
        weatherTable[location.name] = weather
        group.leave()
    }

    static func handleGetWeatherFailure(_ error: Error) {
        state = .error(error)
        group.leave()

    }
    static var count: Int {
        return locations.data.count
    }

}
