//
//  UserTests.swift
//  TinyCoreTests
//
//  Created by Roy Hsu on 22/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - UserTests

import XCTest

internal final class UserTests: XCTestCase {

    internal static let allTests = [
        ("testEquatable", testEquatable),
        ("testDecodable", testDecodable),
        ("testEncodable", testEncodable)
    ]

    // MARK: Equatable

    internal final func testEquatable() {

        XCTAssertEqual(
            User(
                id: UserID(rawValue: "1"),
                name: "Roy Hsu"
            ),
            User(
                id: UserID(rawValue: "1"),
                name: "Roy Hsu"
            )
        )

    }

    // MARK: Decodable

    internal final func testDecodable() {

        let jsonObject: [String: Any] = [
            "id": "1",
            "name": "Roy Hsu"
        ]

        do {

            let data = try JSONSerialization.data(withJSONObject: jsonObject)

            let user = try JSONDecoder().decode(
                User.self,
                from: data
            )

            XCTAssertEqual(
                user,
                User(
                    id: UserID(rawValue: "1"),
                    name: "Roy Hsu"
                )
            )

        }
        catch { XCTFail("\(error)") }

    }

    // MARK: Encodable

    internal final func testEncodable() {

        let user = User(
            id: UserID(rawValue: "1"),
            name: "Roy Hsu"
        )

        do {

            let data = try JSONEncoder().encode(user)

            let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any]

            XCTAssertEqual(
                jsonObject?["id"] as? String,
                "1"
            )

            XCTAssertEqual(
                jsonObject?["name"] as? String,
                "Roy Hsu"
            )

        }
        catch { XCTFail("\(error)") }

    }

}
