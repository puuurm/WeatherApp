//
//  Location.swift
//  WeatherApp
//
//  Created by yangpc on 22/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import Foundation

struct LocationHistory: Codable {
    var data: [Location] = []
}

struct Coordinate: Codable {
    private(set) var latitude: Double
    private(set) var longitude: Double
}

extension Coordinate {
    var asPath: String {
        return "/\(latitude),\(longitude)"
    }
}

struct Location: Codable {
    var coordinate: Coordinate
    var name: LocationName
}
