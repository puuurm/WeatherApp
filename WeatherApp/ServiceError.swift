//
//  ServiceError.swift
//  WeatherApp
//
//  Created by yangpc on 22/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import Foundation

enum GeneralError: Error {
    case responseError
    case invalidURL
    case serializeError(data: Data?)
}

struct ServerError: Codable {
    var code: Int
    var error: String
}
