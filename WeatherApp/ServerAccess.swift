//
//  ServerAccess.swift
//  WeatherApp
//
//  Created by yangpc on 13/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import Foundation

class ServerAccess {

    private static let defaultSession = URLSession(configuration: .default)

    static func request<Model: Decodable>(coordinate: Coordinate,
                        onSuccess: @escaping (Model) -> Void,
                        onFailure: @escaping (Error) -> Void) {

        let urlString = Bundle.main.baseURL + DarkSky.apiKey + "/\(coordinate.latitude),\(coordinate.longitude)"

        guard let url = URL(string: urlString) else { return }

        defaultSession.dataTask(with: url) { (data, response, error) in
            do {
                let object = try Serializer<Model>.serialize(data: data, error: error)
                onSuccess(object)
            } catch {
                onFailure(error)
            }
        }.resume()
    }

}

enum GeneralError: Error {
    case responseError
    case serializeError(data: Data?)
}

struct ServerError: Codable {
    var code: Int
    var error: String
}


enum DarkSky {
    static let apiKey = "8c97b162f1c44e6c82c6505e6a6ec19e"
}

class Serializer<Model: Decodable> {

    static func serialize(data: Data?, error: Error?) throws -> Model {
        guard error == nil else { throw error! }

        guard let data = data, !data.isEmpty else {
            throw GeneralError.responseError
        }

        do {
            let jsonDictionary = try getDictionary(from: data)
            let jsonString = makeJson(dictionary: jsonDictionary)
            return try jsonParse(json: jsonString)
        } catch {
            throw GeneralError.serializeError(data: data)
        }
    }

    static private func getDictionary(from fromData: Data) throws -> [String: Any] {
        return try JSONSerialization.jsonObject(with: fromData, options: []) as! [String: Any]
    }

    static private func makeJson(dictionary: [String : Any]) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
            return ""
        } catch {
            return ""
        }
    }

    static private func jsonParse(json: String) throws -> Model {
        guard let data = json.data(using: .utf8) else {
            throw GeneralError.serializeError(data: nil)
        }
        return try JSONDecoder().decode(Model.self, from: data)
    }
}
