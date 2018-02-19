//
//  StateMachine.swift
//  TinyKitExample
//
//  Created by Roy Hsu on 19/02/2018.
//  Copyright © 2018 TinyWorld. All rights reserved.
//

public protocol State {

    func isValidNextState(_ state: State) -> Bool

}

public enum StateMachineError: Error {

    case invalidTransition(from: State, to: State)

}

public protocol StateMachineDelegate: class {

    func stateMachine(
        _ stateMachine: StateMachine,
        didChangeFrom old: State,
        to new: State
    )

}

public final class StateMachine {

    public private(set) final var currentState: State {

        didSet {

            delegate?.stateMachine(
                self,
                didChangeFrom: oldValue,
                to: currentState
            )

        }

    }

    public final weak var delegate: StateMachineDelegate?

    public init(initialState: State) { self.currentState = initialState }

}

public extension StateMachine {

    public final func enter(_ state: State) throws {

        guard
            currentState.isValidNextState(state)
        else {

            throw StateMachineError.invalidTransition(
                from: currentState,
                to: state
            )

        }

        currentState = state

    }

}
