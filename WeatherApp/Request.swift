//
//  Request.swift
//  WeatherApp
//
//  Created by yangpc on 22/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import Foundation

struct Request {

    static func weather(coordinate: Coordinate) -> URLRequest {
        let urlString = Bundle.main.forecastURL
            + DarkSkyAPI.key
            + coordinate.asPath
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }

    static func icon(name: String) -> URLRequest {
        let urlString = Bundle.main.iconURL
            + name + ".png"
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }

}
