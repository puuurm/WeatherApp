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
        let coordinate = Coordinate(latitude: 37.5868661, longitude: 126.7578747)
        let expectation = self.expectation(description: #function)

        ServerAccess
            .request(coordinate: coordinate, onSuccess: { (jsonString) in
                XCTAssertNotNil(jsonString)
                expectation.fulfill()
            }) { (error) in }

        waitForExpectations(timeout: 3)
    }

    func testServerRequestClientError() {
        let coordinate = Coordinate(latitude: 11111111, longitude: 11111)
        let expectation = self.expectation(description: #function)
        ServerAccess
            .request(coordinate: coordinate, onSuccess: { (jsonString) in
            }) { (error) in
                XCTAssertNotNil(error)
                expectation.fulfill()
        }

        waitForExpectations(timeout: 3)
    }

    func testDarkSkyURL() {
        let resultURL: String = "https://api.darksky.net/forecast/"
        XCTAssertTrue(Bundle.main.baseURL == resultURL)
    }


}
