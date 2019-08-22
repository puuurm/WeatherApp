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

    var asPercent: String {
        let percent = self * 100
        return percent.asString + "%"
    }

    var asMilibar: String {
        return asString + "mb"
    }

    var asMMPerHour: String {
        return asString + "mm/h"
    }

    var asKilometers: String {
        return asString + "km"
    }

    var asMetersPerSecond: String {
        return asString + "m/h"
    }

    var asDegrees: String {
        switch self {
        case 360, 0..<1: return"북풍"
        case 1..<90: return "북동풍"
        case 90..<91: return "동풍"
        case 91..<180: return "남동풍"
        case 180..<181: return "남풍"
        case 181..<270: return "남서풍"
        case 270: return "서풍"
        default: return "북서풍"
        }
    }
}

enum DateFormat: String {
    case week = "EEEE"
    case hour = "h a"
    case time = "h:mm a"
}

extension String {
    static let cellPlaceholder: String = "-"
}
