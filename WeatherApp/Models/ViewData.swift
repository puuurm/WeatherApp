//
//  ViewData.swift
//  WeatherApp
//
//  Created by yangpc on 22/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import Foundation

struct CurrentWeatherViewData {
    var day: Date
    var timezone: String
    var highTemperature: Double?
    var lowTemperature: Double?
    var locationName: String
    var summary: String?
    var temperature: Double?
}

struct HourlyWeatherViewData {
    var date: Date
    var timezone: String
    var temperature: Double?
    var iconName: String?
}

struct DailyWeatherViewData {
    var date: Date
    var timezone: String
    var iconName: String?
    var highTemperature: Double?
    var lowTemperature: Double?
}

struct SummaryWeatherViewData {
    var summary: String?
    var highTemperature: Double?
    var lowTemperature: Double?
}

struct TodayDetailWeatherViewData {
    var timezone: String
    var sunriseTime: Date?
    var sunsetTime: Date?
    var humidity: Double?
    var windBearing: Double?
    var windSpeed: Double?
    var apparentTemperature: Double?
    var precipProbability: Double?
    var precipIntensity: Double?
    var precipType: String?
    var pressure: Double?
    var uvIndex: Double?
    var visibility: Double?
}
