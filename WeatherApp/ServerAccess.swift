//
//  ServerAccess.swift
//  WeatherApp
//
//  Created by yangpc on 13/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

class ServerAccess {

    private static let defaultSession = URLSession(configuration: .default)

    static func request<Model: Decodable>(urlRequest: URLRequest,
                                          onSuccess: @escaping (Model) -> Void,
                                          onFailure: @escaping (Error) -> Void) {

        defaultSession.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                do {
                    let object = try Serializer<Model>.serialize(data: data, error: error)
                    onSuccess(object)
                } catch {
                    onFailure(error)
                }

            }
        }.resume()
    }

    static func request(urlRequest: URLRequest,
                        onSuccess: @escaping (UIImage?) -> Void,
                        onFailure: @escaping (Error) -> Void) {

        defaultSession.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                do {
                    if let data = data, let image = UIImage(data: data) {
                        onSuccess(image)
                    } else {
                        onSuccess(nil)
                    }
                } catch {
                    onFailure(error)
                }
            }
        }.resume()
    }

}

enum DarkSkyAPI {
    static let key = "8c97b162f1c44e6c82c6505e6a6ec19e"
}
