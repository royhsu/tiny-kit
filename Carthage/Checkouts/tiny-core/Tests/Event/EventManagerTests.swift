//
//  EventManagerTests.swift
//  TinyCoreTests
//
//  Created by Roy Hsu on 23/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - EventManagerTests

import XCTest

@testable import TinyCore

internal final class EventManagerTests: XCTestCase {

    internal final func testTouchUpInsideEvent() {

        let promise = expectation(description: "Touch up inside event.")

        let manager = EventManager<TouchEvent, StubEventListener>()

        let listener = StubEventListener(
            didTouchUpInside: { event in

                promise.fulfill()

                XCTAssertEqual(
                    event as? TouchEvent,
                    .touchUpInside
                )

            }
        )

        manager.on(
            .touchUpInside,
            emit: StubEventListener.handleTouchUpInside,
            to: listener
        )

        DispatchQueue.main.async {

            manager.emit(.touchUpInside)

        }

        wait(
            for: [ promise ],
            timeout: 10.0
        )

    }

}
