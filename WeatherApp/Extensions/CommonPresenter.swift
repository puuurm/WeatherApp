//
//  CommonPresenter.swift
//  WeatherApp
//
//  Created by yangpc on 21/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import Foundation

extension Date {
    func getDayName(by dateFormat: DateFormat, timeZone: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        dateFormatter.dateFormat = dateFormat.rawValue
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: self)
    }
}

extension Double {
    var asTemperature: String {
        return asString + "º"
    }

    var asString: String {
        return String(format:"%.f", self)
    }
}

enum DateFormat: String {
    case week = "EEEE"
    case hour = "h a"
    case time = "h:mm a"
}
