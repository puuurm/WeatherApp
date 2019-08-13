//
//  ServerAccess.swift
//  WeatherApp
//
//  Created by yangpc on 13/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import Foundation

struct Coordinate: Codable {
    private(set) var latitude: Double
    private(set) var longitude: Double
}

enum ServerAccess {

    static let defaultSession = URLSession(configuration: .default)

    static func request(coordinate: Coordinate,
                        onSuccess: @escaping (String) -> Void,
                        onFailure: @escaping (Error) -> Void) {

        let urlString = Bundle.main.baseURL + DarkSky.apiKey + "/\(coordinate.latitude),\(coordinate.longitude)"

        guard let url = URL(string: urlString) else { return }

        defaultSession.dataTask(with: url) { (data, response, error) in

            guard error == nil else {
                onFailure(error!)
                return
            }

            guard let data = data, !data.isEmpty else {
                onFailure(MyError.responseError)
                return
            }

            do {

                let jsonObject = try JSONSerialization.jsonObject(with: data) as! [String : Any]
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject)
                let jsonString = String(data: jsonData, encoding: .utf8) ?? ""
                let data = jsonString.data(using: .utf8)!

                if let error = try? JSONDecoder().decode(ServerError.self, from: data) {
                    onFailure(MyError.serverError(code: error.code, error: error.error))
                    return
                }
                onSuccess(jsonString)
            } catch {
                onFailure(error)
            }
        }.resume()
    }

}

enum MyError: Error {
    case responseError
    case serverError(code: Int, error: String)
}

struct ServerError: Codable {
    var code: Int
    var error: String
}


enum DarkSky {
    static let apiKey = "8c97b162f1c44e6c82c6505e6a6ec19e"
}
