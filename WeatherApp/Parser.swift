//
//  Parser.swift
//  WeatherApp
//
//  Created by yangpc on 22/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import Foundation

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
