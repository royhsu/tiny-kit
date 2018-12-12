//
//  ModelTests.swift
//  TinyKitTests
//
//  Created by Roy Hsu on 2018/12/12.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - ModelTestss

import XCTest

@testable import TinyKit

internal final class ModelTestss: XCTestCase {

    internal final var observation: Observation?

    internal final func testInitialize() {

        let model = Model<String>()

        XCTAssertNil(model.value)

        XCTAssert(model.rules.isEmpty)

        XCTAssert(model.isRequired)

    }

    internal final func testValidate() {

        var model = Model<String>()

        XCTAssertThrowsError(
            try model.validate()
        ) { error in XCTAssert(error is NonNullError) }

        model.value = "hello"

        XCTAssertEqual(
            try model.validate(),
            "hello"
        )

    }

    internal final func testObservedResult() {

        let promise1 = expectation(description: "Get a failure after setting an empty string.")

        let promise2 = expectation(description: "Get a success after setting an non-empty string.")

        var model = Model<String>(
            rules: [ .nonEmpty ]
        )

        observation = model.observe { result in

            switch result {

            case let .success(value):

                promise2.fulfill()

                XCTAssertEqual(
                    value,
                    "hello"
                )

            case let .failure(error):

                promise1.fulfill()

                if let error = error as? ModelError<String> {
                
                    XCTAssertEqual(
                        error.currentValue,
                        ""
                    )
                    
                    XCTAssertEqual(
                        error.errors.count,
                        1
                    )
                    
                    XCTAssert(error.errors[0] is NonEmptyError)
                    
                }
                else { XCTFail("Unexpected error: \(error)") }

            }

        }

        model.value = ""

        model.value = "hello"

        wait(
            for: [
                promise1,
                promise2
            ],
            timeout: 10.0
        )

    }

}
