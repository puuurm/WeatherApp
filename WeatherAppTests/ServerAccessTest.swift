//
//  ServerAccessTest.swift
//  WeatherAppTests
//
//  Created by yangpc on 13/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import XCTest
@testable import WeatherApp

class ServerAccessTest: XCTestCase {

    func testServerRequestSuccess() {
        let latitude: Double = 37.5868661
        let longitude: Double = 126.7578747
        let coordinate = Coordinate(latitude: latitude, longitude: longitude)
        let expectation = self.expectation(description: #function)

        let request = Request.weather(coordinate: coordinate)
        
        ServerAccess
            .request(urlRequest: request, onSuccess: { (response: Response) in
                XCTAssertEqual(response.latitude, latitude)
                XCTAssertEqual(response.longitude, longitude)
                print(response.timezone)
                expectation.fulfill()
            }, onFailure: { (error) in })

        waitForExpectations(timeout: 3)
    }

    func testServerRequestClientError() {
        let coordinate = Coordinate(latitude: 11111111, longitude: 11111)
        let expectation = self.expectation(description: #function)

        let request = Request.weather(coordinate: coordinate)

        ServerAccess
            .request(urlRequest: request, onSuccess: { (jsonString: Response) in
            }) { (error) in
                XCTAssertNotNil(error)
                expectation.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func testResponseCache() {
        let latitude: Double = 37.5868661
        let longitude: Double = 126.7578747
        let coordinate = Coordinate(latitude: latitude, longitude: longitude)
        let expectation = self.expectation(description: #function)

        let request = Request.weather(coordinate: coordinate)

        ServerAccess
            .request(urlRequest: request, onSuccess: { (response: Response) in
                XCTAssertEqual(response.latitude, latitude)
                XCTAssertEqual(response.longitude, longitude)

                let cachedResponse = URLCache.shared.cachedResponse(for: request)
                let object = try! Serializer<Response>.serialize(data: cachedResponse!.data, error: nil)
                print(object)
                XCTAssertEqual(object.latitude, response.latitude)
                expectation.fulfill()
            }, onFailure: { (error) in })

        waitForExpectations(timeout: 5)
    }

    func testDarkSkyURL() {
        let resultURL: String = "https://api.darksky.net/forecast/"
        XCTAssertTrue(Bundle.main.baseURL == resultURL)
    }


}
