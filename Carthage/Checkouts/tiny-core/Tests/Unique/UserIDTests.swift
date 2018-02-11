//
//  UserIDTests.swift
//  TinyCoreTests
//
//  Created by Roy Hsu on 04/08/2017.
//  Copyright © 2017 TinyWorld. All rights reserved.
//

// MARK: - UserIDTests

import XCTest

internal final class UserIDTests: XCTestCase {

    internal static let allTests = [
        ("testEquatable", testEquatable),
        ("testHashable", testHashable),
        ("testDescription", testDescription)
    ]

    // MARK: Equatable

    internal final func testEquatable() {

        XCTAssertEqual(
            UserID(rawValue: "1"),
            UserID(rawValue: "1")
        )

    }

    // MARK: Hashable

    internal final func testHashable() {

        XCTAssertEqual(
            UserID(rawValue: "1").hashValue,
            "1".hashValue
        )

    }

    // MARK: Description

    internal final func testDescription() {

        XCTAssertEqual(
            UserID(rawValue: "1").description,
            "1".description
        )

    }

}
