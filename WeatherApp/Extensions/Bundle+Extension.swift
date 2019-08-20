//
//  Bundle+Extension.swift
//  WeatherApp
//
//  Created by yangpc on 14/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import Foundation

extension Bundle {

    var forecastURL: String {
        let darkSkyDic = infoDictionary![.keyDarkSky] as! [String: Any]
        let host = darkSkyDic[.keyHost] as! [String: Any]
        let apiHost = host[.keyAPI] as! String
        let path = darkSkyDic[.keyPath] as! [String: Any]
        let forcastPath = path[.keyForcastPath] as! String

        var urlString: String = .protocolName
        urlString += apiHost
        urlString += forcastPath
        return urlString
    }

    var iconURL: String {
        let darkSkyDic = infoDictionary![.keyDarkSky] as! [String: Any]
        let host = darkSkyDic[.keyHost] as! [String: Any]
        let resourceHost = host[.keyResorce] as! String
        let path = darkSkyDic[.keyPath] as! [String: Any]
        let resorcePath = path[.keyResorcePath] as! String

        var urlString: String = .protocolName
        urlString += resourceHost
        urlString += resorcePath
        return urlString
    }
}

fileprivate extension String {

    static let protocolName = "https://"

    static let keyDarkSky = "DarkSky"
    static let keyHost = "Host"
    static let keyPath = "Path"
    static let keyAPI = "API"
    static let keyResorce = "Resource"
    static let keyResorcePath = "Resource"
    static let keyForcastPath = "Forecast"

}
