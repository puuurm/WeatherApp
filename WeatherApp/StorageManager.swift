//
//  StorageManager.swift
//  WeatherApp
//
//  Created by yangpc on 20/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import Foundation

final class StorageManager {

    private let fileManager: FileManager
    private let baseURL: URL

    init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
        baseURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first ?? fileManager.temporaryDirectory
    }

    func setObject<T: Codable>(_ object: T, forKey key: String) throws {
        let objectURL = url(key: key)
        do {
            let data = try JSONEncoder().encode(object)
            try data.write(to: objectURL, options: .atomicWrite)
        } catch {
            throw error
        }
    }

    func object<T: Codable>(ofType type: T.Type, forKey key: String) throws -> T {
        let fileURL = url(key: key)
        do {
            let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            throw error
        }
    }

    func deleteObject(forKey key: String) throws {
        let fileURL = url(key: key)
        do {
            try fileManager.removeItem(at: fileURL)
        } catch {
            throw error
        }
    }

    private func url(key: String) -> URL {
        return baseURL.appendingPathComponent(key)
    }

}
