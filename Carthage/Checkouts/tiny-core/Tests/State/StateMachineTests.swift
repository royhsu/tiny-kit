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

        let stateMachine = StateMachine<StubStateMachineListener>(initialState: DoorState.close)

        let listener = StubStateMachineListener(
            didUpdateCurrentState: { event in

                promise.fulfill()

                XCTAssertEqual(
                    event as? StateMachineEvent,
                    .updateCurrentState
                )

                XCTAssertEqual(
                    stateMachine.currentState as? DoorState,
                    DoorState.open
                )

            }
        )

        stateMachine.eventManger.on(
            .updateCurrentState,
            emit: StubStateMachineListener.handleUpdateCurrentState,
            to: listener
        )

        DispatchQueue.main.async {

            do { try stateMachine.enter(DoorState.open) }
            catch { XCTFail("\(error)") }

        }

        wait(
            for: [ promise ],
            timeout: 10.0
        )

    }

    internal final func testEnterInvalidState() {

        let promise = expectation(description: "Enter a invalid state.")

        let stateMachine = StateMachine<StubStateMachineListener>(initialState: DoorState.close)

        let listener = StubStateMachineListener(
            didUpdateCurrentState: { _ in

                promise.fulfill()

                XCTFail("Should not update the current state.")

            }
        )

        stateMachine.eventManger.on(
            .updateCurrentState,
            emit: StubStateMachineListener.handleUpdateCurrentState,
            to: listener
        )

        DispatchQueue.main.async {

            let invalidState = DoorState.close

            do { try stateMachine.enter(invalidState) }
            catch {

                promise.fulfill()

                guard
                    case StateMachineError.invalidNextState(let state) = error
                else { XCTFail("Undefined error."); return }

                XCTAssertEqual(
                    state as? DoorState,
                    invalidState
                )

            }

        }

        wait(
            for: [ promise ],
            timeout: 10.0
        )

    }

}
