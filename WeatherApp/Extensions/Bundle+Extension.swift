//
//  Bundle+Extension.swift
//  WeatherApp
//
//  Created by yangpc on 14/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import Foundation

extension Bundle {

    var baseURL: String {
        let darkSkyDic = infoDictionary![.keyDarkSky] as! [String: Any]
        let host = darkSkyDic[.keyHost] as! String
        let path = darkSkyDic[.keyPath] as! String

        var urlString: String = .protocolName
        urlString += host
        urlString += path
        return urlString
    }

}

fileprivate extension String {

    static let protocolName = "https://"

    static let keyDarkSky = "DarkSky"
    static let keyHost = "Host"
    static let keyPath = "Path"

}
