//
//  TypeIdentifiable.swift
//  WeatherApp
//
//  Created by yangpc on 16/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import Foundation

protocol TypeIdentifiable {

    static var identifier: String { get }

}

extension TypeIdentifiable {

    static var identifier: String { return "\(Self.self)" }

}
