//
//  Model.swift
//  WeatherApp
//
//  Created by yangpc on 14/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import Foundation

struct Coordinate: Codable {
    private(set) var latitude: Double
    private(set) var longitude: Double
}

extension Coordinate {
    var asPath: String {
        return "/\(latitude),\(longitude)"
    }
}

struct WeatherTableData {
    var name: String
    var temperature: Int
    var time: Double
}

struct Response: Codable {
    var timezone: String
    var currently: CurrentlyWeatherData
    var hourly: HourlyWeatherInfo
    var daily: DailyWeatherInfo

    var latitude: Double
    var longitude: Double
}


struct DailyWeatherInfo: Codable {
    var data: [DailyWeatherData]
    var summary: String
    var icon: String
}

struct HourlyWeatherInfo: Codable {
    var data: [HourlyWeatherData]
    var summary: String?
    var icon: String?
}

struct CurrentlyWeatherData: CommonWeatherData {
    var temperature: Double?
    var cloudCover: Float?
    var dewPoint: Double?
    var humidity: Float?
    var icon: String?
    var ozone: Float?
    var precipIntensity: Double?
    var precipIntensityError: Double?
    var precipProbability: Double?
    var precipType: String?
    var pressure: Double?
    var summary: String?
    var time: Int!
    var uvIndex: Float?
    var visibility: Float?
    var windBearing: Double?
    var windGust: Float?
    var windSpeed: Float?
    var nearestStormDistance: Double?
    var nearestStormBearing: Double?
}

struct HourlyWeatherData: CommonWeatherData {
    var temperature: Double?
    var cloudCover: Float?
    var dewPoint: Double?
    var humidity: Float?
    var icon: String?
    var ozone: Float?
    var precipIntensity: Double?
    var precipIntensityError: Double?
    var precipProbability: Double?
    var precipType: String?
    var pressure: Double?
    var summary: String?
    var time: Int!
    var uvIndex: Float?
    var visibility: Float?
    var windBearing: Double?
    var windGust: Float?
    var windSpeed: Float?
    var apparentTemperature: Double?
    var precipAccumulation: Double?
}

struct DailyWeatherData: CommonWeatherData {
    var temperature: Double?
    var cloudCover: Float?
    var dewPoint: Double?
    var humidity: Float?
    var icon: String?
    var ozone: Float?
    var precipIntensity: Double?
    var precipIntensityError: Double?
    var precipProbability: Double?
    var precipType: String?
    var pressure: Double?
    var summary: String?
    var time: Int!
    var uvIndex: Float?
    var visibility: Float?
    var windBearing: Double?
    var windGust: Float?
    var windSpeed: Float?
    var apparentTemperatureHigh: Double?
    var apparentTemperatureHighTime: Double?
    var apparentTemperatureLow: Double?
    var apparentTemperatureLowTime: Double?
    var apparentTemperatureMax: Double?
    var apparentTemperatureMaxTime: Double?
    var apparentTemperatureMin: Double?
    var apparentTemperatureMinTime: Double?
    var moonPhase: Double?
    var precipAccumulation: Double?
    var precipIntensityMax: Double?
    var precipIntensityMaxTime: Double?
    var sunriseTime: Double?
    var sunsetTime: Double?
    var temperatureHigh: Double?
    var temperatureHighTime: Double?
    var temperatureLow: Double?
    var temperatureLowTime: Double?
    var temperatureMax: Double?
    var temperatureMaxTime: Double?
    var temperatureMin: Double?
    var temperatureMinTime: Double?
    var uvIndexTime: Double?
    var windGustTime: Double?
}

protocol CommonWeatherData: Codable {
    var temperature: Double? { get set }
    var cloudCover: Float? { get set }
    var dewPoint: Double? { get set }
    var humidity: Float? { get set }
    var icon: String? { get set }
    var ozone: Float? { get set }
    var precipIntensity: Double? { get set }
    var precipIntensityError: Double? { get set }
    var precipProbability: Double? { get set }
    var precipType: String? { get set }
    var pressure: Double? { get set }
    var summary: String? { get set }
    var time: Int! { get set }
    var uvIndex: Float? { get set }
    var visibility: Float? { get set }
    var windBearing: Double? { get set }
    var windGust: Float? { get set }
    var windSpeed: Float? { get set }
}
