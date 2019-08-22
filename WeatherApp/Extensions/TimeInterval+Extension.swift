//
//  TimeInterval+Extension.swift
//  WeatherApp
//
//  Created by yangpc on 23/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import Foundation

extension TimeInterval {
    var asDate: Date {
        return Date(timeIntervalSince1970: self)
    }
}
