//
//  StateMachineTests.swift
//  TinyCoreTests
//
//  Created by Roy Hsu on 23/01/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

// MARK: - StateMachineTests

import XCTest

@testable import TinyCore

internal final class StateMachineTests: XCTestCase {

    internal final func testEnterValidState() {

        let promise = expectation(description: "Enter a valid state.")

        let stateMachine = StateMachine(initialState: DoorState.close)

        let handler = StubStateMachineHandler(
            didChangeStateFromOldToNew: { old, new in

                promise.fulfill()

                XCTAssertEqual(
                    old as? DoorState,
                    .close
                )

                XCTAssertEqual(
                    new as? DoorState,
                    .open
                )

                XCTAssertEqual(
                    stateMachine.currentState as? DoorState,
                    .open
                )

            }
        )

        stateMachine.delegate = handler

        stateMachine.enter(DoorState.open)

        wait(
            for: [ promise ],
            timeout: 10.0
        )

    }

}
